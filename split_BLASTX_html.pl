#!/usr/bin/perl -w

# Adapted by use for pipelinEST (kishi) 17set02.

# Script to split the BIG BLASTX file in many small BLASTX file for each Query

#push (@INC,"/home/bioinfo/pipelinEST");

#require ".new_pipelinEST.defaults";

if (($#ARGV < 1) || ($#ARGV > 1)) {
    print "Usage: split_BlastX_html.pl <BLASTX_FILE> <OUTPUT_PATH>; nargv=".($#ARGV+1)."\n";
    exit(1);
}

# Open the BIG file of BLASTX
open (ARQ,"<$ARGV[0]") || die "Could not open input file $ARGV[0]: $!\n";

# Check the BIG BLASTX file
$_begin_ = 0;
while (<ARQ>) {

    # Begin of the new blastx result
    /<b>BLASTX / && do {

        if ($_begin_ == 1) {

            # Create a file of the single blastx result
###            $_filename_ = $ARGV[1]."/".$_query_name_."\.BLASTX";
            $_filename_ = $ARGV[1]."/".$_query_name_."\.blastx.html";
            open (ARQOUT,">$_filename_") or die "Could not create output file $_filename_: $!\n";
	    print ARQOUT "<HTML><HEAD><TITLE></TITLE></HEAD><body>\n<br> $_result_\n<br></body></HTML>" ;
	    close (ARQOUT);

	    $_result_ = "";
	
	}

        $_begin_ = 1;
    
    };

    # Get the name of the query
    /^\<b\>Query=\<\/b\> (\S+)/ && do {

        $_query_name_ = $1;
	chomp ($_query_name_);
    
    };

    $_result_ .= $_;

}

close (ARQ);

if ($_begin_ == 1) {

    # Create a file of the single blastx result
##    $_filename_ = $ARGV[1]."/".$_query_name_."\.BLASTX";
    $_filename_ = $ARGV[1]."/".$_query_name_."\.blastx.html";
    open (ARQOUT,">$_filename_") or die "Could not create output file $_filename_: $!\n";
    print ARQOUT "<HTML><HEAD><TITLE></TITLE></HEAD><body>\n<br> $_result_\n<br></body></HTML>";
    close (ARQOUT);
}

exit 0;
