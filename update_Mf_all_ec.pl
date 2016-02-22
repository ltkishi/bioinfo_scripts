#!/usr/bin/perl -w

#
# gera a query para inserir pfam no banco M_fryanus
#
# sintaxe: ./update_pfam_camera_8S.pl Mf_all < saida_anot_camera_pfam.out (HMMANNOTATIONAGAINSTPFAM-ECMAPPING39.txt)
#
#query  EC      reference GO
#Mf_all_2267833.1        EC:3.4.23       GO:0004190


my $point = $ARGV[0];
my $orf_id;
my $ec;


while(<STDIN>){
#    if($_ =~ /^\<CLas(\d+)/){
#	$gene_id = $1;
#    }

##    if($_ =~ /$point\_(\d+\.\d+)\t\S+\t\d+\tPfam\tPF(\d+)\t(\w+)(.*)IPR(\d+)\t(\w+)\tGO\:(\S+)/){
    if($_ =~ /$point\_(\d+\.\d+)\tEC\:(\S+)(.*)/){
	$orf_id = $point . "_" . $1;
	$ec = $2;
##	$go = "GO:" . $7;
    
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
##	print "INSERT INTO gene_tbl (gene_id, pfam, pfam_name, pfam_desc, go) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc', '$go');\n";
##	print "INSERT INTO all_transcriptome_annot (transc_id, pfam, name, description) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc');\n";  
	print "UPDATE `M_fryanus`.`all_transcriptome_annot` SET `ec` = '$ec' WHERE `all_transcriptome_annot`.`transc_id` ='$orf_id';\n"; 



   			
    }
    
}

exit 0;
