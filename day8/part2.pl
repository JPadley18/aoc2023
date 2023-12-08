#!/usr/bin/perl
use v5.38;

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @instructions;
my %maps;
my @search_list;
while(<$input>) {
    if(/^([RL]+)$/){
        @instructions = split(//, $1);
    } elsif(/([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)/) {
        my $id = $1;
        $maps{$id} = [$2, $3];
        if($id =~ /A$/) {
            push @search_list, $id;
        }
    }
}

my @results;
foreach my $current (@search_list) {
    my $steps = 0;
    until($current =~ /Z$/) {
        my $next = $instructions[$steps % @instructions];
        my $next_i = $next eq "L" ? 0 : 1;
        $current = $maps{$current}->[$next_i];
        $steps++;
    }
    push @results, $steps;
}

my $answer = $results[0];
for my $i (1..$#results) {
    my $a = $answer;
    my $b = $results[$i];
    $answer = ($a * $b) / gcd($a, $b);
}

sub gcd {
    my ( $a, $b ) = @_;
    return $a if $b == 0;
    return gcd($b, $a % $b);
}

print "$answer\n";

close $input or die "$input: $!";