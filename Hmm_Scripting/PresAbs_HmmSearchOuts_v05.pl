#!/usr/bin/perl 

#system("mkdir HmmSearchComps");
#system("mkdir HmmSearchComps_Summaries");
#open(OUT, "> SearchCompSummary.hmm") or die "cannot open SearchCompSummary.hmm:$!";

%queries = ();
%references = ();

$batch_count = 0;
system("rm -rf ./Out_Fastas/");
system("rm -rf ./HmmSearch_Outputs");
system("rm -rf ./HmmSearch_Summaries");
system("mkdir Out_Fastas");

while(defined($hmm_in=glob("*.hmmsearch"))) #Pull in blast queries cycle 
{
	@hmm_file = (split/\./,$hmm_in);
	@hmm_file_2 = (split/\_/,$hmm_file[0]);
	$query = $hmm_file_2[0];
	
	if (exists $hmm_file_2[4])
	{
		$ref = "$hmm_file_2[2]\_$hmm_file_2[3]\_$hmm_file_2[4]";
	}	
	else
	{
		$ref = "$hmm_file_2[2]\_$hmm_file_2[3]";
	}
		
#	print "hmm_name\t\t$hmm_name\n";

	if(exists $queries{$query})
	{}
	else
	{
		$queries{$query} = ();
	}
	if(exists $references{$ref})
	{}
	else
	{
		$references{$ref} = ();
	}
	$count = 0;
	
	open(IN, "< $hmm_in") or die "cannot open $hmm_in:$!";
	@hits = ();
	while(defined($line=<IN>))
	{
		if ($line =~ m/^#/)
		{}
		else
		{
			@hit_line = split(/\s/,$line);
			push @hits, $hit_line[0];
		}
	}
	close(IN);
	
	$file_name = "$ref.faa";
	if (length(@hits) > 0)
	{
		open(OUT, "> ./Out_Fastas/$hmm_file[0].fa") or die "cannot open ./Out_Fastas/$hmm_file[0].fa:$! ";
		open(GENOME, "< ./Prot_orfs/$file_name") or die "cannot open ./Prot_orfs/$file_name:$! ";

		foreach $a (@hits)
		{
			%Entry = ();
			$check = 0;
			$seq = ();
			while(defined($genome_line = <GENOME>))
			{
				chomp($genome_line);
				if ($a =~ m/^>$genome_line$/g)
				{
					$check = 1;
					$Entry{$a} = $seq;
				}
				elsif(($check == 1) && ($genome_line =~ m/^>/))
				{
					last;
				}
				elsif($check == 1)
				{
					$genome_line =~ s/\s//g;
					$seq .= $genome_line;
					$Entry{$a} .= $seq;
				}
				
			}	
			print OUT ">$ref\_\_$a\n";
			print OUT "$Entry{$a}\n";	
		}
		close(GENOME);	
	}
}

#Still need to create a presAbs matrix from the data.


system("mkdir HmmSearch_Outputs");
system("mkdir HmmSearch_Summaries");
#system("cp *.hmmsearch ./HmmSearch_Outputs");
system("mv *.hmmsearch ./HmmSearch_Outputs");
open(HMM_SUM, "> ./HmmSearch_Summaries/Summary.txt") or die "cannot open ./HmmSearch_Summaries/Summary.txt:$!";


foreach $baseque (keys(%queries))
{
	print HMM_SUM "$baseque\t";
}
print HMM_SUM "\n";

foreach $ref (keys(%references))
{
	print HMM_SUM "$ref\t";
	foreach $que (keys(%queries))
	{
		$filename = "./Out_Fastas/$que\_vs\_$ref.fa";
		$size = -s $filename;
#		print "$size\t$filename\n";
		if ($size > 90)
		{
			print HMM_SUM "\t.";
		}
		else
		{
			print HMM_SUM "\tX";
		}
	
#		open(OUT_FASTA, "< ./Out_Fastas/$que\_vs\_$ref.fa") or die "cannot open ./Out_Fastas/$que\_vs\_$ref.fa:$!";
#		while(defined($fa_line = <OUT_FASTA>))
#		{
#			if($fa_line =~ /^>/)
#			{
#				print HMM_SUM ".\t";
#			}
#			else
#			{
#				print HMM_SUM "X\t";
#			}
#		}
	}
	print HMM_SUM "\n";
}
