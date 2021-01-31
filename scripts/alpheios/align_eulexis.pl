#!/usr/bin/perl
use strict;
use Data::Dumper;
use Unicode::UTF8 qw[decode_utf8 encode_utf8];


open (my $eul, "<", "../../data/raw/alpheios/Eulexis_Bailly_sens.xml") or die $!;
open (my $lsj, "<", "../../../lsj/dat/grc-lsj-defs.dat") or die $!;
open (my $eul_to_lsj, "<", "../../data/raw/alpheios/eul_to_lsj.csv") or die $!;

my %dat;
my %eul_to_lsj;
my %eulexis;
my %defs_not_taken;
my %lsj;

while (<$lsj>) {
  chomp;
  my ($lemma, $def) = split /\|/;
  $lemma = decode_utf8( $lemma);
  $lsj{$lemma} = $def;
}

while (<$eul_to_lsj>) {
  chomp;
  my ($el, $lsj) = split /\t/;
  $el = decode_utf8($el);
  $lsj = decode_utf8($lsj);
  $eul_to_lsj{$el} = $lsj;
}
while (<$eul>) {
  chomp;
  my $line = $_;
  my ($num,$lemma,$def) = split /\t/, $line;
  $def = decode_utf8($def);

  next unless $def;

  # if we have a mapping from the eulexis lemma to the lsj lemma, use the lsj lemma
  if ($eul_to_lsj{decode_utf8($lemma)}) {
    for my $lsj (split /\|/, $eul_to_lsj{decode_utf8($lemma)}) {
      if (exists $eulexis{$lsj}) {
        $defs_not_taken{$lsj} = $def;
      } else {
        $eulexis{$lsj} = $def;
      }
    }
  } else {
    my $entries = parse_lemma($lemma);
    for my $entry (@$entries) {
      if ($eulexis{$entry}) {
        $defs_not_taken{$entry} = $def;
      } else {
        $eulexis{$entry} = $def;
      }
    }
  }
}



my %matched;
my %nolsj; 
my %noeul;
for my $lemma (keys %eulexis) {
  if ($lsj{$lemma}) {
    $matched{$lemma} = [$eulexis{$lemma},$lsj{$lemma}];
  } elsif ($lsj{lcfirst($lemma)}) {
    $matched{lcfirst($lemma)} = ['@',''];
    if ($lsj{'@'. $lemma}) {
      $matched{'@'. $lemma} = [$eulexis{$lemma}, $lsj{'@'.$lemma}]
    } else {
      $matched{'@'. $lemma} = [$eulexis{$lemma}, $lsj{lcfirst($lemma)}]
    }
  } else {
    $dat{$lemma} = "$eulexis{$lemma}|Bailly";
    $nolsj{$lemma} = $eulexis{$lemma};
  }
}

for my $lemma (keys %lsj) {
  if ($matched{$lemma}) {
    $dat{$lemma} = "$matched{$lemma}->[0]|Bailly";
  } else {
    $dat{$lemma} = "$lsj{$lemma}|LSJ";
    $noeul{$lemma} = $lsj{$lemma};
  }
}

open FILE, ">../../data/bailly-grc-defs.dat";
for my $lemma (sort keys %dat) {
  print FILE encode_utf8("$lemma|$dat{$lemma}\n");
}

open FILE, ">../../data/raw/alpheios/matched_eul.csv";
for my $lemma (sort keys %matched) {
   print FILE encode_utf8("$lemma\t$matched{$lemma}->[0]\t$matched{$lemma}->[1]\n");
}
close FILE;
open FILE, ">../../data/raw/alpheios/nolsj.csv";
for my $lemma (sort keys %nolsj) {
  print FILE encode_utf8("$lemma\t$nolsj{$lemma}\n");
}
close FILE;
open FILE, ">../../data/raw/alpheios/noeul.csv";
for my $lemma (sort keys %noeul) {
  print FILE encode_utf8("$lemma\t$noeul{$lemma}\n");
}
close FILE;

open FILE, ">../../data/raw/alpheios/dupedefs.csv";
for my $lemma (sort keys %defs_not_taken) {
  print FILE encode_utf8("$lemma\t$defs_not_taken{$lemma}\n");
}
close FILE;



sub parse_lemma {
  my $lemma = shift;
  $lemma = decode_utf8( $lemma);
  my $sens;
  my (@entries);
  if ($lemma =~ /^\w+, \w+$/) {
    my ($lower,$upper) = $lemma =~ /^(\w), (\w)$/;
    push @entries, $lower;
    push @entries, $upper;
  } else {
    if ($lemma =~ /^\d+/) {
       ($sens) = $lemma =~ /^(\d+)/;
       $lemma =~ s/^\d+\s+//;
    }
    # if it's the first sense or no sense indicated
    # then add the word without sens as a capital
    if (! $sens || $sens eq '1') {
      push @entries, $lemma;
    }
    if ($sens) {
      push @entries, $lemma . $sens;
    }
  }
  return \@entries;
}

