#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my %MAXES = (
    red => 12,
    green => 13,
    blue => 14,
);

my $total = 0;
while(<$input>) {
    if($_ =~ /Game (\d+): (.+)\s/g) {
        my $game_id = $1;
        my $possible = 1;

        my $line = $2;
        while(($line =~ /(\d+) (red|green|blue)/g) && $possible) {
            if($MAXES{$2} < $1) {
                $possible = 0;
                next;
            }
        }

        if($possible) {
            $total += $game_id;
        }
    }
}

print $total . "\n";

close $input or die "$input: $!";