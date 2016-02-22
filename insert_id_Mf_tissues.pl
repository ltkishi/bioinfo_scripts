#!/usr/bin/perl -w

# script para pegar nomes, ids do arquivo saida metagenemark .gff - 8LP
# inserindo IDs em gene_tbl, id e projeto
# kishi 

my $tissue = $ARGV[0];

my $transc_id;



while (<STDIN>) { 
        #if($_ =~ /contig-100_(\d+)\s+length_(\d+)\s+read_count_(\d+)(.*)CDS\s+(\d+)\s+(\d+)\s+\S+\s+(\S+)(.*)gene_id\s+(\d+)/){
        if($_ =~ /^\>Mf_($tissue)_(\S+)/){
                $transc_id = "Mf_" . $tissue . "_" .  $2;
#                $start = $5;
#                $end = $6;
#                $frame = $7;
#                $length = ($6 - $5);
#		 print "INSERT INTO orf_aa_tbl (orf_aa_id, sequence) VALUES ('$seq', '$sequence');\n";
##                print "UPDATE `M_fryanus`.`all_transcriptome_annot` SET `transc_id` WHERE `all_transcriptome_annot`.`transc_id` ='$orf_id';\n";
		print "INSERT INTO all_transcriptome_tissue (transc_id, version, tissue) VALUES ('$transc_id', '2.0', '$tissue');\n";
        }
}


