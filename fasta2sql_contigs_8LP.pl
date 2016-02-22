#!/usr/bin/perl -w

# >contig-100_0 length_81572 read_count_117649 
# gera a query para inserir os unigenes no banco unigenes2
#
# sintaxe: ./fasta2sql.pl CL #initial_gene_id < contigs_singlets.fasta
#

my $gene_id = 0;

if(defined($ARGV[0])){
	$gene_id = $ARGV[0];
}

my $gene_name = "";
my $seq = "";


while(<STDIN>){

	if($_ =~ /^\>(\S+)/){
		if ($gene_id > 0){

#		print "INSERT INTO gene_tbl (gene_id, copy_id, gene_name, date, sequence) VALUES ($gene_id, 1, '$ARGV[0]', '$date', '$seq');\n";
		print "UPDATE `contig_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id';\n";
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
		print "UPDATE `contig_tbl` SET `fasta` = '$seq' WHERE `id` = '$gene_id;\n";

exit 0;
