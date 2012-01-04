#!/usr/bin/perl -w

use Irssi;

use vars qw($VERSION %IRSSI);
$VERSION = "0.1";
%IRSSI = (
    authors     => "Hiromi",
    contact     => "hiromi\@neesan.org",
    name        => "Choice script",
    description => "Choice bot",
    url         => "http:\/\/fun-at.the-circ.us",
    changed     => "040112"
);
#Usage !choose option1, option 2, option 3, optionN
use Irssi::Irc;
use strict;


#Only listen on channels listed below. Add more channels below
my @channels = ('#channel1', '#channel2', '#channel3');
sub choice{
#"message public", SERVER_REC, char *msg, char *nick, char *address, char *target
        my($server, $msg, $nick, $address, $target) = @_;

	#change trigger below
  if(grep(/^$target$/, @channels)){
        if($msg =~ /^!order/ ){
          $msg =~ s/!order //;
          $msg=~ s/\s//g;
          my @things = split(',', $msg);
          #shuffle the order of the choices
          my $response = join(', ', shuffle(@things));
          #output
          $server->command('msg '.$target.' '.$nick.' : '.$response.'!');
        }
        if($msg =~ /^!choose/ ){
                $msg =~ s/!choose //;
                $msg =~ s/\s//g; #remove extra whitespace
                #arguments passed in as one whole string, separate them by commas and store in array
                my @choices = split(',', $msg);
                my $range = @choices;
                #randomly choose a choice
                my $random = int(rand($range)) + 0;
                #output
                $server->command('msg '.$target.' '.$nick.' : '.$choices[$random].'!');
        }
  }
}


Irssi::signal_add("message public", "choice");
