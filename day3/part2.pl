#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @lines = <$input>;

my %gears;

for my $i (0..$#lines) {
    while($lines[$i] =~ /(\d+)/g) {
        my $number = $1;
        my $start = $-[1] > 0 ? $-[1] - 1 : 0;
        my $length = $+[1] - $start + 1;

        my $first = $i > 0 ? $i - 1 : 0;
        my $last = $i < $#lines ? $i + 1 : $#lines;

        for my $j ($first..$last) {
            my $region = substr($lines[$j], $start, $length);
            if($region =~ /(\*)/g) {
                my $global_pos = $start + pos($region);
                my $hash = "$j/$global_pos";
                if($gears{$hash}) {
                    push @{$gears{$hash}}, $number;
                } else {
                    $gears{$hash} = [$number];
                }
            }
        }
    }
}

my $total = 0;
for(keys %gears) {
    my @items = @{$gears{$_}};
    if(@items == 2) {
        $total += $items[0] * $items[1];
    }
}

print "$total\n";

close $input or die "$input: $!";