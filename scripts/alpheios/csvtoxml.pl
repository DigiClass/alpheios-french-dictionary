#!/usr/bin/perl
# silly script to wrap the CSV files into XML for normalization using Alpheios
# xslt
use strict;
use Data::Dumper;
use Encode qw/encode decode/;



open (my $bailly, "<", "../../data/raw/eulexis/Bailly_sens.csv") or die $!;
open (my $see, "<", "../../data/raw/eulexis/Bailly_renv.csv") or die $!;
open (my $sub, "<", "../../data/raw/eulexis/Bailly_subst.csv") or die $!;

open FILE, ">../../data/raw/alpheios/Bailly_sens.xml";
print FILE "<root>\n";
while (<$bailly>) {
  chomp;
  my @cols = split /\t/;
  my $greek = shift @cols;
  $greek =~ s/\*//;
  print FILE "<greek>$greek</greek>\t";
  print FILE "<rest>" . (join "\t", @cols) . "</rest>";
  print FILE "\n";
}
print FILE "</root>\n";
close FILE;
  
open FILE, ">../../data/raw/alpheios/Bailly_renv.xml";
print FILE "<root>\n";
while (<$see>) {
  chomp;
  my @cols = split /\t/;
  my $greek = shift @cols;
  $greek =~ s/\*//;
  print FILE "<greek>$greek\t";
  $greek = shift @cols;
  $greek =~ s/> //;
  $greek =~ s/\*//;
  print FILE "$greek</greek>\t";
  print FILE "<rest>". (join "\t", @cols) . '</rest>';
  print FILE "\n";
}
print FILE "</root>\n";
close FILE;

open FILE, ">../../data/raw/alpheios/Bailly_subst.xml";
print FILE "<root>\n";
while (<$sub>) {
  chomp;
  my @cols = split /\t/;
  shift @cols;
  my $greek = shift @cols;
  $greek =~ s/\*//;
  print FILE "<greek>$greek</greek>\t";
  my $def = shift @cols;
  print FILE "<rest>$def</rest>\t";
  $greek = shift @cols;
  $greek =~ s/> //;
  $greek =~ s/\*//;
  print FILE "<greek>$greek</greek>";
  print FILE "\n";
}
print FILE "</root>\n";
close FILE;
