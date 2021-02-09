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
      unless (exists $eulexis{$lsj}) {
        $eulexis{$lsj} = [];
      } 
      push @{$eulexis{$lsj}}, $def;
    }
  } else {
    my $entries = parse_lemma($lemma);
    for my $entry (@$entries) {
      unless (exists $eulexis{$entry}) {
        $eulexis{$entry} = [];
      }
      push @{$eulexis{$entry}}, $def;
    }
  }
}

# aggregate multiple definitions
for my $entry (keys %eulexis) {
 $eulexis{$entry} = join "; ", @{$eulexis{$entry}};
}



my %matched;
my %nolsj; 
my %noeul;
for my $lemma (keys %eulexis) {
  if ($lsj{$lemma}) {
    $matched{$lemma} = $eulexis{$lemma};
  } elsif ($lsj{lcfirst($lemma)}) {
    $matched{lcfirst($lemma)} = '@';
    if ($lsj{'@'. $lemma}) {
      $matched{'@'. $lemma} = $eulexis{$lemma};
    } else {
      $matched{'@'. $lemma} = $eulexis{$lemma};
    }
  } else {
    $dat{$lemma} = "$eulexis{$lemma}|Bailly";
    $nolsj{$lemma} = $eulexis{$lemma};
  }
}

for my $lemma (keys %lsj) {
  if ($matched{$lemma}) {
    $dat{$lemma} = "$matched{$lemma}|Bailly";
  } else {
    $dat{$lemma} = "$lsj{$lemma}|LSJ";
    $noeul{$lemma} = $lsj{$lemma};
  }
}

for my $lemma (keys %matched) {
  unless ($dat{$lemma}) {
    $dat{$lemma} = "$matched{$lemma}|Bailly";
  }
}

open FILE, ">../../data/bailly-grc-defs.dat";
for my $lemma (sort keys %dat) {
  print FILE encode_utf8("$lemma|$dat{$lemma}\n");
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

