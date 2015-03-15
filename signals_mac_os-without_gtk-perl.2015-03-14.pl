#!/usr/bin/perl

use warnings;
use strict;
use Gtk2 -init;
use Glib qw(TRUE FALSE);    # To get TRUE and FALSE
use POSIX qw(locale_h :signal_h :errno_h :sys_wait_h);
use IPC::Open3;
use IO::Handle;
use Readonly;
Readonly my $_POLL_INTERVAL => 100;    # ms
Readonly my $_1KB           => 1024;
my $EMPTY = q{};

# Create the windows
my $window  = Gtk2::Window->new('toplevel');
my $box     = Gtk2::VBox->new;
my $entry   = Gtk2::Entry->new;
my $pbar    = Gtk2::ProgressBar->new;
my $qbutton = Gtk2::Button->new('Quit');
my $sbutton = Gtk2::Button->new('Start');

$window->add($box);
$box->add($pbar);
$box->add($qbutton);
$box->add($sbutton);

# We should also link this to the destroy message on the main window,
# this is just quick and dirty
$qbutton->signal_connect( clicked => sub { Gtk2->main_quit } );
$sbutton->signal_connect( clicked => \&start_process );
$window->show_all;
Gtk2->main;

sub start_process {
    watch_cmd(
        cmd              => 'for i in `seq 1 5`; do echo $i; sleep 1; done',
        running_callback => sub {
            $pbar->pulse;
        },
        started_callback => sub {
            $pbar->set_text('Started');
        },
        out_callback => sub {
            my ($line) = @_;
            $pbar->set_text($line);
        },
        err_callback => sub {
            my ($line) = @_;
            $pbar->set_text("Error: $line");
        },
        finished_callback => sub {
            $pbar->set_text('Finished');
        },
    );
    return;
}

sub watch_cmd {
    my (%options) = @_;

    my $out_finished = FALSE;
    my $err_finished = FALSE;
    my $error_flag   = FALSE;
    print "$options{cmd}\n";

    if ( defined $options{running_callback} ) {
        my $timer = Glib::Timeout->add(
            $_POLL_INTERVAL,
            sub {
                $options{running_callback}->();
                return Glib::SOURCE_REMOVE
                  if ( $out_finished or $err_finished );
                return Glib::SOURCE_CONTINUE;
            }
        );
    }

    my ( $write, $read );
    my $error = IO::Handle->new;
    my $pid = IPC::Open3::open3( $write, $read, $error, $options{cmd} );
    print "Forked PID $pid\n";

    if ( defined $options{started_callback} ) { $options{started_callback}->() }
    my ( $stdout, $stderr, $error_message );

    add_watch(
        $read,
        sub {
            my ($line) = @_;
            $stdout .= $line;
            if ( defined $options{out_callback} ) {
                $options{out_callback}->($line);
            }
        },
        sub {

          # Don't flag this until after the callback to avoid the race condition
          # where stdout is truncated by stderr prematurely reaping the process
            $out_finished = TRUE;
        },
        sub {
            ($error_message) = @_;
            $error_flag = TRUE;
        }
    );
    add_watch(
        $error,
        sub {
            my ($line) = @_;
            $stderr .= $line;
            if ( defined $options{err_callback} ) {
                $options{err_callback}->($line);
            }
        },
        sub {

          # Don't flag this until after the callback to avoid the race condition
          # where stderr is truncated by stdout prematurely reaping the process
            $err_finished = TRUE;
        },
        sub {
            ($error_message) = @_;
            $error_flag = TRUE;
        }
    );

    # Watch for the process to hang up before running the finished callback
    Glib::Child->watch_add(
        $pid,
        sub {

          # Although the process has hung up, we may still have output to read,
          # so wait until the _watch_add flags that the process has ended first.
            my $timer = Glib::Timeout->add(
                $_POLL_INTERVAL,
                sub {
                    if ($error_flag) {
                        if ( defined $options{error_callback} ) {
                            $options{error_callback}->($error_message);
                        }
                        return Glib::SOURCE_REMOVE;
                    }
                    elsif ( $out_finished and $err_finished ) {

                        if ( defined $options{finished_callback} ) {
                            $options{finished_callback}->( $stdout, $stderr );
                        }
                        print "Waiting to reap process\n";

             # -1 indicates a non-blocking wait for all pending zombie processes
                        print 'Reaped PID ', waitpid(
                            -1,    ## no critic (ProhibitMagicNumbers)
                            WNOHANG
                          ),
                          "\n";
                        return Glib::SOURCE_REMOVE;
                    }
                    return Glib::SOURCE_CONTINUE;
                }
            );
        }
    );
    return;
}

sub add_watch {
    my ( $fh, $line_callback, $finished_callback, $error_callback ) = @_;
    my $line;
    Glib::IO->add_watch(
        fileno($fh),
        [ 'in', 'hup' ],
        sub {
            my ( $fileno, $condition ) = @_;
            my $buffer;
            if ( $condition & 'in' ) { # bit field operation. >= would also work

                # For Linux, this "if" should always return true, as the
                # callback is only triggered when there is data to read.
                # MacOS seems to trigger this callback even when there is
                # nothing to read, and therefore we need this conditional
                # Only reading one buffer, rather than until sysread gives EOF
                # because things seem to be strange for stderr
                if ( sysread $fh, $buffer, $_1KB ) {
                    if ($buffer) { $line .= $buffer }

                    while ( $line =~ /([\r\n])/xsm ) {
                        my $le = $1;
                        if ( defined $line_callback ) {
                            $line_callback->(
                                substr $line, 0, index( $line, $le ) + 1
                            );
                        }
                        $line = substr $line, index( $line, $le ) + 1,
                          length $line;
                    }
                }
            }

            # Only allow the hup if sure an empty buffer has been read.
            if (
                ( $condition & 'hup' ) # bit field operation. >= would also work
                and ( not defined $buffer or $buffer eq $EMPTY )
              )
            {
                if ( close $fh ) {
                    $finished_callback->();
                }
                elsif ( defined $error_callback ) {
                    $error_callback->('Error closing filehandle');
                }
                return Glib::SOURCE_REMOVE;
            }
            return Glib::SOURCE_CONTINUE;
        }
    );
    return;
}
