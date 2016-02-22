#!/usr/bin/perl -w

my $numOfReads = $ARGV[0];

my $arq = $ARGV[1];

my $currentPiece = 2;

my $seqAtual = 1;

open(ARQ,">$ARGV[1].$currentPiece");

open(IN,$ARGV[1]);

while(<IN>){

	if($_ =~ /^(>.*)/){
		my $headerAtual = $1;
		$seqAtual++;
		if(($seqAtual % $numOfReads) == 0){
			close(ARQ);
			$currentPiece++;
			open(ARQ,">$ARGV[1].$currentPiece");
		}
		print ARQ "$headerAtual\n";
	}
	else{
		print ARQ $_;
	}
}

close(ARQ);
close(IN);

exit 0;
