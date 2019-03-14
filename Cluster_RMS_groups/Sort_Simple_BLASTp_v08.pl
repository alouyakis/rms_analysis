#!/usr/bin/perl 

$e_val = 1e-40;
$ratio = 0.75;

while(defined($query_in=glob("*.txt"))) #Pull in blast queries cycle 
{
	open(IN_QUERY, "< $query_in") or die "cannot open $query_in:$!";
#	open(OUT_RECOG, "> $query_in.recogseqs") or die "cannot open $query_in.recogseqs:$!";
	%query_names = ();
	%recog_hash = ();
	while(defined($query_line=<IN_QUERY>))
	{
		if ($query_line=~/^>/)
		{
			chomp($query_line);
			$query_line =~ s/\>//,$query_line;
			@header = split(/\s+/,$query_line);
			if ($header[-1] eq "aa")
			{
				$query_names{$header[0]} = $header[-2];
			}
			else
			{
				$query_names{$header[0]} = $header[-3];
			}
			if ($header[1] =~ /[0-9]+/)
			{
				$recog_hash{$header[0]} = "N/A";
#				print OUT_RECOG "$header[0]\tN/A\n"
			}
			else
			{
				$recog_hash{$header[0]} = $header[1];
#				print OUT_RECOG "$header[0]\t$header[1]\n"
			}
		}
	}
	close(IN_QUERY);
#	close(OUT_RECOG);
	open(OUT, "> $query_in.summary") or die "cannot open $file.summary:$!";
	print OUT "e-value = $e_val %coverage = $ratio\t";
	
	@queries = keys(%query_names);
	foreach $h (@queries)
	{
		print OUT "$recog_hash{$h}\t";
	}
	print OUT "\n\t";
	foreach $h (@queries)
	{
		print OUT "$h\t";
	}
	print OUT "\n";
	
	while(defined($bla_in=glob("*.bla"))) #Pull in blast queries cycle 
	{
		open(IN_BLA, "< $bla_in") or die "cannot open $bla_in:$!";
		@db_name = split(/\./,$bla_in);
		$db = $db_name[1];
		open(OUT_BLA, "> $db.funcs") or die "cannot open $db.funcs:$!";
		%found = ();
		print OUT "$db\t";
		
		while(defined($bla_line=<IN_BLA>))
		{
			@line = split(/\t/,$bla_line);
			$length_ratio = $line[3] / $query_names{$line[0]};
			
			if (($line[10] <= $e_val) && ($length_ratio >= $ratio))
			{
				if (exists ($found{$line[0]}))
				{
	#				print "exists $line[0]\n";
				}
				else
				{
	#				print "Now exists $line[0]\n";
					$found{$line[0]} = 'y';
					
					open(SHEET, "< ./spreadsheets/$db.txt") or die "/spreadsheets/$db.txt:$!";
	#				print "Entered sheet $db.txt\n";
					while(defined($sheet_line = <SHEET>))
					{
						@s_line = split(/\t/,$sheet_line);
						if ($line[1] eq $s_line[1])
						{
							print OUT_BLA "$line[0]\t$s_line[1]\t$recog_hash{$line[0]}\t$s_line[7]\n";
							last;
						}	
					}
					close(SHEET)
				}
			}
		}	
		foreach $h (@queries)
		{
			if (exists ($found{$h}))
			{
				print OUT ".\t";
			}
			else
			{
				print OUT "X\t";
			}
		}
		print OUT "\n";
			
	}
	
}