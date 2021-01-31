#!/usr/bin/perl
use strict;
use Data::Dumper;
use Encode qw/encode decode/;


open (my $lsj_bailly, "<", "../../data/raw/alpheios/index_LSJ_Bailly.xml") or die $!;
open (my $eul_bailly, "<", "../../data/raw/alpheios/Eulexis_Bailly_align.xml") or die $!;
open (my $lsj, "<", "../../../lsj/dat/grc-lsj-defs.dat") or die $!;

my %alsj;
my %not_in_alpheios;
while (<$lsj>) {
  chomp;
  my ($lemma, $def) = split /\|/;
  $lemma = decode('utf8', $lemma);
  $def = decode('utf8',$def);
  $alsj{$lemma} = $def;
}

my %lsj_to_bailly;
while (<$lsj_bailly>) {
  chomp;
  next if /^\s+$/;
  my ($norm,$lsj,$bailly) = split /\t/;
  $lsj = decode('utf8',$lsj);
  $bailly = decode('utf8',$bailly);
  $lsj =~ s/\s*\x{2074}/4/ug;
  $lsj =~ s/\s*\x{00b3}/3/ug;
  $lsj =~ s/\s*\x{00b2}/2/ug;
  $lsj =~ s/\s*\x{00b9}/1/ug;
  if ($lsj_to_bailly{$lsj}) {
    push @{$lsj_to_bailly{$lsj}}, $bailly;
  }
  $lsj_to_bailly{$lsj} = [ $bailly ];
}
warn("LSJ to Bailly entries: " . scalar keys %lsj_to_bailly);


my %bailly_to_eul;
while (<$eul_bailly>) {
  chomp;
  next if /^\s+$/;
  my ($eul, $b, $sens, $renv, $subst) = split /\t/;
  $eul = decode('utf8',$eul);
  $eul =~ s/^\?\s+//;
  $eul =~ s/^\*\s+//;
  $sens = decode('utf8',$sens);
  $renv = decode('utf8',$renv);
  $subst = decode('utf8',$subst);
  if ($sens) {
    $bailly_to_eul{$sens} = $eul;
  }
  if ($renv) {
    $bailly_to_eul{$renv} = $eul;
  }  
  if ($subst) { 
    $bailly_to_eul{$subst} = $eul;
  }
}
warn("Bailly to EUL entries: " . scalar keys %bailly_to_eul);

my %eul_to_lsj;

for my $lsj (%lsj_to_bailly) {
  for my $lemma (@{$lsj_to_bailly{$lsj}}) {
    # we don't find the lemma as it is, but we do have it with a special flag for caps
    # with the lowercase version as the index
    if (!$alsj{$lsj} && $alsj{"\@$lsj"} && $alsj{lcfirst($lsj)}) {
      $lsj = lcfirst($lsj);
    }
    if ($alsj{$lsj} && $bailly_to_eul{$lemma} && $bailly_to_eul{$lemma} ne $lsj) {
      if ($eul_to_lsj{$bailly_to_eul{$lemma}}) {
        push @{$eul_to_lsj{$bailly_to_eul{$lemma}}}, $lsj;
      } else {
        $eul_to_lsj{$bailly_to_eul{$lemma}} = [$lsj];
      }
    } else {
      $not_in_alpheios{$lsj} = 1; 
    }
  }
}

my %not_in_eulexis;
for my $lemma (keys %alsj) {
  if ($lemma =~ /^@/) {
    $lemma =~ s/^@//;
  }
  if (! $lsj_to_bailly{$lemma} && !$lsj_to_bailly{lcfirst($lemma)} && !$lsj_to_bailly{ucfirst($lemma)}) {
    $not_in_eulexis{$lemma} = 1;
  }
}


open FILE, ">../../data/raw/alpheios/eul_to_lsj.csv";
for my $lemma (sort keys %eul_to_lsj) {
   print FILE encode('utf8',"$lemma\t" . join "|", @{$eul_to_lsj{$lemma}});
   print FILE "\n";
}

open FILE, ">../../data/raw/alpheios/eul_lsj_not_alpheios_lsj.csv";
for my $lemma (sort keys %not_in_alpheios) {
   print FILE encode('utf8',$lemma);
   print FILE "\n";
}

open FILE, ">../../data/raw/alpheios/alpheios_lsj_not_eul_lsj.csv";
for my $lemma (sort keys %not_in_eulexis) {
   print FILE encode('utf8',$lemma);
   print FILE "\n";
}
