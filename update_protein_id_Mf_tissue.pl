#!/usr/bin/perl -w

#
# gera a query para inserir os cazy ID no banco amazon_river
#
# sintaxe: ./update_cazy_8LP.pl Mf_all < saida_dbCAN_cazy.out 
#
## >Mf_int_post_comp12_c1_seq1|m.1 Mf_int_post_comp12_c1_seq1|g.1 type:internal len:211 Mf_int_post_comp12_c1_seq1:632-3(-)

my $tissue = $ARGV[0];
my $transc_id;
my $protein_id;

while(<STDIN>){

    if($_ =~ /Mf_$tissue(\S+)\|(\S+)/){
	$transc_id = "Mf_" . $tissue . $1;
	$protein_id = $transc_id . "|" . $2;


#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
	print "UPDATE `M_fryanus`.`all_transcriptome_tissue` SET `protein_id` = '$protein_id'  WHERE `all_transcriptome_tissue`.`transc_id`= '$transc_id';\n";
  			
        } 
    
}

exit 0;
