#!/usr/bin/perl

# script para pegar nomes, tamanho, num reads, cordenadas do arquivo saida metagenemark .gff
# requer extract_fasta.pl
# kishi 
## >contig-100_0 length_81572 read_count_117649

my $contig;
my $length;
my $nreads;


while (<STDIN>) { 
        if($_ =~ /^\>contig-100_(\d+)\s+length_(\d+)\s+read_count_(\d+)/){
                $contig = "8LP_" . $1;
                $length = $2;
		$nreads = $3;
##print "INSERT INTO orf_aa_tbl (orf_aa_id, sequence) VALUES ('$seq', '$sequence');\n";
		print "INSERT INTO contig_tbl (contig_id, length, numreads) VALUES ('$contig', '$length', '$nreads');\n";

	}
}

