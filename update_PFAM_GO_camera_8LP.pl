#!/usr/bin/perl -w

#
# gera a query para atualizar pfam no banco
#
# sintaxe: ./update_pfam_camera_8S.pl 8LP < saida_anot_camera_pfam.out 
#
# 8LP_51.1921     GO:0016671      PFAM    PF01625 1.2e-58 oxidoreductase activity, acting on sulfur group of donors, disulfide as acceptor

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
    if($_ =~ /$point\_(\d+\.\d+)\tGO\:(\d+)/){
	$orf_id = $point . "_" . $1;
#	$pfam = "PF" . $2;
#	$pfam_name = $3;
#	$pfam_desc = $4;
	$go = "GO:" . $2;
    
#	print "UPDATE `unigene_ngs`.`gene_tbl` SET `product` = '$product' WHERE `gene_tbl`.`gene_id` ='$gene_id';\n"; 
##	print "INSERT INTO gene_tbl (gene_id, pfam, pfam_name, pfam_desc, go) VALUES ('$orf_id', '$pfam', '$pfam_name', '$pfam_desc', '$go');\n";
	print "UPDATE `amazon_river`.`gene_tbl` SET `go` = '$go'  WHERE `gene_tbl`.`gene_id` ='$orf_id';\n";


   			
    }
    
}

exit 0;
