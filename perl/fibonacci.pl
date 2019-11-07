#!/bin/perl
use strict;
use warnings;
use Benchmark qw(:all);

sub f {
  my ($n) = @_;
  if ($n < 2){
    return $n
  }
  else {
    return &f($n-1) + &f($n-2)
  }
}

timethis 1, sub{print('' . &f(34) . "\n")}
