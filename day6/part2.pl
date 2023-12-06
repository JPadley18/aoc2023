#!/usr/bin/perl
use v5.35;
use POSIX qw/floor ceil/;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $time;
my $distance;
while(<$input>) {
    if(/^Time:\s+(\d.+)/) {
        $time = join("", split(/\s+/, $1));
    } elsif(/^Distance:\s+(\d.+)/) {
        $distance = join("", split(/\s+/, $1));
    }
}

my ( $x1, $x2 ) = calc_distance_range($time, $distance);
my $solution = $x2 - $x1 + 1;
print "$solution\n";

sub calc_distance_range {
    my ( $total_time, $record_distance ) = @_;

    # We meet again, old friend
    my $x1 = (-$total_time + sqrt($total_time**2 - 4*-1*-$record_distance)) / -2;
    my $x2 = (-$total_time - sqrt($total_time**2 - 4*-1*-$record_distance)) / -2;

    return ( ceil($x1), floor($x2) );
}

close $input or die "$input: $!";