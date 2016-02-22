#!/usr/bin/perl -w

#
# gera a query para inserir os cazy ID no banco amazon_river
#
# sintaxe: ./update_cazy_8LP.pl Mf_all < saida_dbCAN_cazy.out 
#
## Mf_cab_10061_c0_seq2|m.4560     GT7.hmm         5.8e-99 6       250     158     399     0.976


my $tissue = $ARGV[0];
my $transc_id;
my $cazy;

while(<STDIN>){

    if($_ =~ /Mf_$tissue(\S+)\|(\S+)\t(\S+)\.hmm/){
	$transc_id = "Mf_" . $tissue . $1;
	$cazy = $3;
	
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
	print "UPDATE `M_fryanus`.`all_transcriptome_tissue` SET `cazy` = '$cazy'  WHERE `all_transcriptome_tissue`.`transc_id`= '$transc_id';\n";
  			
        } 
    
}

exit 0;
