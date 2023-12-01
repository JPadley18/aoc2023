#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my %mapping = (
    one => "1",
    two => "2",
    three => "3",
    four => "4",
    five => "5",
    six => "6",
    seven => "7",
    eight => "8",
    nine => "9",
    zero => "0"
);

my $total = 0;
while(<$input>) {
    my @numbers = $_ =~ /(?=(\d|zero|one|two|three|four|five|six|seven|eight|nine))/g;
    my @digits = map { $mapping{$_} // $_ } @numbers;
    $total += $digits[0] . $digits[-1];
}

print $total . "\n";

close $input or die "$input: $!";