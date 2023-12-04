#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $total = 0;
while(<$input>) {
    if(/Card\s+\d+: (.+) \| (.+)/) {
        my $winning = $1;
        my $numbers = $2;

        my @winning_numbers = split(" ", $winning);
        
        my $subtotal = 0;
        foreach(split(" ", $numbers)){
            my $current_num = $_;
            foreach(@winning_numbers){
                if($current_num == $_) {
                    $subtotal = $subtotal > 0 ? $subtotal * 2 : 1;
                    last;
                }
            }
        }
        $total += $subtotal;
    }
}

print "$total\n";

close $input or die "$input: $!";