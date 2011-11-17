#!/usr/bin/perl -w

use Irssi;

use vars qw($VERSION %IRSSI);
$VERSION = "0.1";
%IRSSI = (
    authors     => "Hiromi",
    contact     => "hiromi\@neesan.org",
    name        => "Choice script",
    description => "Choice bot",
    license     => "Free",
    url         => "http:\/\/fun-at.the-circ.us",
    changed     => "nil"
);
#Usage !choose option1, option 2, option 3, optionN
use Irssi::Irc;
use strict;


#"message public", SERVER_REC, char *msg, char *nick, char *address, char *target
sub choice{
        my($server, $msg, $nick, $address, $target) = @_;

	#change trigger below
        if($msg =~ /^!choose/ ){
                $msg =~ s/!choose //;
                

                my @choices = split(',', $msg);
                my $range = @choices;
                my @fch;
                #clean up extra space
                foreach my $ch(@choices){
                        $ch =~ s/^ //;
                        push(@fch, $ch);
                }

                my $random = int(rand($range)) + 0;
		#Only listen on channels listed below. Add more channels below
                if($target eq '#channel' || $target eq '#channel1' || $target eq '#channelN'){
                        $server->command('msg '.$target.' '.$nick.' : '.$fch[$random].'!');
                }
                }
}


Irssi::signal_add("message public", "choice");