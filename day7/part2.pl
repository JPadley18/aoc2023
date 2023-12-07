#!/usr/bin/perl
use v5.35;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @hand_type_order = (
    [5, 0],
    [4, 1],
    [3, 2],
    [3, 0],
    [2, 2],
    [2, 0],
    [1, 0],
);

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
        my $first = $counts{$ordered[-1]} + $jokers;
        my $second = exists($ordered[-2]) ? $counts{$ordered[-2]} : 0;
        
        push @{$hand_type_groups[hand_type($first, $second)]}, [$hand, $score];
    }
}

my $total = 0;
my $rank = $num_cards;
foreach my $hand_group (@hand_type_groups) {
    foreach my $hand_score (sort { encode($a->[0]) cmp encode($b->[0]) } @{$hand_group}) {
        my $score = $hand_score->[1];
        $total += $score * $rank;
        $rank--;
    }
}

print "$total\n";

sub hand_type {
    my ( $first, $second ) = @_;
    my $i = 0;
    foreach my $type_ref (@hand_type_order) {
        if($first >= $type_ref->[0] && $second >= $type_ref->[1]) {
            return $i;
        }
        $i++;
    }
    return $#hand_type_order;
}

# I love regexes
sub encode {
    my $str = shift;
    $str =~ tr/AKQT987654321J/A-N/;
    return $str;
}

close $input or die "$input: $!";