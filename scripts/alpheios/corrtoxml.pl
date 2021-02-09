#!/usr/bin/perl
# silly script to wrap the CSV files into XML for normalization using Alpheios
# xslt
use strict;
use Data::Dumper;
use Encode qw/encode decode/;


my $dir = $ARGV[0];
my $path = "../../data/corrections/$dir/verified";

opendir(my $dh, $path) || die "$!";
my @files = grep { -f "$path/$_" } readdir($dh);
open FILE, ">../../data/raw/alpheios/corrections/$dir.xml";
print FILE "<root>\n";
for my $filename (@files) {
  open (my $sens, "<", "../../data/corrections/$dir/verified/$filename") or die "$! $filename";
  while (<$sens>) {
    chomp;
    my $line = $_;
    $line = decode('utf8', $line);
    if ($line =~ /revu\.csv/) {
      next;
    }
    $line =~ s/</&lt;/g;
    $line =~ s/>/&gt;/g;
    my @cols = split /\t/, $line;
    my $lemma = $cols[2];
    my $def = $cols[6];
    print FILE "<greek>" . encode('utf8',$lemma) . "</greek>\t";
    print FILE "<rest>" . encode('utf8', $def) . "</rest>\n";
  }
}

print FILE "</root>\n";
close FILE;

