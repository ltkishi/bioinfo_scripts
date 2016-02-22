#!/usr/bin/perl

#Calculating N50 of contig assembly file
#N50 is most often used in draft genome assembly - can be defined as the largest entity E such that at least half of the total size of the entities is contained in entities larger than E. For example if we have a collection of contigs with sizes 7, 4, 3, 2, 2, 1, and 1 kb (total size = 20kbp), the N50 length is 4 because we can cover 10 kb with contigs bigger than 4kb.
#
#Here is a small step by step protocol to calculate N50:

#1. Read Fasta file and calculate sequence length.
#2. Sort length on reverse order.
#3. Calculate Total size.
#4. Calculate N50.

## Read Fasta File and compute length ###
my $length;
my $totalLength;
my @arr;
while(<STDIN>){
   chomp;
   if(/>/){
   push (@arr, $length);
   $totalLength += $length;
   $length=0;
   next;
  }
  $length += length($_);
}

close(FH);

my @sort = sort {$b <=> $a} @arr;
my $n50;
foreach my $val(@sort){
     $n50+=$val;
      if($n50 >= $totalLength/2){
         print "N50 length is $n50 and N50 value is: $val\n";
         last;
     }
}
 
#If each sequence length is given in fasta header then one can grep '>' inputfile > out and do proper substitution
#to get only the values(see vim editor section of the blog).
#Then do a
#$ sort -g -r inputfile > out
#$ awk '{sum+=$1}END{print "Total:", sum} out  # To calculate total
#$ Total : Number

# Then use second part of the perl subroutine to get the N50 value

    
