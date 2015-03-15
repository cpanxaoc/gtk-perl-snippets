                                                                                                                                                                                                                                                               
Delivered-To: cpan@xaoc.org
Received: by 10.96.111.170 with SMTP id ij10csp1203004qdb;
        Fri, 13 Mar 2015 14:41:35 -0700 (PDT)
X-Received: by 10.70.123.131 with SMTP id ma3mr78851892pdb.16.1426282894342;
        Fri, 13 Mar 2015 14:41:34 -0700 (PDT)
Return-Path: <gtk-perl-list-bounces@gnome.org>
Received: from restaurant.gnome.org (smtp.gnome.org. [209.132.180.187])
        by mx.google.com with ESMTP id d3si6220045pdb.225.2015.03.13.14.41.33
        for <cpan@xaoc.org>;
        Fri, 13 Mar 2015 14:41:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of gtk-perl-list-bounces@gnome.org designates 209.132.180.187 as permitted sender) client-ip=209.132.180.187;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gtk-perl-list-bounces@gnome.org designates 209.132.180.187 as permitted sender) smtp.mail=gtk-perl-list-bounces@gnome.org;
       dkim=neutral (body hash did not verify) header.i=@;
       dmarc=fail (p=NONE dis=NONE) header.from=gmail.com
Received: from restaurant.gnome.org (localhost.localdomain [127.0.0.1])
	by restaurant.gnome.org (Postfix) with ESMTP id BB59576AC1;
	Fri, 13 Mar 2015 21:41:32 +0000 (UTC)
X-Original-To: gtk-perl-list@gnome.org
Delivered-To: gtk-perl-list@gnome.org
Received: from localhost (localhost.localdomain [127.0.0.1])
	by restaurant.gnome.org (Postfix) with ESMTP id 1BFE576ABF
	for <gtk-perl-list@gnome.org>; Fri, 13 Mar 2015 21:41:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at gnome.org
X-Spam-Flag: NO
X-Spam-Score: -2.7
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 tagged_above=-999 required=2
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
	SPF_PASS=-0.001] autolearn=ham
Received: from restaurant.gnome.org ([127.0.0.1])
	by localhost (restaurant.gnome.org [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id VJuafgXm0yCR for <gtk-perl-list@gnome.org>;
	Fri, 13 Mar 2015 21:41:27 +0000 (UTC)
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
	[209.85.160.172])
	by restaurant.gnome.org (Postfix) with ESMTP id 4397D76A47
	for <gtk-perl-list@gnome.org>; Fri, 13 Mar 2015 21:41:16 +0000 (UTC)
Received: by ykq142 with SMTP id 142so11731386ykq.7
	for <gtk-perl-list@gnome.org>; Fri, 13 Mar 2015 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=QdNqgXdmiQlC+PDlv+eKqOBCKYgLeAwwfJFfSW3UBv8=;
	b=Rg7VAbSTLVom6PDKG3MYJdsBf4RDi02DeDO/m1bOf1p9LScjBeURz6kn3lS3KcXvPY
	CY2OlwX0OXYeUBXOKko/O4rqgMPOsYO305hDGiu306mMyYaeeT9ib8z2QQsHtAlu/TEJ
	FiPpoZW1qgDs4VJEZpb/JHJtJLFIboJYO3++2aOo/0MWRSpc9qIPdhMGO9g4E4BxOOMQ
	v4+N/Jbs8JQp/BLy5YXEdHkSg1AX78K5zYNH08bCJGwAFZ9CKnYwJBQpqmmtLB/8owET
	Qd2uUvFnz69BOJH+xmlPKhH60nnlcZpdF4uYpNSyomuU/blxqufgVapQTOHu5aeXxajc
	MctQ==
MIME-Version: 1.0
X-Received: by 10.236.23.196 with SMTP id v44mr48763724yhv.196.1426282874759; 
	Fri, 13 Mar 2015 14:41:14 -0700 (PDT)
Received: by 10.170.48.198 with HTTP; Fri, 13 Mar 2015 14:41:14 -0700 (PDT)
Date: Fri, 13 Mar 2015 22:41:14 +0100
Message-ID: <CACg2wby_N9-UmCY5xzJbrdFM3mD1vy2hYBVsWA48QNVN3=k+EA@mail.gmail.com>
Subject: Signals & MacOS
From: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
To: "gtk-perl-list@gnome.org List" <gtk-perl-list@gnome.org>
X-BeenThere: gtk-perl-list@gnome.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Using GTK+ with Perl <gtk-perl-list.gnome.org>
List-Unsubscribe: <https://mail.gnome.org/mailman/options/gtk-perl-list>,
	<mailto:gtk-perl-list-request@gnome.org?subject=unsubscribe>
List-Archive: <https://mail.gnome.org/archives/gtk-perl-list/>
List-Post: <mailto:gtk-perl-list@gnome.org>
List-Help: <mailto:gtk-perl-list-request@gnome.org?subject=help>
List-Subscribe: <https://mail.gnome.org/mailman/listinfo/gtk-perl-list>,
	<mailto:gtk-perl-list-request@gnome.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: gtk-perl-list-bounces@gnome.org
Sender: "gtk-perl-list" <gtk-perl-list-bounces@gnome.org>

Now, at last with a small working example. The following code works
fine on Linux, but on MacOS:

a. the gui does not seem to respond to the "hup" signal from the subprocess
b. gets far more "in" signals than it should

Unfortunately, the above description is secondhand, as I do not have
access to a Mac.

I would be very glad if somebody could give me a clue how to get
things working under both operating systems.

Regards

Jeff

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
_______________________________________________
gtk-perl-list mailing list
gtk-perl-list@gnome.org
https://mail.gnome.org/mailman/listinfo/gtk-perl-list
