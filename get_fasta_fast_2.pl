#!/usr/bin/perl -w

use strict;

my %ids  = ();


if ($#ARGV < 1){
    print "Use: get_fasta.pl <Arq Clones> <Arq seqs>\n";
    exit;
}

if (!open ARQ,$ARGV[0]){   # Abrir e ler o arquivo de entrada, o segundo parametro
    print "Nao foi possivel abrir o arquivo: $ARGV[0]\n ";
    exit;
}

if (!open ARQ2,$ARGV[1])   # Abrir e ler o arquivo de entrada, o segundo parametro
{
    print "Nao foi possivel abrir o arquivo: $ARGV[1]\n ";
    exit;
}

while(<ARQ>) {
  chomp;
  $ids{$_} += 1;
}
close ARQ;


local $/ = "\n>";  # read by FASTA record

#open FASTA, $seqfile;
while (<ARQ2>) {
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
close ARQ2;

