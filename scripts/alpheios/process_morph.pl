#!/usr/bin/perl
use strict;
use Encode qw/encode decode/;

open FILE, "< ../../raw_data/alpheios/morphresults.csv" or die $!;
my @morph;
my @propernoun;
my @other;
while (<FILE>) {
  chomp;
  my @cols = split /\t/;
  my $targetWord = decode('utf8',$cols[0]);
  my $defFound = $cols[2];
  my $lemma = decode('utf8',$cols[3]);
  my $lsjDef = decode('utf8',$cols[4]);
  $lsjDef = '' if $lsjDef eq 'no';
  if ($lsjDef) {
    my $reason;
    if ($targetWord =~ /\d$/ && lcfirst($targetWord) ne substr $targetWord, 0, 1) {
      push @propernoun, [$targetWord, $lemma, $lsjDef];
    } elsif ($lemma ne $targetWord) {
      push @morph, [$targetWord, $lemma, $lsjDef];
    } else {
      push @other, [$targetWord, $lemma, $lsjDef];
    }
  }
}

open FILE, ">../raw_data/alpheios/morphdiff.csv";
for my $word (@morph) {
  print FILE encode('utf8',join "\t", @$word);
  print FILE "\n";
}
close FILE;

open FILE, ">../raw_data/alpheios/propernouns.csv";
for my $word (@propernoun) {
  print FILE encode('utf8',join "\t", @$word);
  print FILE "\n";
}
close FILE;

if (@other) {
  open FILE, ">../raw_data/alpheios/other.csv";
  for my $word (@other) {
    print FILE encode('utf8',join "\t", @$word);
    print FILE "\n";
  }
  close FILE;
}

