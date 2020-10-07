#!/usr/bin/perl
# silly script to wrap the CSV files into XML for normalization using Alpheios
# xslt
use strict;
use Data::Dumper;
use Encode qw/encode decode/;



open (my $bailly, "<", "../../raw_data/Bailly_sens.csv") or die $!;
open (my $see, "<", "../../raw_data/Bailly_renv.csv") or die $!;

open FILE, ">../../raw_data/alpheios/Bailly_sens.xml";
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
  
open FILE, ">../../raw_data/alpheios/Bailly_renv.xml";
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
