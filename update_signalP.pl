#!/usr/bin/perl -w

#
# gera a query para atualizar signalP no banco
# Mudar euk, gram+, gram_

# sintaxe: ./update_signalppl 8LP < saida_signalp_short_yes.out 
#

my $point = $ARGV[0];
my $orf_id;
my $signalp;


while(<STDIN>){
##    if($_ =~ /$point\_(\d+\.\d+)\t\S+\t\d+\tPfam\tPF(\d+)\s(.+)\s+\d+\s+\d+\s+\d+(.*)IPR(\d+)\t(.+)\tGO/){
#    if($_ =~ /$point\_(\d+\.\d+)\t\S+\t\d+\tPfam\tPF(\d+)\s(.+)/){
    if($_ =~ /$point\_(\d+\.\d+)/){
	$orf_id = $point . "_" . $1;
    
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
##	print "INSERT INTO gene_tbl (gene_id, pfam, pfam_name, pfam_desc, go) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc', '$go');\n";
##	print "UPDATE `amazon_river`.`gene_tbl` SET `pfam` = '$pfam', `pfam_name` = '$pfam_name', `pfam_desc` = '$pfam_desc' WHERE `gene_tbl`.`gene_id` ='$orf_id';\n";
	print "UPDATE `amazon_river`.`gene_tbl` SET `signalp_euk` = 'yes' WHERE `gene_tbl`.`gene_id` ='$orf_id';\n";


   			
    }
    
}

exit 0;
