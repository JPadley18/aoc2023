#!/usr/bin/perl
use v5.38;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @instructions;
my %maps;
while(<$input>) {
    if(/^([RL]+)$/){
        @instructions = split(//, $1);
    } elsif(/([A-Z]{3}) = \(([A-Z]{3}), ([A-Z]{3})\)/) {
        $maps{$1} = [$2, $3];
    }
}

my $current = "AAA";
my $steps = 0;
until($current eq "ZZZ") {
    my $next = $instructions[$steps % @instructions];
    my $next_i = $next eq "L" ? 0 : 1;
    $current = $maps{$current}->[$next_i];
    $steps++;
}

print "$steps\n";

close $input or die "$input: $!";