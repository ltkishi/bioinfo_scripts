#!/usr/bin/perl -w

use strict;

my $idsfile = "nome_orfs_8LP_150pb_b-2.txt";
my $seqfile = "8LP_aa_corrigido.fasta";
my %ids  = ();

open FILE, $idsfile;
while(<FILE>) {
  chomp;
  $ids{$_} += 1;
}
close FILE;

local $/ = "\n>";  # read by FASTA record

open FASTA, $seqfile;
while (<FASTA>) {
    chomp;
    my $seq = $_;
#    my ($id) = $seq =~ /^>*(\S+)/;  # parse ID as first word in FASTA header
    my ($id) = $seq =~ /^(\S+)/;  # parse ID as first word in FASTA header
    if (exists($ids{$id})) {
#        $seq =~ s/^>*.+\n//;  # remove FASTA header
#        $seq =~ s/\n//g;  # remove endlines
        print "$seq\n";
    }
}
close FASTA;

