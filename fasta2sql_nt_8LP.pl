#!/usr/bin/perl -w

# >8LP_0.1 
# gera a query para inserir os unigenes no banco unigenes2
#
# sintaxe: ./fasta2sql.pl #initial_gene_id < contigs_singlets.fasta
#

my $gene_id = 0;

if(defined($ARGV[0])){
	$gene_id = $ARGV[0];
}

my $gene_name = "";
my $seq = "";
my $orf ="";


while(<STDIN>){

	if($_ =~ /^>8LP_(\d+)\.(\d+)/){
		$orf = "8LP_" . $1 . "." . $2;
		if ($gene_id > 0){

#		print "INSERT INTO gene_tbl (gene_id, copy_id, gene_name, date, sequence) VALUES ($gene_id, 1, '$ARGV[0]', '$date', '$seq');\n";
		print "UPDATE `orf_nt_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id';\n";
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
		print "UPDATE `orf_nt_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id;\n";

exit 0;
