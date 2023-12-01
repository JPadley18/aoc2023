#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $total = 0;
while(<$input>) {
    my @digits = ( $_ =~ /(\d)/g );
    $total += $digits[0] . $digits[-1];
}

print $total . "\n";

close $input or die "$input: $!";