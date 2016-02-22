#!/usr/bin/perl -w

# script para nomes fasta de um arquivo fasta da saida metagenemark - 8LP

if ($#ARGV < 1){
    print "Use: get_fasta.pl <Arq Clones> <Arq seqs>\n";
    exit;
}

if (!open ARQ,$ARGV[0]){   # Abrir e ler o arquivo de entrada, o segundo parametro
    print "Nao foi possivel abrir o arquivo: $ARGV[0]\n ";
    exit;
}

if (!open ARQ2,$ARGV[1])   # Abrir e ler o arquivo de entrada, o segundo parametro
{
    print "Nao foi possivel abrir o arquivo: $ARGV[1]\n ";
    exit;
}

my $key;
my $key1;
my $key2;
my $key3;
my $contig;

##
#contig-100_0 length_81572 read_count_117649     GeneMark.hmm    CDS     1       288     .       +       0       gene_id 1
# >gene_id_1

while (<ARQ>) {
    if (/^contig-100_(\d+)(.*)gene_id\s+(\d+)/) {
        $contig = "8LP_" . $1 . "." . $3;
	$key1 = $3;
##        chop $key1;
##        print "==1 $contig == $key1\n"; 
	open (ARQ2,$ARGV[1]);
	while(<ARQ2>) {
	    if (/^\>gene_id_(\d+)/){
                $key2 = $1;
#		print "==2 $key2 ==\n";
    		if ($key1 eq $key2) {
#    		if ($key2=~ $key) {
			$control = 1;
			} else {
		    	$control = 0;
			}
	    	}
        		
	    	if ($control) {
		#print OUT $_;
			if ($_ =~ $key2) {
				print ">$contig \n";
				} else {
				print $_;
 				}
	    
		}
	}
	close(ARQ2);
    	} else {
	next;
    	}		
}	

