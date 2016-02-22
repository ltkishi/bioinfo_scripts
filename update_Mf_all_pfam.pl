#!/usr/bin/perl -w

#
# gera a query para inserir pfam no banco M_fryanus
#
# sintaxe: ./update_pfam_camera_8S.pl Mf_all < saida_anot_camera_pfam.out (HMMANNOTATIONAGAINSTPFAM-PFAMANNOTATION37.txt)
#
#Query  Hit     E-value Query-start     Query-end       Hit-start       Hit-end Hit-length      Redundant       Name    Description
##Mf_all_2344611.2        PF00001 1.5e-93 54      396     1       272     272     1       7tm_1   7 transmembrane receptor (rhodopsin family)


my $point = $ARGV[0];
my $orf_id;
my $pfam;
my $pfam_name;
my $pfam_desc;
my $go;


while(<STDIN>){
#    if($_ =~ /^\<CLas(\d+)/){
#	$gene_id = $1;
#    }

##    if($_ =~ /$point\_(\d+\.\d+)\t\S+\t\d+\tPfam\tPF(\d+)\t(\w+)(.*)IPR(\d+)\t(\w+)\tGO\:(\S+)/){
    if($_ =~ /$point\_(\d+\.\d+)\t(\S+)\t\S+\t\d+\t\d+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\S+)\s+(.*)/){
	$orf_id = $point . "_" . $1;
	$pfam = $2;
	$pfam_name = $3;
	$pfam_desc = $4;
##	$go = "GO:" . $7;
    
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
##	print "INSERT INTO gene_tbl (gene_id, pfam, pfam_name, pfam_desc, go) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc', '$go');\n";
##	print "INSERT INTO all_transcriptome_annot (transc_id, pfam, name, description) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc');\n";  
	print "UPDATE `M_fryanus`.`all_transcriptome_annot` SET `pfam` = '$pfam', `name` = '$pfam_name', `description` = '$pfam_desc' WHERE `all_transcriptome_annot`.`transc_id` ='$orf_id';\n"; 


   			
    }
    
}

exit 0;
