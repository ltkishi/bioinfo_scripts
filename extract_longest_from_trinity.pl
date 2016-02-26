#!/usr/bin/env perl

# script para extrair fastas das maiores isoformas


use strict;
use warnings;

my ($file)    = shift;
my ($tabSize) = shift;
    $tabSize  = 80 unless (defined($tabSize));

my %genes   = ();
my %queries = ();

# Read by FASTA record
local $/ = "\n>";

open(IN, $file) or die("Unable to open file $file");
while (my $sequence = <IN>)
{
	chomp($sequence);
	
	# Get sequence ID, length and gene ID
##	my ($seqId, $length) = $sequence =~ m/^>?([^\s]*)\slen=(\d+)/;
	my ($seqId, $length) = $sequence =~ m/^(\S+)\slen=(\d+)/;
#	print "2==$seqId\n";
	
##	my ($genId) = $seqId =~ m/(c\d+_g\d+)_/;
	my ($genId) = $seqId =~ m/(\S+)_c\d+/;
#	print "2==$genId\n";
	
	if (exists($genes{$genId}))
	{
		my (@fields) = split("\t", $genes{$genId});
		my ($prevLength) = $fields[1];
		$genes{$genId} = "$seqId\t$length" if ($length > $prevLength);
	}
	else
	{
		$genes{$genId} = "$seqId\t$length";
	}
}
close(IN);

foreach my $key (keys %genes)
{
	my ($seqId, $length) = split("\t", $genes{$key});
	$queries{$seqId} = 1;
}

open(IN, $file) or die("Unable to open file $file");
while (my $sequence = <IN>)
{
	chomp($sequence);

	# Get sequence ID
	my ($seqId) = getSequenceID($sequence);

	# Search until requested ID is found
	next unless (exists($queries{$seqId}));

	# Remove element from Hash
	delete $queries{$seqId};

	# Get sequence header
	my ($header) = getSequenceHeader($sequence);

	# Format it
	$sequence = formatFasta($tabSize, $sequence);

	print ">", $header, "\n", $sequence, "\n";
}
close(IN);


# ### SUBROUTINES ###

sub getSequenceID
{
	my ($sequence) = shift;
	my ($id) = $sequence =~ m/^>?([^\s]*)\s/;
	return($id);
}

sub getSequenceHeader
{
	my ($sequence) = shift;
	my ($header) = $sequence =~ m/^>?([^\n]*)\n/;
	return($header);
}

sub flattenFasta
{
	my ($sequence) = shift;

	# Remove FASTA header
	$sequence =~ s/^>?([^\n]*)\n//;

	# Remove END LINES
	$sequence =~ s/[\n>]*//g;

	return($sequence);
}

sub formatFasta
{
	my ($tabSize)  = shift;
	my ($sequence) = shift;

	$sequence = flattenFasta($sequence);

	# Determine sequence length
	my ($length) = length($sequence);

	# Set the sequence in fixed size format
	my ($f_seq)     = '';
	my ($quotient)  = int($length / $tabSize);
	my ($remainder) = ($length % $tabSize);
	for (my $i = 0; $i < $quotient; $i++) {
		$f_seq .= substr($sequence, $i * $tabSize, $tabSize) . "\n";
	}
	$f_seq .= substr($sequence, $quotient * $tabSize, $remainder);
	chop($f_seq) if ($f_seq =~ m/\n$/);

	return($f_seq);
}
