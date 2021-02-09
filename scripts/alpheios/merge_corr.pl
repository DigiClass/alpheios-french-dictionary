#!/usr/bin/perl
use strict;
use Data::Dumper;
use Unicode::UTF8 qw[decode_utf8 encode_utf8];


my $file = $ARGV[0];
open (my $eul, "<", "../../data/raw/alpheios/corrections/$file.csv") or die $!;
open (my $bailly, "<", "../../data/bailly-grc-defs.dat") or die $!;

my $fa;
my %corr;
while (<$eul>) {
  chomp;
  my ($lemma, $def) = split /\t/;
  $def = decode_utf8($def);
  my @defs = split /\|/, $def;
  next unless $lemma;
  $lemma = decode_utf8( $lemma);
  $corr{$lemma} = \@defs;
}

my %bailly;
while (<$bailly>) {
  chomp;
  my ($lemma, $def, $src) = split /\|/;
  $lemma = decode_utf8( $lemma);
  $bailly{$lemma}{'def'} = [decode_utf8($def)];
  $bailly{$lemma}{'src'} = $src;
}

for my $lemma (keys %corr) {
  my $orig = $lemma;
  if ((ucfirst($orig) eq $orig)) {
    if ($bailly{lcfirst($orig)} && $bailly{lcfirst($orig)}{'def'}[0] eq '@') {
      $lemma = '@' . $lemma;
    } else {
      warn ("Possible incorrect capital: " . encode_utf8($lemma) . ":" . (join " ", map { encode_utf8($_) } @{$bailly{$lemma}{'def'}}) );
    }
  }
  if ($bailly{$lemma}) {
    $bailly{$lemma}{'def'} = $corr{$orig};
    $bailly{$lemma}{'src'}  = "Bailly,Eulexis";
  } else {
    $bailly{$lemma}{'def'}  = $corr{$orig};
    $bailly{$lemma}{'src'}  = "Bailly,Eulexis";
  }
}
close $bailly;

open FILE, ">", "../../data/bailly-grc-defs.dat" or die $!;
for my $lemma (sort keys %bailly) {
    my $def = $bailly{$lemma}{'def'};
    my $src = $bailly{$lemma}{'src'};
    for my $defx (@{$def}) {
      if ($defx) {
        $defx =~ s/^\s+//;
        $defx =~ s/\s+$//;
        print FILE encode_utf8($lemma);
        print FILE "|";
        print FILE encode_utf8($defx);
        print FILE "|";
        print FILE $src;
        print FILE "\n";
      }
    }
}
close FILE;


