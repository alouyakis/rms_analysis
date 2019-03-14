#!/usr/bin/perl 

#system("mkdir HmmSearchComps");
#system("mkdir HmmSearchComps_Summaries");
#open(OUT, "> SearchCompSummary.hmm") or die "cannot open SearchCompSummary.hmm:$!";

$batch_count = 0;

while(defined($hmm_in=glob("./Hmms/*.hmm"))) #Pull in blast queries cycle 
{
	@hmm_file = (split/\./,$hmm_in);
	@hmm_file_2 = (split/\_/,$hmm_file[0]);
	$hmm_name = $hmm_file_2[0];
#	print "hmm_name\t\t$hmm_name\n";
	
	$count = 0;
	
	
	while(defined($db_in=glob("./Prot_orfs/*.faa")))
	{
		$count+=1;

		@db_file = (split/\./,$db_in);
#		@db_file_2 = (split/\.trans/,$db_file[2]);
		$db_name = $db_file[0];
#		print "hmm_name\t\t\t$hmm_name\t\t\tdb_name\t\t\t$db_name\n";

		$name = "$hmm_name_vs_$db_name.hmmsearch";	
		system("hmmsearch -o $hmm_name\_vs\_$db_name\.hmmsearch --tformat fasta --tblout $hmm_in $db_in");

	}
	
}

