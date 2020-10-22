#!/usr/bin/perl
# silly script to wrap the CSV files into XML for normalization using Alpheios
# xslt
use strict;
use Data::Dumper;
use Encode qw/encode decode/;



#open (my $bailly, "<", "../../data/raw/eulexis/Bailly_sens.csv") or die $!;
#open (my $see, "<", "../../data/raw/eulexis/Bailly_renv.csv") or die $!;
#open (my $sub, "<", "../../data/raw/eulexis/Bailly_subst.csv") or die $!;
#open (my $work, "<", "../../data/raw/eulexis/trad_gr_en_fr_de_travail_3.csv") or die $!;
#open (my $lsjindex, "<", "../../data/index_LSJ_Bailly.csv") or die $!;
#open (my $align, "<", "../../data/Eulexis_Bailly_align.csv") or die $!;
open (my $sens, "<", "../../data/Eulexis_Bailly_sens.csv") or die $!;

#open FILE, ">../../data/raw/alpheios/Bailly_sens.xml";
#print FILE "<root>\n";
#while (<$bailly>) {
#  chomp;
#  my @cols = split /\t/;
#  my $greek = shift @cols;
#  $greek =~ s/\*//;
#  print FILE "<greek>$greek</greek>\t";
#  print FILE "<rest>" . (join "\t", @cols) . "</rest>";
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;
  
#open FILE, ">../../data/raw/alpheios/Bailly_renv.xml";
#print FILE "<root>\n";
#while (<$see>) {
#  chomp;
#  my @cols = split /\t/;
#  my $greek = shift @cols;
#  $greek =~ s/\*//;
#  print FILE "<greek>$greek\t";
#  $greek = shift @cols;
#  $greek =~ s/> //;
#  $greek =~ s/\*//;
#  print FILE "$greek</greek>\t";
#  print FILE "<rest>". (join "\t", @cols) . '</rest>';
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;

#open FILE, ">../../data/raw/alpheios/Bailly_subst.xml";
#print FILE "<root>\n";
#while (<$sub>) {
#  chomp;
#  my @cols = split /\t/;
#  shift @cols;
#  my $greek = shift @cols;
#  $greek =~ s/\*//;
#  print FILE "<greek>$greek</greek>\t";
#  my $def = shift @cols;
#  print FILE "<rest>$def</rest>\t";
#  $greek = shift @cols;
#  $greek =~ s/> //;
#  $greek =~ s/\*//;
#  print FILE "<greek>$greek</greek>";
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;
#
#open FILE, ">../../data/raw/alpheios/trad_gr_en_fr_de_travail_3_b.xml";
#print FILE "<root>\n";
#while (<$work>) {
#  chomp;
#  my @cols = split /\t/;
#  shift @cols;
#  my $greek = shift @cols;
#  print FILE "<greek>$greek</greek>\t";
#  my $rest = join "\t", @cols;
#  $rest =~ s/</&lt;/g;
#  $rest =~ s/>/&gt;/g;
#  print FILE "<rest>$rest</rest>";
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;
#
#open FILE, ">../../data/raw/alpheios/index_LSJ_Bailly.xml";
#print FILE "<root>\n";
#while (<$lsjindex>) {
#  chomp;
#  print FILE "<greek>$_</greek>\n";
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;
#
#open FILE, ">../../data/raw/alpheios/Eulexis_Bailly_align.xml";
#print FILE "<root>\n";
#while (<$align>) {
#  chomp;
#  print FILE "<greek>$_</greek>\n";
#  print FILE "\n";
#}
#print FILE "</root>\n";
#close FILE;

open FILE, ">../../data/raw/alpheios/Eulexis_Bailly_sens_b.xml";
print FILE "<root>\n";
while (<$sens>) {
  chomp;
  my $line = $_;
  $line = decode('utf8', $line);
  $line =~ s/</&lt;/g;
  $line =~ s/>/&gt;/g;
  my @cols = split /\t/, $line;
  my $n = shift @cols;
  print FILE "$n\t";
  shift @cols;
  my $greek = shift @cols;
  print FILE "<greek>" . encode('utf8',$greek) . "</greek>\t";
  my $en = shift @cols;
  my $t = shift @cols;
  my $rest = join "\t", @cols;
  print FILE "<rest>" . encode('utf8', $rest) . "</rest>\n";
}
print FILE "</root>\n";
close FILE;

