#!/usr/bin/perl
use v5.38;
use threads;

my $thr = threads->create(\&check_range, (10, 69));
print $thr->join();

sub check_range {
    my ($seed_start, $seed_end) = @_;
    print "$seed_start - $seed_end\n";
    return $seed_end - $seed_start;
}