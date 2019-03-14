#!/usr/bin/perl 
use strict;
use warnings;
#use Cwd;
#use Algorithm::Combinatorics qw(combinations);

my $threshold = 1e-20;
my @Banish = qw(All_Type_II_RestrictionEnzyme_genes_HG2724 Other_methyltrans_genes_HG260 Other_methyltrans_genes_HG2466 All_C_genes_HG6 Other_methyltrans_genes_HG1261 All_Type_II_RestrictionEnzyme_genes_HG1799 All_Type_II_RestrictionEnzyme_genes_HG1247 All_Type_II_RestrictionEnzyme_genes_HG245 All_Type_I_S_subunit_genes_HG790 Other_methyltrans_genes_HG872);
my @non_RMS = qw(All_V_genes_HG54 All_cytosine5_methyltrans_genes_HG1547 All_Type_I_R_subunit_genes_HG380 Other_methyltrans_genes_HG3630 All_Type_I_R_subunit_genes_HG483 Other_methyltrans_genes_HG2998 Other_methyltrans_genes_HG3679 Other_methyltrans_genes_HG239 All_Type_I_S_subunit_genes_HG3136 All_Type_II_RestrictionEnzyme_genes_HG1799 All_Type_II_RestrictionEnzyme_genes_HG1862 Other_methyltrans_genes_HG3679 All_C_genes_HG11 All_Type_II_RestrictionEnzyme_genes_HG1799 All_Type_II_RestrictionEnzyme_genes_HG1799 All_Type_II_RestrictionEnzyme_genes_HG1178 All_cytosine5_methyltrans_genes_HG830 All_Type_I_R_subunit_genes_HG693 Other_methyltrans_genes_HG3679 All_Type_I_S_subunit_genes_HG3230 All_Type_I_S_subunit_genes_HG3117 All_Type_I_S_subunit_genes_HG2243 All_Type_I_S_subunit_genes_HG4137 All_V_genes_HG55 All_amino_methyltrans_genes_beta_HG821 All_Type_II_RestrictionEnzyme_genes_HG2904 All_Type_I_R_subunit_genes_HG483 Type_II_methyltrans_genes_HG4617 All_Type_IIG_enzyme_genes_HG1029 Type_II_methyltrans_genes_HG1690 All_amino_methyltrans_genes_gamma_HG868 All_amino_methyltrans_genes_gamma_HG412 All_amino_methyltrans_genes_gamma_HG761 Type_II_methyltrans_genes_HG1869 All_amino_methyltrans_genes_gamma_HG864 All_amino_methyltrans_genes_gamma_HG859 Type_II_methyltrans_genes_HG2664 Type_II_methyltrans_genes_HG6222 Type_II_methyltrans_genes_HG2607 All_amino_methyltrans_genes_gamma_HG573 All_amino_methyltrans_genes_gamma_HG378 Type_II_methyltrans_genes_HG5274 All_amino_methyltrans_genes_gamma_HG1098 All_amino_methyltrans_genes_gamma_HG860 Type_II_methyltrans_genes_HG2665 All_amino_methyltrans_genes_gamma_HG346 All_amino_methyltrans_genes_gamma_HG578 All_amino_methyltrans_genes_alpha_HG316 Type_II_methyltrans_genes_HG1230 Type_II_methyltrans_genes_HG4331 Type_II_methyltrans_genes_HG4354 Type_II_methyltrans_genes_HG4337 Type_II_methyltrans_genes_HG4406 Type_II_methyltrans_genes_HG5690 All_amino_methyltrans_genes_gamma_HG1211 Type_II_methyltrans_genes_HG3815 All_amino_methyltrans_genes_gamma_HG577 All_amino_methyltrans_genes_gamma_HG1096 Type_II_methyltrans_genes_HG5661 All_amino_methyltrans_genes_gamma_HG391 Type_II_methyltrans_genes_HG769 All_amino_methyltrans_genes_beta_HG180 All_Type_IIG_enzyme_genes_HG230 All_Type_III_M_subunit_genes_HG478 All_Type_IIG_enzyme_genes_HG905 Type_II_methyltrans_genes_HG3913 Other_methyltrans_genes_HG1610 Other_methyltrans_genes_HG65 Other_methyltrans_genes_HG169 Type_II_methyltrans_genes_HG4658 All_Type_II_RestrictionEnzyme_genes_HG239 Other_methyltrans_genes_HG2508 Type_II_methyltrans_genes_HG3917 All_Type_IIG_enzyme_genes_HG1234 All_Type_II_RestrictionEnzyme_genes_HG2333 All_Type_II_RestrictionEnzyme_genes_HG3179 Other_methyltrans_genes_HG239 Other_methyltrans_genes_HG2924 All_Type_II_RestrictionEnzyme_genes_HG1766 Other_methyltrans_genes_HG3293 Other_methyltrans_genes_HG1058 Type_II_methyltrans_genes_HG170 All_Type_II_RestrictionEnzyme_genes_HG1089 All_Type_I_S_subunit_genes_HG4453 All_Type_I_S_subunit_genes_HG2123 All_Type_I_S_subunit_genes_HG3135 All_Type_I_S_subunit_genes_HG4110 All_Type_I_S_subunit_genes_HG3647 All_Type_I_S_subunit_genes_HG3603 All_Type_I_S_subunit_genes_HG3136 All_Type_I_S_subunit_genes_HG2757 All_Type_I_R_subunit_genes_HG217 All_Type_II_RestrictionEnzyme_genes_HG2294 All_Type_II_RestrictionEnzyme_genes_HG1746 All_Type_II_RestrictionEnzyme_genes_HG282 Type_II_methyltrans_genes_HG321 All_amino_methyltrans_genes_beta_HG16 All_Type_II_RestrictionEnzyme_genes_HG3245 All_amino_methyltrans_genes_beta_HG11 All_Type_III_M_subunit_genes_HG606 All_Type_II_RestrictionEnzyme_genes_HG584 All_Type_II_RestrictionEnzyme_genes_HG1170 All_amino_methyltrans_genes_beta_HG941 All_Type_II_RestrictionEnzyme_genes_HG1156 All_Type_II_RestrictionEnzyme_genes_HG2766 All_Type_IIG_enzyme_genes_HG1262 Type_II_methyltrans_genes_HG2048 All_Type_II_RestrictionEnzyme_genes_HG103 All_Type_II_RestrictionEnzyme_genes_HG3593 All_Type_II_RestrictionEnzyme_genes_HG3177 All_Type_IIG_enzyme_genes_HG909 All_Type_II_RestrictionEnzyme_genes_HG171 All_Type_II_RestrictionEnzyme_genes_HG269 All_Type_II_RestrictionEnzyme_genes_HG3981 All_Type_II_RestrictionEnzyme_genes_HG127 Type_II_methyltrans_genes_HG3173 Type_II_methyltrans_genes_HG5377 All_Type_II_RestrictionEnzyme_genes_HG3223 All_Type_II_RestrictionEnzyme_genes_HG3185 All_Type_IIG_enzyme_genes_HG1301 Other_methyltrans_genes_HG0 Other_methyltrans_genes_HG2071 Type_II_methyltrans_genes_HG243 All_Type_II_RestrictionEnzyme_genes_HG2370 All_Type_II_RestrictionEnzyme_genes_HG1846 All_Type_II_RestrictionEnzyme_genes_HG318 All_Type_II_RestrictionEnzyme_genes_HG1862 All_Type_II_RestrictionEnzyme_genes_HG2369 All_Type_II_RestrictionEnzyme_genes_HG3277 All_Type_II_RestrictionEnzyme_genes_HG3652 All_Type_II_RestrictionEnzyme_genes_HG1228 Other_methyltrans_genes_HG2998 Type_II_methyltrans_genes_HG3294 All_Type_I_M_subunit_genes_HG3 All_C_genes_HG11 All_Type_II_RestrictionEnzyme_genes_HG2841 All_Type_I_R_subunit_genes_HG379 All_Type_I_R_subunit_genes_HG693 All_Type_I_R_subunit_genes_HG223 All_Type_II_RestrictionEnzyme_genes_HG1835 All_Type_I_R_subunit_genes_HG802 Type_II_methyltrans_genes_HG6529 All_Type_II_RestrictionEnzyme_genes_HG330 All_Type_II_RestrictionEnzyme_genes_HG1178 All_Type_I_R_subunit_genes_HG460 All_Type_I_R_subunit_genes_HG380 All_Type_IIG_enzyme_genes_HG1418 All_Type_II_RestrictionEnzyme_genes_HG3661 Type_II_methyltrans_genes_HG6018 Type_II_methyltrans_genes_HG4030 All_V_genes_HG134 All_V_genes_HG131 All_V_genes_HG0 All_V_genes_HG57 All_V_genes_HG168 All_V_genes_HG58 All_V_genes_HG166 All_V_genes_HG214 All_V_genes_HG1 All_V_genes_HG191 All_V_genes_HG56 All_V_genes_HG215 All_V_genes_HG192 All_V_genes_HG240 All_V_genes_HG63 All_V_genes_HG94 All_V_genes_HG239 All_V_genes_HG133 All_V_genes_HG167 All_V_genes_HG180 All_V_genes_HG242 All_V_genes_HG237 All_V_genes_HG241 All_V_genes_HG66 All_V_genes_HG54 All_V_genes_HG61 All_V_genes_HG59 All_V_genes_HG132 All_V_genes_HG93 All_V_genes_HG95 All_V_genes_HG243 All_V_genes_HG169 All_cytosine5_methyltrans_genes_HG845 All_cytosine5_methyltrans_genes_HG1547 All_V_genes_HG212 Type_II_methyltrans_genes_HG5997 Other_methyltrans_genes_HG3679 All_cytosine5_methyltrans_genes_HG1384 Other_methyltrans_genes_HG3630);

#&Make_db;	#Prep arCOG database for BLASTing against
#&Blast_genomes;	#Take genomes in ./Prot_orfs/ and search against arCOG db
#&Sort_and_Extract;	#Filter through .bla results in ./Prot_orfs/analyzed	Build folder arCOGs_analyzed - relate arCOG info in ar14.arCOG.csv & ar14.arCOGdef.tab to produce .arcog file relating ORFs to arCOG groups

#&Compare_to_RMS;	#Relate ORFs, HGs, and arCOGs together. Create Genome_to_fig.key -> relates ORF IDs to genome names. Requires: ./RMS_HGs_Filtered_1e-10 which includes .filtered results containing relation of genome's ORFs to HGs
#&Make_Interaction_Table_Genome;	#Create files relating ORFs to arCOGs		Use R connection to create edgelist file
#&Make_Interaction_Table_REBASE;	#Create files relating HGs to arCOGs		Use R connection to create edgelist file

#&Collapse_Results;

#&Consolidate_REBASE_HGs; <- Does not work correctly

#&Consolidate_Genome_HGs;
#&Collapse_RMS_cHGs;


#&RetrieveORFs_byOrganism;
#&PresAbs;

# Internally called subs:

#&Add_arCOG;	#Receive [0] fig-orf ID [1] Genome ID		#Taking the input, look up the arCOG and return ID
#&Check_Purged_HGs	#Recieve [0] HG id for checking ($HG_id)	#Taking the input HG, check against the @Removals

#######################################################################################

sub PresAbs
{
#	my @genomes = @_;
	
	my %genomes = ();
	my %hgs = ();
	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/*.fa")))
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(cHG, "< $file");		
		my $no_carrot = ();
		while(defined(my $chg_line = <cHG>))
		{
			if ($chg_line =~ /^>/)
			{
				my @chg_array = split(/\t/,$chg_line);
				$hgs{$filn_2[0]} = "$chg_array[6]\t$chg_array[8]";
				$no_carrot = $chg_array[0];
				$no_carrot =~ s/>//;
				if (exists $genomes{$no_carrot}) {
					$genomes{$no_carrot} .= "\t$filn_2[0]";
				}
				else {
					$genomes{$no_carrot} = "$filn_2[0]";
				}
			}
			else {
				$genomes{$no_carrot} .= "\t$filn_2[0]";
			}
		}
		close(cHG);
	}
	open(OUT, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/PresAbsSummary.txt");
	
	my $count = 0;
	while ($count < 1)
	{
#		print OUT "\t";
		foreach $a (keys(%hgs)) {
			if ($count >=0)
			{
				print OUT "\t$a";
			}
			else {
				my @temp = split(/\t/, $hgs{$a});
				print OUT "\t$temp[$count]";
				}
		}
		print OUT "\n";
		$count++;
		
	}
	
	foreach my $gen (keys(%genomes))	#$gen is name of genome. Hash elements are \t names of cHGs
	{
		print OUT "$gen";	#print genome name in 1st position
		my @hits_to_hg = split(/\t/, $genomes{$gen});	#split the cHGs genome has hits to
		foreach my $hg (keys(%hgs))
		{
			my $true = 0;	#have not yet found match between names of cHGs and the cHGs seen by the genome
			
			foreach my $d (@hits_to_hg)	# $d is the cHGs this genome contains
			{
				if ($d eq $hg) {
					$true = 1;
				}
			}
			if ($true == 1)
			{
				print OUT "\tPresent";
			}
			else
			{
				print OUT "\tAbsent";
			}
		}
		print OUT "\n";
	}
}

sub RetrieveORFs_byOrganism
{		
	system("mkdir ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/ORFs_byOrganism");
	my %genomes = ();

	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/*.fa")))
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		
		open(cHG, "< $file");		
		my $no_carrot = ();
		while(defined(my $chg_line = <cHG>))
		{
			if ($chg_line =~ /^>/)
			{
				my @chg_array = split(/\t/,$chg_line);
				$no_carrot = $chg_array[0];
				$no_carrot =~ s/>//;
				if (exists $genomes{$no_carrot}) {
					$genomes{$no_carrot} .= $chg_line;
				}
				else {
					$genomes{$no_carrot} = $chg_line;
				}
			}
			else {
				$genomes{$no_carrot} .= $chg_line;
			}
		}
		close(cHG);
	}
	foreach $a (keys(%genomes))
	{
		open(OUT, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/ORFs_byOrganism/$a.fa ");
		print OUT "$genomes{$a}";
		close(OUT);
	}
#	&PresAbs(keys(%genomes));
}

sub Check_Purged_HGs #Recieve [0] HG id for checking ($HG_id)	#Taking the input HG, check against the @Removals
{
	my $in_id = shift;
	my $found = "F";
	foreach my $a (@Banish)
	{
#		print "a\t\t$a\t\t$HG_id\n";
		if ($a eq $in_id)
		{
#			print "MATCH!\t$a\t$HG_id\n";
			return "T";
			last;
			$found = "T"
		}
	}
#	my $count = 0;
	foreach my $b (@non_RMS)
	{
#		$count += 1;
#		print "non_RMS\t\t$count\t\t$b\n";
		if ($found eq "F")
		{
			if ($b eq $in_id)
			{
#				print "MATCH!\t$b\t$HG_id\n";
				return "T";
				last;
			}
		}
	}
}

sub Add_arCOG #Receive [0] fig-orf ID [1] Genome ID		#Taking the input, look up the arCOG and return ID
{
	my $orf = shift;
	my $genome = shift;
	
#	print "orf\t\t$orf\n";
#	print "genome\t\t$genome\n";
	open(ARCOG, "< ./Prot_orfs/arCOGs_analyzed/$genome.arcog");
	while(defined(my $line = <ARCOG>))
	{
		chomp($line);
		my @break_line = split(/\t/,$line);
#		print "$break_line[0]\t$orf\n";
		if ($break_line[0] eq $orf)
		{
			return $line;
		}
	}
}

sub Collapse_RMS_cHGs
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS");

	my %Global_arCOG_collapse = ();
	my %Collapse = ();

	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/RMS/*.fa")))
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		my %chg_comp = ();
		open(cHG, "< $file");		
		while(defined(my $chg_line = <cHG>))
		{
			chomp($chg_line);
			my @chg_split = split(/\t/,$chg_line);
			if (exists $Collapse{$chg_split[2]})
			{
				$Collapse{$chg_split[2]} .= "\t$filn_1[-1]";
			}
			else
			{
				$Collapse{$chg_split[2]} .= "$filn_1[-1]";
			}
			last;
		}
	}
	
	my $count = 1;
	foreach my $a (keys(%Collapse))
	{
		my $sprint = sprintf("%03d", $count);
		my $out_name = "cHG_collapsed_$sprint.fa";
		open(COLLAPSE, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Collapsed_RMS/$out_name");
		my @chg = split(/\t/,$Collapse{$a});
		foreach my $chg_list (@chg)
		{
			open(cHG, "< ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/RMS/$chg_list");
			while(defined(my $in_line = <cHG>))
			{
				print COLLAPSE "$in_line";
			}
		}
		close(COLLAPSE);
		$count += 1;
	}
	
}


sub Consolidate_Genome_HGs
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs");
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/RMS");
#	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/non_RMS");
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Banished");

#	my %keys = ();
#	open(KEY, "< ./Prot_orfs/arCOGs_analyzed/CompRMS/Genome_to_fig.key");
#	{
#		while(defined(my $key_line = <KEY>))	#load .key data int %keys -> key = ORF id		data = genome name
#		{
#			chomp($key_line);
#			my @k_array = split(/\t/,$key_line);
#			$keys{$k_array[0]} = $k_array[1];
#		}
#	}
#	close(KEY);
#	foreach my $g (keys(%keys))
#	{
#		print "$g\t\t$keys{$g}\n";
#	}
	
	while(defined(my $file=glob("Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/Genome_Componenets.components")))	#
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(COMP_LIST, "< $file") or die "Could not open Genome_Componenets.components, $!";
		my %Consolidated_hash = ();
		while(defined(my $comp_line = <COMP_LIST>))	#load the edgelist file from R's igraph into a %Consolidated_hash with cluster number as key. From -> .components file
		{
			chomp($comp_line);
			my @line_comp = split(/\t/,$comp_line);
			if ($line_comp[0] =~ "arCOG*")		#Only care about lines starting with ORF ids, other lines are arCOG ids and immaterial to this process
			{}
			elsif (exists $Consolidated_hash{$line_comp[1]})
			{
				$Consolidated_hash{$line_comp[1]} .= "\t$line_comp[0]";
#				print "$Consolidated_hash{$line_comp[1]}\n";
			}
			else
			{		
				$Consolidated_hash{$line_comp[1]} = "$line_comp[0]";
#				print "$Consolidated_hash{$line_comp[1]}\n";
			}
		}
		close(COMP_LIST);
		
#		open(HASH_OUT, ">Consolidated_hash.txt");
#		foreach my $ii (keys(%Consolidated_hash))
#		{
#			print HASH_OUT "$ii\t\t$Consolidated_hash{$ii}\n";
#		}
#		close(HASH_OUT);
		
		my %out_files = ();
		foreach my $a (keys(%Consolidated_hash))	#iterating through the cluster hash by cluster number ($a)
		{
			my @rebase_HGs = ();
#			print "$a\t\t$Consolidated_hash{$a}\n";
			my @HGs = split(/\t/, $Consolidated_hash{$a});	#@HGs contains every ORF that is a member in the particular cluster ($a)
			my $hg_num = sprintf("%03d", $a);
			my $file_name = "cHG_genome_$hg_num.fa";
#			print "cHG_genome_$hg_num.fa\n";
			open(OUT, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/RMS/$file_name") or die "Could not open $file_name, $!";	#Create output file uniquely numbered by the cluster number
			foreach $b (@HGs)	#cycle through the different ORFs attached to the given cluster
			{
#				print "b\t$b\n";
				my @breakHG = split(/\-\-/,$b);
				my $name_1 = "$breakHG[1]"; #$b is ORF, so feed into %key returns the genome this ORF is part of
				my $name = "./Prot_orfs/$name_1.faa";	#Open the genome file for this ORF
#				print "name_1\t$name_1\n";
#				print "name\t$name\n";
				open(IN, "< $name") or die "Could not open $name, $!";	#Open the genome file for this ORF
#	print "b [HGs] loop\t\t\t$b\t$keys{$b}\n";
				my $t = "F";	#Flag to control printing to output
				my $seq = ();	# The fasta header and sequence to be printed				
				while(defined(my $hg_line = <IN>)) #Read through lines of the genome file
				{
					chomp($hg_line);
					if ($hg_line=~/^>/)	#If new fasta header line is reached
					{
#						print "$hg_line\n";
						my @header_1 = split(/\s/,$hg_line);
						$header_1[0] =~ s/>//;	
						if ($header_1[0] eq $breakHG[0])
						{
							$t = "T";
							my $HG_id = ();
							my $arcog = ();
							my $name_rmscomp = "./Prot_orfs/arCOGs_analyzed/CompRMS/$name_1.RMScomp";	
							open (IN_RMS, "< $name_rmscomp") or die "Could not open $name, $!";	#open the RMScomp file matching the current genome
							while(defined(my $rms_line = <IN_RMS>)) #Read through lines of the .RMScomp file
							{
								chomp($rms_line);
#								print "$name_rmscomp\t\t$rms_line\n";
								my @orf_to_HG = split(/\t/,$rms_line);
								if ($orf_to_HG[0] eq $breakHG[0])
								{
									$HG_id = "$orf_to_HG[1]\t$orf_to_HG[-2]\t$orf_to_HG[-1]";
									$arcog = &Add_arCOG($breakHG[0],$breakHG[1]);	#Dig into .arCOG file to retrieve the arCOG number to improve usefullness of result
									push  @rebase_HGs, $orf_to_HG[1];
									last;
								}
							}
							close(IN_RMS);
							print OUT ">$breakHG[1]\t$arcog\t$HG_id\n";
						}
						else
						{
							$t = "F";
						}
					}	#end if ^> loop
					elsif ($t eq "T")
					{
						print OUT "$hg_line\n";
					}
				}	#end hg_line loop
				close(IN);
			} #end $b (@HGs) loop
			close(OUT);
			my $bad = "F";
			foreach my $screen_hg (@rebase_HGs)
			{
#				print "$screen_hg\n";
				my $banished = &Check_Purged_HGs($screen_hg);
				if ($banished eq "T")
				{
					$bad = "T";
				}
			}
			if ($bad eq "T")
			{
#				print "$file_name\n";
				system("mv ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/RMS/$file_name ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_Genome_HGs/Banished/$file_name");
			}
		} # end foreach $a (keys(Consolidated_hash)) loop
	} # end Genome_components.components
} # end sub




sub Consolidate_REBASE_HGs
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_REBASE_HGs");
	
	while(defined(my $file=glob("Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/REBASE_Componenets.components")))
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(COMP_LIST, "< ./Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/$filn_2[0].components");
	
		my %Consolidated_hash = ();
		while(defined(my $comp_line = <COMP_LIST>))
		{
			chomp($comp_line);
			my @line_comp = split(/\t/,$comp_line);
			if ($line_comp[0] =~ "arCOG*")
			{}
			elsif (exists $Consolidated_hash{$line_comp[1]})
			{
				$Consolidated_hash{$line_comp[1]} .= "\t$line_comp[0]";
#				print "$Consolidated_hash{$line_comp[1]}\n";
			}
			else
			{		
				$Consolidated_hash{$line_comp[1]} = "$line_comp[0]";
#				print "$Consolidated_hash{$line_comp[1]}\n";
			}
		}
		close(COMP_LIST);
		
		foreach my $a (keys(%Consolidated_hash))
		{
#			print "$a\t\t$Consolidated_hash{$a}\n";
			my @HGs = split(/\t/, $Consolidated_hash{$a});
			my $hg_num = sprintf("%03d", $a);
			my $file_name = "cHG_REBASE_$hg_num.fa";
			open(OUT, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Consolidated_REBASE_HGs/$file_name");
			foreach $b (@HGs)
			{
				my @HG_ID = split(/\_HG/, $b);
				open(IN, "< ./All_HGs/$HG_ID[0]/$b") or die "Could not open $b, $!";
				while(defined(my $hg_line = <IN>)) 
				{
					chomp($hg_line);
					print OUT "$hg_line\n";
				}
				close(IN);
			}
			close(OUT);
		}
	}
}

sub Collapse_Results
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Collapsed_HGs");

	my %Global_arCOG_collapse = ();

	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/*.RMScomp")))
	{
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		my %Collapse = ();
		my %RMS_comp = ();
		my %Global_arCOG_collapse = ();
		open(COLLAPSE, "> Prot_orfs/arCOGs_analyzed/CompRMS/Collapsed_HGs/$filn_2[0].collapse");
		open(RMScomp, "< ./Prot_orfs/arCOGs_analyzed/CompRMS/$filn_2[0].RMScomp");
		
		while(defined(my $rms_line = <RMScomp>))
		{
			chomp($rms_line);
			my @rms_split = split(/\t/,$rms_line);
			if (exists $Collapse{$rms_split[4]})
			{
				$Collapse{$rms_split[4]} .= "\t\t$rms_split[0]\t$rms_split[1]\t$rms_split[2]\t$rms_split[3]";
			}
			else
			{
				$Collapse{$rms_split[4]} = "$rms_split[5]\t$rms_split[6]\t$rms_split[6]\t$rms_split[7]\t\t$rms_split[0]\t$rms_split[1]\t$rms_split[2]\t$rms_split[3]";
			}
			
			if (exists $Global_arCOG_collapse{$rms_split[4]})
			{
				$Global_arCOG_collapse{$rms_split[4]} .= "\t$rms_split[0]";
#				print "Does exist:\t$rms_split[4]\n";
			}
			else
			{
				$Global_arCOG_collapse{$rms_split[4]} = "$rms_split[0]";
#				print "Does NOT exist:\t$rms_split[4]\n";
			}
			
		}
		
		foreach my $a (keys(%Collapse))
		{
			print COLLAPSE "$a\t$Collapse{$a}\n";
		}
		close(COLLAPSE);
	}
	
#	print "%Global_arCOG_collapse\n";
	open(GLOBAL_COLLAPSE, "> Prot_orfs/arCOGs_analyzed/Global_arCOG_Collapse_Key.key");
	foreach my $b (keys(%Global_arCOG_collapse))
	{
		print GLOBAL_COLLAPSE "$b\t$Global_arCOG_collapse{$b}\n";
#		print "Global arCOG collapse!\n";
	}
	close(GLOBAL_COLLAPSE);
}

sub Make_Interaction_Table_Genome	#Create files relating ORFs to arCOGs		Use R connection to create edgelist file
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable");
	
	open(TABLE, "> Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/InteractionTable_Genome.txt");
#	print TABLE "A\tB\tC\n";
#	print TABLE "A\tB\n";
	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/*.RMScomp")))
	{
		
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(IN, "< $file");		
		while(defined(my $line = <IN>))
		{
			my @line_comp = split(/\t/,$line);
#			print TABLE "$line_comp[1]\t$line_comp[4]\t$line_comp[3]\n";
			print TABLE "$line_comp[0]--$filn_2[0]\t$line_comp[4]\n";
		}
	}
	system("Rscript InteractionTable_Genome.R");
}


sub Make_Interaction_Table_REBASE	#Create files relating HGs to arCOGs		Use R connection to create edgelist file
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable");
	
	open(TABLE, "> Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/InteractionTable_REBASE.txt");
#	print TABLE "A\tB\tC\n";
#	print TABLE "A\tB\n";
	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/CompRMS/*.RMScomp")))
	{
		
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(IN, "< $file");		
		while(defined(my $line = <IN>))
		{
			my @line_comp = split(/\t/,$line);
#			print TABLE "$line_comp[1]\t$line_comp[4]\t$line_comp[3]\n";
			print TABLE "$line_comp[1]\t$line_comp[4]\n";
		}
	}
	system("Rscript InteractionTable_REBASE.R");
}

sub Compare_to_RMS	#Relate ORFs, HGs, and arCOGs together. Create Genome_to_fig.key -> relates ORF IDs to genome names. Requires: ./RMS_HGs_Filtered_1e-10 which includes .filtered results containing relation of genome's ORFs to HGs
{
	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS");
#	system("mkdir Prot_orfs/arCOGs_analyzed/CompRMS/Genome_to_fig_key.key");
	open(KEY, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/Genome_to_fig.key");
	
	while(defined(my $file = glob("./Prot_orfs/arCOGs_analyzed/*.arcog")))
	{
		
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		my %RMS = ();
		my %arCOG = ();
		open(ARCOG, "< $file");
		open(RMS_FILTER, "< ./RMS_HGs_Filtered_Translated/$filn_2[0].filtered");
		open(COMP, "> ./Prot_orfs/arCOGs_analyzed/CompRMS/$filn_2[0].RMScomp");
		
		while(defined(my $rms_line = <RMS_FILTER>))
		{
			chomp($rms_line);
			my @rms_split = split(/\t/,$rms_line);
#			print "$rms_split[0]\t@rms_split\n";
			$RMS{$rms_split[0]} = "$rms_split[1]\t$rms_split[2]\t$rms_split[3]";
#			print "@rms_split\n";
#			print "$RMS{$rms_split[0]}\n";
		}
		close(RMS_FILTER);
		while(defined(my $line = <ARCOG>))
		{
			chomp($line);
			my @in_line = (split/\t/,$line);
#			print "$in_line[0]\t@in_line\n";
			$arCOG{$in_line[0]} = "$in_line[1]\t$in_line[2]\t$in_line[3]\t$in_line[4]\t$in_line[5]";
		}
		close(ARCOG);
		foreach $a (keys(%RMS))
		{
			foreach $b (keys(%arCOG))
			{
#				print "$a\t\t$b\n";
				if ($a eq $b)
				{
#					print "$a\t\t$b\n";
#					print "$RMS{$a}\t$arCOG{$b}\n";
					my $safe_to_print = "T";
					foreach my $remove (@Banish)
					{
						my @rms_array = split(/\t/,$RMS{$a});
						if ($rms_array[0] eq $remove)
						{
							$safe_to_print = "F";
#							print "MATCH!\t$filn_2[0]\t$rms_array[0]\t\t$remove\n";
						}
					}
					if ($safe_to_print =~ "T")
					{
						print COMP "$a\t$RMS{$a}\t$arCOG{$b}\n";
						print KEY "$a\-\-$filn_2[0]\t$filn_2[0]\n";
					}
				}
			}
		}	
		close(COMP);
	}
	close(KEY);
}


sub Sort_and_Extract	#Filter through .bla results in ./Prot_orfs/analyzed	Build folder arCOGs_analyzed - relate arCOG info in ar14.arCOG.csv & ar14.arCOGdef.tab to produce .arcog file relating ORFs to arCOG groups
{
	my %BestHits = ();
	system("mkdir Prot_orfs/arCOGs_analyzed");
#	system("mkdir ./Prot_orfs/BLAST_results");
#	system("cp Prot_orfs/*.bla ./Prot_orfs/BLAST_results");
	open(arCOG, "< /Users/Fullmer/arCOG/ar14.arCOG.csv");
	open(arCOGdef, "< /Users/Fullmer/arCOG/ar14.arCOGdef.tab");
#	open(ZUG, "> ./Prot_orfs/arCOGs/lol.out");
#	print ZUG "lol!\n";
#	close(ZUG);
#	open my $lol, "> ./Prot_orfs/lol.out";
#	print $lol "lol!\n";
#	close $lol;

	my %arCOG_relates = ();
	while(defined(my $csv_line = <arCOG>))
	{
#		print "csv_line\t\t$csv_line\n";
		chomp($csv_line);
		my @arCOG_line = (split/\,/,$csv_line);
		$arCOG_relates{$arCOG_line[0]} = "$arCOG_line[6]\t$arCOG_line[7]";	
	}
	
	my %arCOG_tab = ();
	while(defined(my $tab_line = <arCOGdef>))
	{
		chomp($tab_line);
		my @arCOG_defline = (split/\t/,$tab_line);
#		print "$arCOG_defline[0]\n";
		$arCOG_tab{$arCOG_defline[0]} = $tab_line;
#		print "$arCOG_tab{$arCOG_defline[0]}\n";	
	}

	while(defined(my $file = glob ("./Prot_orfs/BLAST_results/*.bla")))
	{
		my $arCOG_info = "";
		my @filn_1 = (split/\//,$file);
		my @filn_2 = (split/\./,$filn_1[-1]);
		open(IN, "< $file");
		print "$file\n";
		my %BestHits = ();
		while(defined(my $line = <IN>))
		{
			chomp($line);
			my @in_line = (split/\t/,$line);
			my @hit = (split/\|/,$in_line[1]);	# The NCBI header that includes the GI at position 1.
#			my $score = $in_line[-1];
			if ($in_line[-2] < $threshold)
			{
				if (exists $BestHits{$in_line[0]})
				{
					my @orf_info = (split/\t/,$BestHits{$in_line[0]});
					if ($in_line[-1] > $orf_info[2])
					{
						$BestHits{$in_line[0]} = "$in_line[0]\t$hit[1]\t$in_line[-1]\t$in_line[-2]";
					}
				}
				else
				{
					$BestHits{$in_line[0]} = "$in_line[0]\t$hit[1]\t$in_line[-1]\t$in_line[-2]";
				}
			}
		}
		close(IN);
		my %Relation_hash = ();
		print "$filn_2[0]\n";
		
		foreach my $relates (keys(%arCOG_relates)) # csv info
		{
#			print "$relates\t";
			foreach my $a (keys(%BestHits))
			{
#				print "$relates\t$a\t";
				my @zug = split(/\t/,$BestHits{$a});
				if ($zug[1] eq $relates)
				{
					foreach my $b (keys(%arCOG_tab))
					{
						my @relates_split = split(/\t/,$arCOG_relates{$relates});
#						print "$b\t$arCOG_relates{$relates}\n";
						if ($b eq $relates_split[0])
						{
#							print "$b\t$arCOG_relates{$relates}\n";
							my @tabs = split(/\t/,$arCOG_tab{$b});
							my $composite = "$zug[0]\t$tabs[0]\t$tabs[1]\t$relates_split[1]\t$tabs[2]\t$tabs[3]\t$tabs[4]";
							$arCOG_info .= "$composite\n";
						}
					}
				}
			}
		}	
		open(OUT, "> ./Prot_orfs/arCOGs_analyzed/$filn_2[0].arcog");
#		print "$arCOG_info\n";
		print OUT "$arCOG_info\n";
		close(OUT);
	}
#	close(ZUG);
}

sub Blast_genomes	#Take genomes in ./Prot_orfs/ and search against arCOG db
{
	while(defined(my $file = glob ("./Prot_orfs/*.faa")))
	{
		my @filn = split(/\//,$file);
#		system("mkdir Prot_orfs/BLAST_results");
		system("mkdir Prot_orfs/BLAST_results");
		system("/Users/Fullmer/blast-2.2.26/bin/blastall -p blastp -i $file -d /Users/Fullmer/arCOG/ar14.fa  -e $threshold -m 8 -o ./Prot_orfs/BLAST_results/$filn[-1].bla");		
	}
}

sub Make_db	#Prep arCOG database for BLASTing against
{
	system("/Users/Fullmer/blast-2.2.26/bin/formatdb -i ar14.fa -p T -o T");
}




