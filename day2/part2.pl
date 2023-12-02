#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $total = 0;
while(<$input>) {
    if($_ =~ /Game (\d+): (.+)\s/g) {
        my $game_id = $1;
        my $possible = 1;

        my %maxes = (
            red => 0,
            blue => 0,
            green => 0,
        );
        
        my $line = $2;
        while($line =~ /(\d+) (red|green|blue)/g) {
            $maxes{$2} = $1 if $1 > $maxes{$2};
        }

        $total += $maxes{"red"} * $maxes{"blue"} * $maxes{"green"};
    }
}

print $total . "\n";

close $input or die "$input: $!";