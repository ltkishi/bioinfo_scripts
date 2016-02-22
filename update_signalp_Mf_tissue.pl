#!/usr/bin/perl -w

#
# gera a query para inserir os cazy ID no banco amazon_river
#
# sintaxe: ./update_cazy_8LP.pl Mf_all < saida_dbCAN_cazy.out 
#
## Mf_cab_comp119_c0_seq1|m.35       0.812  22  0.556  22  0.525   4  0.376   0.459 Y  0.450      SignalP-noTM


my $tissue = $ARGV[0];
my $transc_id;

while(<STDIN>){

    if($_ =~ /Mf_$tissue(\S+)\|/){
	$transc_id = "Mf_" . $tissue . $1;
	
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
	print "UPDATE `M_fryanus`.`all_transcriptome_tissue` SET `signalp` = 'yes'  WHERE `all_transcriptome_tissue`.`transc_id`= '$transc_id';\n";
  			
        } 
    
}

exit 0;
