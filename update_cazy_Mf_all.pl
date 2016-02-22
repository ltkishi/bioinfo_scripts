#!/usr/bin/perl -w

#
# gera a query para inserir os cazy ID no banco amazon_river
#
# sintaxe: ./update_cazy_8LP.pl Mf_all < saida_dbCAN_cazy.out 
#

my $point = $ARGV[0];
my $orf_id;
my $cazy;

while(<STDIN>){

    if($_ =~ /$point\_(\d+\.\d+)\t+(\S+)\.hmm/){
	$orf_id = $point . "_" . $1;
	$cazy = $2;
	
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
	print "UPDATE `M_fryanus`.`all_transcriptome_annot` SET `cazy` = '$cazy'  WHERE `all_transcriptome_annot`.`transc_id`= '$orf_id';\n";
  			
        } 
    
}

exit 0;
