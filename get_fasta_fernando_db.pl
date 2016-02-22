#!/usr/bin/perl -w

## use get_categ_XF_db.pl arquivo_nomes  

use CGI qw(:standard);
use strict;
use DBI;
use CGI qw(:all);

if ($#ARGV < 0 ){
    print "Use: get_categ_XF_db.pl <Arq>\n";
    exit;
}

open(IN,$ARGV[0]);

my $dbh = DBI->connect( 'dbi:mysql:will' ,
                        'root' ,
                        'MySQL' ,
                        {
                          RaiseError => 1,
                          AutoCommit => 0
			  }
                        ) || die "Erro ao conectar unigene: $DBI::errstr";

my $id;
my $seq;
my $gene_id;
my $sth;
#my $org;

while(<IN>){
    chomp $_;
#    if ($_ =~ /^CLas-(\w+)-(\d+)/){
#    if (/.*/){
#         $org = $1; 
#         $gene_id = $2;
#
#     }

##    if (/.*/){
    if ($_ =~ /(\S+)/){	
        $gene_id = $1;
	
    	$sth = $dbh->prepare("select id, sequence from seq where id =\"$gene_id\"");
 	$sth->execute();

	while(my @row = $sth->fetchrow_array){
	    $id = $row[0];
	    $seq = $row[1];
	    
#	    print ">CIT-$org-$id\n$seq\n";

#		print "TYPE:	Pub\n";
#		print "TITLE:	Transcriptional profile of biomass degrading genes from Trichoderma harzianum IOC-3844: a promising source of cellulases and hemicellulases for biomass deconstruction and second generation ethanol conversion.\n";
#		print"AUTHORS:	Malago-Jr, W.\; Santos-Silva, L. K.\; Pereira, N. Jr.\; Henrique-Silva, F.\n";
#		print"JOURNAL:	\n";
#		print"VOLUME:	\n"; 
#		print"ISSUE:	\n";
#		print"PAGES:	\n"; 
#		print"YEAR:	\n"; 
#		print"STATUS:	2\n";
#		print"\|\|\n\n";

#		print"TYPE:	Lib\n";
#		print"NAME:	Trichoderma harzianum IOC-3844 cellulose-iduced library.\n";
#		print"ORGANISM:	Trichoderma harzianum\n"; 
#		print"STRAIN:	IOC-3844\n";
#		print"VECTOR:	pDONR-222\n";
#		print"DESCR:	High quality sequence from a cDNA cellulose-iduced library. ESTs originated from oligo-dT and sequenced from 5' end.\n";
#		print"\|\|\n\n";

#		print"TYPE:	Cont\n";
#		print"NAME:	Malago-Jr, W.\n";
#		print"FAX:	\+55-16-33518377\n";
#		print"TEL:	\+55-16-33518378\n";
#		print"EMAIL:	malago.jr\@gmail.com\n";
#		print"LAB:	LBM - Department of Genetics and Evolution\n";
#		print"INST:	Federal University of Sao Carlos\n";
#		print"ADDR:	Rodovia Washington Luis, Km 235, São Carlos, SP, Brazil.\n";
#		print"\|\|\n\n";

		print"TYPE: EST\n";
		print"STATUS: New\n";
		print"CONT_NAME: Fonseca, F. P. P.\n";
		print"CITATION: Sphenophorus levis transcriptome: more insights of coleopteran digestive system.\n";
		print"LIBRARY:  High quality sequence from a cDNA library of 30 Sphenophorus levis larvae, 30 days old. Library built of full lenght gut, hemolymph and fat body.\n";
		print"EST: " .	$id . "\n";
		print"CLONE: " . $id . "\n";
		print"DNA_TYPE:	cDNA\n";
		print"SEQUENCE:\n"; 
		print $seq . "\n";
		print" \|\|\n\n";


	}
    }
}

$sth->finish();
$dbh->disconnect();

