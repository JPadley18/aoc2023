#!/usr/bin/perl
use v5.35;
use threads;
use List::Util qw( min );

open(my $input, "<", "input.txt") or die "Can't open puzzle input: $!";

my @seeds;
my @maps;
my $current_map = -1;
while(<$input>) {
    if(/^seeds:\s+(.+)\n/) {
        @seeds = split(/\s+/, $1);
    } elsif(/map:\n$/) {
        $current_map += 1;
    } elsif(/(\d.+)/) {
        my @map_entry = split(/\s+/, $1);
        if(exists($maps[$current_map])) {
            push(@{$maps[$current_map]}, \@map_entry);
        } else {
            $maps[$current_map] = [\@map_entry];
        }
    }
}

sub check_range {
    my ($seed_start, $seed_end) = @_;

    print "Started thread for $seed_start - $seed_end\n";

    my $lowest = "inf";
    foreach my $category ($seed_start..$seed_end) {
        foreach my $map_list (@maps) {
            foreach my $map (@{$map_list}) {
                my @map = @{$map};
                my $dest_start = $map[0];
                my $src_start = $map[1];
                my $range = $map[2];

                if($category >= $src_start && $category < $src_start + $range) {
                    # Found a matching mapping
                    $category = $dest_start + ($category - $src_start);
                    last;
                }
            }
        }
        if($category < $lowest) {
            $lowest = $category;
        }
    }

    print "Thread for $seed_start - $seed_end returned $lowest\n";

    return $lowest;
}

my @workers;
for(my $i = 0; $i < @seeds; $i += 2) {
    my $seed_start = $seeds[$i];
    my $seed_end = $seed_start + $seeds[$i + 1] - 1;
    push(@workers, threads->create(\&check_range, ($seed_start, $seed_end)));
}

my @results;
foreach(@workers) {
    push(@results, $_->join());
}

print "MINUMUM: " . min(@results) . "\n";

close $input or die "$input: $!";