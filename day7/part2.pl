#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @hand_type_groups;
my $num_cards = 0;
while(<$input>) {
    if(/^(.{5})\s+(\d+)/) {
        my $hand = $1;
        my $score = $2;
        $num_cards++;
        my %counts;
        foreach my $char (split(//, $hand)) {
            $counts{$char} = length( $hand =~ s/[^\Q$char\E]//rg ) if !exists($counts{$char});
        }
        my $jokers = $counts{'J'} // 0;
        # Don't count jokers as their own group
        $counts{'J'} = 0 if exists($counts{'J'});
        # Find the highest counts
        my @ordered = sort { $counts{$a} <=> $counts{$b} } keys %counts;
        my $highest = $counts{$ordered[-1]} + $jokers;

        if($highest == 5) {
            push @{$hand_type_groups[0]}, [$hand, $score];
        } elsif($highest == 4) {
            push @{$hand_type_groups[1]}, [$hand, $score];
        } elsif($highest == 3) {
            if($counts{$ordered[-2]} == 2) {
                push @{$hand_type_groups[2]}, [$hand, $score];
            } else {
                push @{$hand_type_groups[3]}, [$hand, $score];
            }
        } elsif($highest == 2) {
            if($counts{$ordered[-2]} == 2) {
                push @{$hand_type_groups[4]}, [$hand, $score];
            } else {
                push @{$hand_type_groups[5]}, [$hand, $score];
            }
        } else {
            push @{$hand_type_groups[6]}, [$hand, $score];
        }
    }
}

my $total = 0;
my $rank = $num_cards;
foreach my $hand_group (@hand_type_groups) {
    foreach my $hand_score (sort { encode(@{$a}[0]) cmp encode(@{$b}[0]) } @{$hand_group}) {
        my $score = @{$hand_score}[1];
        $total += $score * $rank;
        $rank--;
    }
}

print "$total\n";

# I love regexes
sub encode {
    my $str = shift;
    $str =~ tr/AKQT987654321J/A-N/;
    return $str;
}

close $input or die "$input: $!";