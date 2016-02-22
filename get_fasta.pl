#!/usr/bin/perl -w

# script para pegar fasta de um arquivo com nomes.
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


while (<ARQ>) {
    if (/^\>(\S+)/) {
	$key = $1;
#        print "==1 $key ==\n"; 
	open (ARQ2,$ARGV[1]);
	while(<ARQ2>) {
	    if (/^\>(\S+)/){
                $key2 = $1;
#		print "==2 $key2 ==\n";
    		    if ($key2 eq $key) {
		    $control = 1;
		} else {
		    $control = 0;
		}
	    }
	    if ($control) {
		#print OUT $_;
		print $_;
	    }
	}
	close(ARQ2);
    } else {
	next;
    }		
}	

