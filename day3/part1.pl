#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @lines = <$input>;

my $total = 0;
for my $i (0..$#lines) {
    while($lines[$i] =~ /(\d+)/g) {
        my $number = $1;
        my $start = $-[1] > 0 ? $-[1] - 1 : 0;
        my $length = $+[1] - $start + 1;

        my $first = $i > 0 ? $i - 1 : 0;
        my $last = $i < $#lines ? $i + 1 : $#lines;

        for my $j ($first..$last) {
            my $region = substr($lines[$j], $start, $length);
            if($region =~ /(?[ \W - [\.\n] ])/) {
                $total += $number;
            }
        }
    }
}

print "Total: $total\n";

close $input or die "$input: $!";