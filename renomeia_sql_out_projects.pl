#!/usr/bin/perl -w

# script para nomes do arquivo .gff com gene_id errado corrigindo para id com nome do projeto
# ./renomeia_sql_out_projects.pl arq.gff arq_para_corrigir.sql 1S 

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

$proj = $ARGV[2];

my $key;
my $key1;
my $key2;
my $contig;
my $inicio;
my $fim;
my $orf;

##
#contig-100_0 length_81572 read_count_117649     GeneMark.hmm    CDS     1       288     .       +       0       gene_id 1
# >gene_id_1

while (<ARQ2>) {

	if (/(.*)gene_id_(\d+)\.(\d)(.*)/){
		$inicio = $1;
                $key2 = $2;
                $fim = $4;

		open (ARQ,$ARGV[0]);

		## 1S_0 length_196917 read_count_137946    GeneMark.hmm    CDS     2       619     .       +       0       gene_id 1
		while(<ARQ>) {
   # 			if (/^1S_(\d+)\s(.*)gene_id\s+(\d+)/) {
    			if (/$proj\_(\d+)\s(.*)gene_id\s+(\d+)/) {
		              	$orf = $proj . "_" . $1 . "." . $3;
           		      	$contig = $1;
				$key1 = $3;

				if ($key2 eq $key1) {
					print "$inicio$orf$fim \n";
				}

	    		}
		}
	}
	close(ARQ);
}	
close(ARQ2);

