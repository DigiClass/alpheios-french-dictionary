#!/usr/bin/perl
use strict;
use Data::Dumper;
use Unicode::UTF8 qw[decode_utf8 encode_utf8];


my $file = $ARGV[0];
open (my $eul, "<", "../../data/raw/alpheios/corrections/$file.csv") or die $!;
open (my $bailly, "<", "../../data/bailly-grc-defs.dat") or die $!;

my %corr;
while (<$eul>) {
  chomp;
  my ($lemma, $def) = split /\t/;
  $lemma = decode_utf8( $lemma);
  $corr{$lemma} = decode_utf8($def);
}

my %bailly;
while (<$bailly>) {
  chomp;
  my ($lemma, $def, $src) = split /\|/;
  $lemma = decode_utf8( $lemma);
  $bailly{$lemma} = [ decode_utf8($def), $src ];
}

for my $lemma (keys %corr) {
  my $orig = $lemma;
  if (lcfirst($lemma) ne $lemma) {
    $lemma = "@" . $lemma;
  }
  if ($bailly{$lemma}) {
    $bailly{$lemma}[0]  = $corr{$lemma};
  } else {
    warn "lemma not found $lemma\n";
    $bailly{$lemma}[0]  = $corr{$lemma};
    if ($orig ne $lemma) {
      $bailly{$orig} = ['@','Eulexis'];
    }
  }
}
close $bailly;

open FILE, ">", "../../data/bailly-grc-defs.dat" or die $!;
for my $lemma (sort keys %bailly) {
    print FILE encode_utf8($lemma);
    print FILE "|";
    print FILE encode_utf8($bailly{$lemma}[0]);
    print FILE "|";
    print FILE $bailly{$lemma}[1];
    print FILE "\n";
}
close FILE;


