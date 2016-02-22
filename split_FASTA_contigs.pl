#!/usr/bin/perl

# Adapted by use for pipelinEST (shinapes) 10jul01.

# Script to split the BIG FASTA file in many FASTAS files

#push (@INC,"/home/bioinfo/pipelinEST");

#require ".new_pipelinEST.defaults";

if (($#ARGV < 1) || ($#ARGV > 1)) {
    print "Usage: split_FASTA.pl <FASTA_FILE> <OUTPUT_PATH>; nargv=".($#ARGV+1)."\n";
    exit(1);
}

# Open the BIG file of FASTA
open (ARQ,"<$ARGV[0]") or die "Could not open input file $ARGV[0]: $!\n";

# Check the BIG FASTA file
$_begin_ = 0;
while (<ARQ>) {

    # Begin of the new fasta sequence
    /^>(\S+)/ && do {

        if ($_begin_ == 1) {

            # Create a file of the single fasta sequence
            $_filename_ = $ARGV[1]."/".$_name_."\.fasta";
            open (ARQOUT,">$_filename_") or die "Could not create output file $_filename_: $!\n";
	    print ARQOUT $_result_."\n";
	    close (ARQOUT);

	    $_result_ = "";
	
	}

        $_name_ = $1;
	chomp ($_name_);
        $_begin_ = 1;
	$_result_ .= ">".$_name_."\n";
	next;
    
    };

    chomp();
    $_col_ = 0;
    @_base_ = split ('',$_);
    foreach (@_base_) {
        $_result_ .= $_;
	$_col_++;
	if ($_col_ == 60) {
	    $_result_ .= "\n";
	    $_col_ = 0;
	}
    }

}

close (ARQ);

if ($_begin_ == 1) {

    # Create a file of the single fasta sequence
    $_filename_ = $ARGV[1]."/".$_name_."\.fasta";
    open (ARQOUT,">$_filename_") or die "Could not create output file $_filename_: $!\n";
    print ARQOUT $_result_;
    close (ARQOUT);

}

exit 0;
