#!/usr/bin/perl
use v5.38;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $total = 0;
while(<$input>) {
    my @line = split;
    $total += extrapolate(@line);
}

print "$total\n";

sub extrapolate {
    my @set = @_;

    if(grep(/^0$/, @set) == @set) {
        return 0;
    }

    my @diffs;
    for my $i (0..$#set - 1) {
        push @diffs, $set[$i + 1] - $set[$i];
    }
    return extrapolate(@diffs) + $set[-1];
}

close $input or die "$input: $!";