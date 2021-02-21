#!/usr/bin/perl
use Encode qw/encode decode/;
use strict;

open AJAX, "<../../data/raw/alpheios/ajax_lemma_freqs_unicode.csv" or die $!;
open DEFS, "<../../data/bailly-grc-defs.dat" or die $!;
my %lemmas;
my %defs;
while (<AJAX>) {
  chomp;
  my ($lemma,$freq) = split /,/;
  $lemma = decode('utf8', $lemma);
  $lemmas{$lemma} = { 'freq' => $freq, 'def' => []}
}
while (<DEFS>) {
  chomp;
  my ($lemma, $def, $src) = split /\|/;
  $lemma = decode('utf8', $lemma);
  $def = decode('utf8', $def);
  if (! exists $defs{$lemma}) {
    $defs{$lemma} = [];
  }
  push @{$defs{$lemma}}, $def;
}

for my $lemma (sort keys %lemmas) {
  my @deflist;
  my @altlist;
  for my $def (@{$defs{lcfirst($lemma)}}) {
    push @deflist, $def;
  }
  for my $def (@{$defs{'@' .$lemma}}) {
    push @altlist, $def;
  }
  for my $def (@deflist) {
    if ($def eq '@') {
      for my $adef (@altlist) {
        push @{$lemmas{$lemma}{'def'}}, $adef;
      }
    } else {
      push @{$lemmas{$lemma}{'def'}}, $def;
    }
  }
}

open ADEFS, ">../../data/bailly-grc-ajax-defs.csv";
print ADEFS "lemma\tfreq\t\def\n";
for my $lemma (sort keys %lemmas) {
   for my $def (@{$lemmas{$lemma}{'def'}}) {
     print ADEFS encode('utf8',$lemma) . "\t" . $lemmas{$lemma}{'freq'} . "\t" . encode('utf8',$def) . "\n";
   }
}


