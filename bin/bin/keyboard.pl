#!/usr/bin/env perl
use warnings;use strict;
sub trim {my $string = shift;$string =~ s/^\s+//;$string =~ s/\s+$//;return $string;}
my $Step=25;
my $MaxBright=trim(`cat '/sys/class/leds/smc::kbd_backlight/max_brightness'`);
my $CurBright=trim(`cat '/sys/class/leds/smc::kbd_backlight/brightness'`);
my $NewBright;
if(exists $ARGV[0]){
    if($ARGV[0] eq 'up'){$NewBright=$CurBright+$Step;$NewBright=$MaxBright if $NewBright>$MaxBright;}
    elsif($ARGV[0] eq 'down'){$NewBright=$CurBright-$Step;$NewBright=0 if $NewBright<0;}
    elsif($ARGV[0] eq 'off'){$NewBright=0;}
    else{print "Incorrect parameters. Usage: keyboard.pl (up|down|off)\n";exit;}
}else{print "Usage: keyboard.pl (up|down|off)\n";exit;}
print "Setting brightness to $NewBright. Old brghtness: $CurBright; Max value: $MaxBright.\n";
system "echo $NewBright > '/sys/class/leds/smc::kbd_backlight/brightness'";
1;
