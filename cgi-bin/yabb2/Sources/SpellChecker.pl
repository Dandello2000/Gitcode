#!/usr/bin/perl --
# $Id: yabbspellchecker $
# $HeadURL: testbed $
# $Revision: 2012 $
# $Source: /SpellChecker.pl $
###############################################################################
# SpellChecker.pl                                                             #
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

$spellcheckerplver = 'YaBB 2.6 $Revision: 1.0 $';

if ( $action eq 'detailedversion' ) { return 1; }

# Take the following comment out to see the error message if you
# call the script directly from a new window of your browser
# use CGI::Carp qw(fatalsToBrowser);

use LWP::UserAgent;
use HTTP::Request::Common;

my $ua = LWP::UserAgent->new( agent => 'GoogieSpell Client' );
my $reqXML = "";

read( STDIN, $reqXML, $ENV{'CONTENT_LENGTH'} );

my $url = "https://www.google.com/tbproxy/spell?$ENV{QUERY_STRING}";
my $res =
  $ua->request( POST $url, Content_Type => 'text/xml', Content => $reqXML );

die "$res->{_content}" if $res->{_content} =~ /LWP.+https.+Crypt::SSLeay/;

print "Content-Type: text/xml\n\n";
print $res->{_content};

1;
