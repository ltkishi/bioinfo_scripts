#!/usr/bin/perl -w

# script para pegar nomes, ids do arquivo saida metagenemark .gff - 8LP
# inserindo IDs em gene_tbl, id e projeto
# kishi 
##contig-100_0 length_81572 read_count_117649     GeneMark.hmm    CDS     1       288     .       +       0       gene_id 1


my $orf;
my $start;
my $end;
my $frame;
my $length;
my $proj = $ARGV[0];


while (<STDIN>) { 
        if($_ =~ /$proj\_(\d+)\s+length_(\d+)\s+read_count_(\d+)(.*)CDS\s+(\d+)\s+(\d+)\s+\S+\s+(\S+)(.*)gene_id\s+(\d+)/){
                $orf = $proj . "_" . $1 . "." . $9;
                $start = $5;
                $end = $6;
                $frame = $7;
                $length = ($6 - $5);
##print "INSERT INTO orf_aa_tbl (orf_aa_id, sequence) VALUES ('$seq', '$sequence');\n";
                print "INSERT INTO gene_tbl (gene_id, project) VALUES ('$orf', $proj);\n";

        }
}


