#!/usr/bin/perl
use strict;
use Data::Dumper;
use Unicode::UTF8 qw[decode_utf8 encode_utf8];


open (my $logeion, "<", "../../data/raw/alpheios/logeion") or die $!;
open (my $lsj, "<", "../../../lsj/dat/grc-lsj-defs.dat") or die $!;
open (my $eul_to_lsj, "<", "../../data/raw/alpheios/eul_to_lsj.csv") or die $!;

my %log;
my %lsj;

while (<$lsj>) {
  chomp;
  my ($lemma, $def) = split /\|/;
  $lemma = decode_utf8( $lemma);
  $lsj{$lemma} = decode_utf8($def);
}

while (<$logeion>) {
  chomp;
  my ($lemma, $def) = split /\t/;
  $lemma = decode_utf8($lemma);
  $def = decode_utf8($def);
  if (lcfirst($lemma) ne $lemma) {
    $log{lcfirst($lemma)} = '@';
    $log{'@' . $lemma} = $def;
  } else {
    $log{$lemma} = $def;
  }
}

open (my $DIFS, ">logeion.diffs");
open (my $MISSING, ">logeion.missing");

for my $lemma (sort keys %log) {
    if ($lsj{$lemma}) {
      if ($lsj{$lemma} ne $log{$lemma}) {
          if ($lsj{$lemma} eq '@' && $lsj{'@' . $lemma}) {
            if ($lsj{'@' . $lemma} ne $log{$lemma}) {
              print $DIFS encode_utf8('@'.$lemma) . "|" . encode_utf8($lsj{'@'.$lemma}) . '|' . encode_utf8($log{$lemma}) . "\n";
            }
          } else {
              print $DIFS encode_utf8($lemma) . "|" . encode_utf8($lsj{$lemma}) . '|' . encode_utf8($log{$lemma}) . "\n";
          }
      } 
    } else {
          print $MISSING encode_utf8($lemma)  . "|" . encode_utf8($log{$lemma}) . "\n";
    }
}

