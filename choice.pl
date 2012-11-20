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
          my @things = split(',', $msg);
          my @fch;
          foreach my $ch (@things){
            $ch =~ s/^ //;
            push (@fch, $fch);
          }
          #shuffle the order of the choices
          my $response = join(', ', shuffle(@fch));
          #output
          $server->command('msg '.$target.' '.$nick.' : '.$response.'!');
        }
        if($msg =~ /^!choose/ ){
                $msg =~ s/!choose //;
                #arguments passed in as one whole string, separate them by commas and store in array
                my @choices = split(',', $msg);
                my $range = @choices;
                my @fch;
                foreach my $ch (@choices){
                  $ch =~ s/^ //;
                  push (@fch, $ch);
                }
                #randomly choose a choice
                my $random = int(rand($range)) + 0;
                #output
                $server->command('msg '.$target.' '.$nick.' : '.$fch[$random].'!');
        }
  }
}


Irssi::signal_add("message public", "choice");
