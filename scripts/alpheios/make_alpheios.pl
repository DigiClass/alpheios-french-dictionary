#!/usr/bin/perl
use strict;
use Data::Dumper;
use Encode qw/encode decode/;



open (my $bailly, "<", "../../raw_data/alpheios/Bailly_sens.xml") or die $!;
open (my $bailly_see, "<", "../../raw_data/alpheios/Bailly_renv.xml") or die $!;
open (my $lsj, "<", "../../../lsj/dat/grc-lsj-defs.dat") or die $!;

my %uc;

my %bailly;
while (<$bailly>) {
  chomp;
  my ($lemma, $def) = split /\t/;
  $def = decode('utf8', $def);
  my $entries = parse_lemma($lemma);
  for my $entry (@$entries) {
    $bailly{$entry} = $def;
  }
}

while (<$bailly_see>) {
  chomp;
  my ($lemma,$see) = split /\t/;
  my $entries = parse_lemma($lemma);
  $see = decode('utf8', $see);
  if ($see =~ /\w+ \d+/) {
    $see =~ s/(\w+) (\d+)/\1\2/;
  }
  my $def = 'see <lang="grc">' . $see . "</grc>";
  for my $entry (@$entries) {
    $bailly{$entry} = $def;
  }
}

my %lsj;
while (<$lsj>) {
  chomp;
  my ($lemma, $def) = split /\|/;
  $lemma = decode('utf8', $lemma);
  $lsj{$lemma} = $def;
}


my %matched;
my %dat;
my %nolsj; 
my %nobailly;
for my $lemma (keys %bailly) {
  if ($lsj{$lemma}) {
    $matched{$lemma} = [$bailly{$lemma}, $lsj{$lemma}];
  } elsif ($lsj{lcfirst($lemma)}) {
    $matched{lcfirst($lemma)} = ['@',$lsj{lcfirst($lemma)}];
    if ($lsj{'@'. $lemma}) {
      $matched{'@'. $lemma} = [$bailly{$lemma}, $lsj{'@'.$lemma}]
    } else {
      $matched{'@'. $lemma} = [$bailly{$lemma}, $lsj{lcfirst($lemma)}]
    }
  } else {
    $nolsj{$lemma} = $bailly{$lemma};
  }
}
for my $lemma (keys %lsj) {
  if ($bailly{$lemma}) {
    $dat{$lemma} = $bailly{$lemma};
  } else {
    $dat{$lemma} = $lsj{$lemma};
    $nobailly{$lemma} = $lsj{$lemma};
  }
}

open FILE, ">../../data/bailly-grc-defs.dat";
for my $lemma (sort keys %dat) {
  print FILE encode('utf8',"$lemma|$dat{$lemma}\n");
}


open FILE, ">../../raw_data/alpheios/matched.csv";
for my $lemma (sort keys %matched) {
   print FILE encode('utf8',"$lemma\t$matched{$lemma}->[0]\t$matched{$lemma}->[1]\n");
}
close FILE;
open FILE, ">../../raw_data/alpheios/nolsj.csv";
for my $lemma (sort keys %nolsj) {
  print FILE encode('utf8',"$lemma\t$nolsj{$lemma}\n");
}
close FILE;
open FILE, ">../../raw_data/alpheios/nobailly.csv";
for my $lemma (sort keys %nobailly) {
  print FILE encode('utf8',"$lemma\t$nobailly{$lemma}\n");
}
close FILE;

sub parse_lemma {
  my $lemma = shift;
  $lemma = decode('utf8', $lemma);
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

