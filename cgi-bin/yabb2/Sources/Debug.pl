###############################################################################
# Debug.pl                                                                    #
# $Date: 9/20/2012 $                                                          #
###############################################################################
# YaBB: Yet another Bulletin Board                                            #
# Open-Source Community Software for Webmasters                               #
# Version:        YaBB 2.6                                                    #
# Packaged:       January 1, 2013                                             #
# Distributed by: http://www.yabbforum.com                                    #
# =========================================================================== #
# Copyright (c) 2000-2012 YaBB (www.yabbforum.com) - All Rights Reserved.     #
# Software by:  The YaBB Development Team                                     #
#               with assistance from the YaBB community.                      #
###############################################################################
# use strict;
# use warnings;
no warnings qw(uninitialized once redefine);
use CGI::Carp qw(fatalsToBrowser);
use English '-no_match_vars';
our $VERSION = 1.0;

$debugplver = 'YaBB 2.6 $Revision: 1.0 $';

sub Debug {
    if ( $debug == 1 or ( $debug == 2 && $iamadmin ) ) {
        $yyfileactions =
"$debug_txt{'opened'} $file_open $debug_txt{'closed'} $file_close $debug_txt{'equal'}";

        my $yytimeclock;
        my $time_running = time - $START_TIME;
        if ( $time_running == int($time_running) ) {
            $yytimeclock =
              "$debug_txt{'nohires'} Time::Hires $debug_txt{'nomodule'}<br />";
        }
        else {
            $time_running = sprintf( "%.4f", $time_running );
        }
        $yytimeclock .=
          "$debug_txt{'pagespeed'} $time_running $debug_txt{'loaded'}.";

        &ToHTML($openfiles);
        $openfiles =~ s/\n/<br \/>/g;

        $yydebug =
qq~<br /><div class="small" style="float: left; padding: 0px; width: 99%; margin-left: 0px; margin-right: auto;"><u>$debug_txt{'debugging'}</u><br /><br /><u>$debug_txt{'benchmarking'}:</u><br />$yytimeclock<br /><br /><u>$debug_txt{'ipaddress'}:</u><br />$user_ip<br /><br /><u>$debug_txt{'browser'}:</u><br />$ENV{'HTTP_USER_AGENT'}<br />$getpairs<br /><u>$debug_txt{'trace'}:</u>$yytrace<br /><br /><u>$debug_txt{'check'}:</u><br />$yyfileactions<br /><br /><u>$debug_txt{'filehandles'}:</u><br />$debug_txt{'filehandleslegend'}<br /><br />$openfiles<br /><u>$debug_txt{'filesloaded'}:<tt>require</tt></u>~;

        foreach ( sort( keys(%INC) ) ) { $yydebug .= qq~<br />$_ => $INC{$_}~; }

        $yydebug .= qq~<br /><br /><br /></div>~;
    }
}

1;
