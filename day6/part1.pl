#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @times;
my @distances;
while(<$input>) {
    if(/^Time:\s+(\d.+)/) {
        @times = split(/\s+/, $1);
    } elsif(/^Distance:\s+(\d.+)/) {
        @distances = split(/\s+/, $1);
    }
}

die("Time and distance arrays are not of equal length") if @times != @distances;

my $total = 1;
for my $i (0..$#times) {
    my $total_time = $times[$i];
    my $record_distance = $distances[$i];
    my $ways_to_win = 0;

    for my $j (0..$total_time) {
        if(calc_distance($j, $total_time) > $record_distance) {
            $ways_to_win += 1;
        }
    }
    $total *= $ways_to_win;
}

print "$total\n";

sub calc_distance {
    my ( $millis_held, $total_time ) = @_;

    return $millis_held * ($total_time - $millis_held);
}

close $input or die "$input: $!";