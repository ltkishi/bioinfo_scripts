#!/usr/bin/perl -w

#
# gera a query para inserir os unigenes no banco unigenes2
#
# sintaxe: ./fasta2sql_mfryanus_tissue.pl tissue  #initial_gene_id < contigs_singlets.fasta
#

my $gene_id = 0;
my $tissue = $ARGV[0];
my $name;
my $length;

if(defined($ARGV[1])){
	$gene_id = $ARGV[1];
}

my $gene_name = "";
my $seq = "";

while(<STDIN>){

	if($_ =~ /^>(\S+) length (\d+)/){
		$name = $1;
		$length = $2;
		if ($gene_id > 0){

#		print "INSERT INTO gene_tbl (gene_id, copy_id, gene_name, date, sequence) VALUES ($gene_id, 1, '$ARGV[0]', '$date', '$seq');\n";
#		print "UPDATE `orf_nt_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id';\n";
		print "INSERT INTO tissue_transcriptome (id, name, tissue, length) VALUES ('$gene_id', '$name', '$tissue', '$length');\n";
		}
		$seq = "";
		$gene_id++;
	}
	
	else{	
		chomp $_;
		$seq = $seq . $_;
	}
}

#print "INSERT INTO gene_tbl (gene_id, copy_id, gene_name, date, sequence) VALUES ($gene_id, 1, '$ARGV[0]', '$date', '$seq');\n";
#		print "UPDATE `orf_nt_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id';\n";

                print "INSERT INTO tissue_transcriptome (id, name, tissue, length) VALUES ('$gene_id', '$name', '$tissue', '$length');\n";
exit 0;


