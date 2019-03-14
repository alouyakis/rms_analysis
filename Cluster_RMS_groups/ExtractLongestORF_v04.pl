#!/usr/bin/perl

system("mkdir LongestORF");
open(OUT, "> ./LongestORF/Longest_HG_Orfs.HGsingle") or die "cannot open $group.remove:$!";
while(defined($group=glob("./Copy_Intersection/*.faa"))) #formatdb cycle
{
	open(IN, "< $group") or die "cannot open $group:$!";
	@orf_1 = split(/\//,$group);
	@orfID = split(/\./,$orf_1[-1]);
#	@orfID = split(/\_/,$group);
	@CurrentORF = ();
	@LongestORF = ();
	$LongestORF[1] = "a";
	$count = 0;
	while(defined($line=<IN>))
	{
		chomp($line);
		if ($line=~/^>/)
		{
			$count += 1;
			if (length($CurrentORF[1]) > length($LongestORF[1]))
			{
#				print "length($CurrentORF[1])\tlength($LongestORF[1])\n";
				$LongestORF[0] = $CurrentORF[0];
				$LongestORF[1] = $CurrentORF[1]
			}
			@CurrentORF = ();
			$CurrentORF[0] = $line;
			$seq = ();
			$CurrentORF[1] = $seq;
		}
		else
		{
			$seq .= $line;
			$CurrentORF[1] = $seq;
		}	
	}
	if (length($LongestORF[0] < 1))
	{
		print OUT ">HG_$orfID[0]_$count\n$CurrentORF[1]\n";
	}
	else
	{
		print OUT ">HG_$orfID[0]$count\n$LongestORF[1]\n";
	}
	close(IN);
}
close(OUT);

open(RMS_OUT, "> ./LongestORF/Longest_RMS_Orfs.RMSsingle") or die "cannot open $group.remove:$!";
while(defined($RMS_group=glob("RMS_groups/*.fasta"))) #formatdb cycle
{
	open(RMS_IN, "< ./Copy_Intersection/$group") or die "cannot open $group:$!";
	@orfID = split(/\./,$RMS_group);
	@CurrentORF = ();
	@LongestORF = ();
	$LongestORF[1] = "a";
	$count = 0;
	while(defined($line=<IN>))
	{
		chomp($line);
		if ($line=~/^>/)
		{
			$count += 1;
			if (length($CurrentORF[1]) > length($LongestORF[1]))
			{
#				print "length($CurrentORF[1])\tlength($LongestORF[1])\n";
				$LongestORF[0] = $CurrentORF[0];
				$LongestORF[1] = $CurrentORF[1]
			}
			@CurrentORF = ();
			$CurrentORF[0] = $line;
			$seq = ();
			$CurrentORF[1] = $seq;
		}
		else
		{
			$seq .= $line;
			$CurrentORF[1] = $seq;
		}	
	}
	if (length($LongestORF[0] < 1))
	{
		print RMS_OUT ">HG_$orfID[0]_$count\n$CurrentORF[1]\n";
	}
	else
	{
		print RMS_OUT ">HG_$orfID[0]$count\n$LongestORF[1]\n";
	}
	close(RMS_IN);
}
close(RMS_OUT);