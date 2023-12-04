#!/usr/bin/perl
use v5.35;
use List::Util qw/sum/;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my $total = 0;
my @copies;
while(<$input>) {
    if(/Card\s+(\d+): (.+) \| (.+)/) {
        my $card_num = $1 - 1;
        my $winning = $2;
        my $numbers = $3;

        if(exists($copies[$card_num])) {
            $copies[$card_num] += 1;
        } else {
            $copies[$card_num] = 1;
        }

        my @winning_numbers = split(" ", $winning);
        
        my $current_copies = $copies[$card_num];
        my $next_copy = $card_num + 1;
        foreach(split(" ", $numbers)){
            my $current_num = $_;
            foreach(@winning_numbers){
                if($current_num == $_) {
                    $copies[$next_copy] += $current_copies;
                    $next_copy += 1;
                }
            }
        }
    }
}

print sum(@copies) . "\n";

close $input or die "$input: $!";