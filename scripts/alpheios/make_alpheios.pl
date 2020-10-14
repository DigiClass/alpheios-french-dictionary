#!/usr/bin/perl
use strict;
use Data::Dumper;
use Encode qw/encode decode/;



open (my $bailly, "<", "../../data/raw/alpheios/Bailly_sens.xml") or die $!;
open (my $bailly_see, "<", "../../data/raw/alpheios/Bailly_renv.xml") or die $!;
open (my $bailly_subst, "<", "../../data/raw/alpheios/Bailly_subst.xml") or die $!;
open (my $lsj, "<", "../../../lsj/dat/grc-lsj-defs.dat") or die $!;

my %uc;

my %bailly;
my %subst_errors;
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

while (<$bailly_subst>) {
  chomp;
  my ($form,$def,$lemma) = split /\t/;
  my $entries = parse_lemma($lemma);
  $form = decode('utf8', $form);
  $def = decode('utf8',$def);
  for my $entry (@$entries) {
    if ($bailly{$entry}) {
    	$bailly{$entry} .= " [ $form: $def ]";
    } else {
    	$subst_errors{$entry} = "[ $form: $def ]";
    }
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
  if ($matched{$lemma}) {
    $dat{$lemma} = "$matched{$lemma}->[0]|Bailly";
  } else {
    $dat{$lemma} = "$lsj{$lemma}|LSJ";
    $nobailly{$lemma} = $lsj{$lemma};
  }
}

open FILE, ">../../data/bailly-grc-defs.dat";
for my $lemma (sort keys %dat) {
  print FILE encode('utf8',"$lemma|$dat{$lemma}\n");
}


open FILE, ">../../data/raw/alpheios/matched.csv";
for my $lemma (sort keys %matched) {
   print FILE encode('utf8',"$lemma\t$matched{$lemma}->[0]\t$matched{$lemma}->[1]\n");
}
close FILE;
open FILE, ">../../data/raw/alpheios/nolsj.csv";
for my $lemma (sort keys %nolsj) {
  print FILE encode('utf8',"$lemma\t$nolsj{$lemma}\n");
}
close FILE;
open FILE, ">../../data/raw/alpheios/nobailly.csv";
for my $lemma (sort keys %nobailly) {
  print FILE encode('utf8',"$lemma\t$nobailly{$lemma}\n");
}
close FILE;

open FILE, ">../../data/raw/alpheios/substerrors.csv";
for my $lemma (sort keys %subst_errors) {
  print FILE encode('utf8',"$lemma\t$subst_errors{$lemma}\n");
}

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

