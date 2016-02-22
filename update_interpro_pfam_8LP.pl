#!/usr/bin/perl -w

#
# gera a query para atualizar pfam no banco
#
# sintaxe: ./update_pfam_camera_8S.pl 8LP < saida_anot_camera_pfam.out 
#
# 8LP_10308.49561 500239c7b071fd31881d63a2d89b735b        219     Pfam    PF00182 Chitinase class I       108     178     7.1E-10 T       27-09-2013 IPR000726       Glycoside hydrolase, family 19, catalytic       GO:0004568|GO:0006032|GO:0016998
# 8LP_8826.45360  b4257e496dab39301fce2906722154e8        159     Pfam    PF03562 MltA specific insert domain     1       59      1.3E-19 T       27-09-2013      IPR005300       Lytic transglycosylase MltA     GO:0004553


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
    if($_ =~ /$point\_(\d+\.\d+)\t\S+\t\d+\tPfam\tPF(\d+)\s(.+)\s+\d+\s+\d+\s+\d+(.*)IPR(\d+)\t(.+)\tGO/){
	$orf_id = $point . "_" . $1;
	$pfam = "PF" . $2;
	$pfam_name = $3;
	$pfam_desc = $6;
##	$go = "GO:" . $7;
    
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
##	print "INSERT INTO gene_tbl (gene_id, pfam, pfam_name, pfam_desc, go) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc', '$go');\n";
	print "UPDATE `amazon_river`.`gene_tbl` SET `pfam` = '$pfam', `pfam_name` = '$pfam_name', `pfam_desc` = '$pfam_desc' WHERE `gene_tbl`.`gene_id` ='$orf_id';\n";


   			
    }
    
}

exit 0;
