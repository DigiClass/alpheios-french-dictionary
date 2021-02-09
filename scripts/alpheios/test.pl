#!/usr/bin/perl
use strict;
use Data::Dumper;
use Unicode::UTF8 qw[decode_utf8 encode_utf8];


open (my $eul, "<", "../../data/raw/alpheios/Eulexis_Bailly_sens.xml") or die $!;

while (<$eul>) {
  chomp;
  my $line = decode_utf8($_);
  print encode_utf8($line);
  print "\n";
}
