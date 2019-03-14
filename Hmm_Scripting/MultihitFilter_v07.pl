#!/usr/bin/perl 

while(defined($funcs_in=glob("*.funcs"))) #Pull in blast queries cycle 
{
	print "file =\t$funcs_in\n";
	open(IN_FUNCS, "< $funcs_in") or die "cannot open $funcs_in:$!";
	open(OUT_FUNCS, "> $funcs_in.filter.txt") or die "cannot open $funcs_in.filter:$!";
	%orfs = ();
#	%rms = ();
	while(defined($funcs_line=<IN_FUNCS>))
	{
		chomp($funcs_line);
		#print "$funcs_line";
		@line = split(/\t/,$funcs_line);
		if (exists $orfs{$line[1]})
		{
#			print "found $line[1] in orfs{$line[1]}\n";
			@hash_vals = split(/\t/,$orfs{$line[1]});
#			print "hash_vals\t@hash_vals\n";
			$T_or_F = 0;
			foreach $r (@hash_vals)
			{
#				print "r =\t$r\n";
				if ($line[2] =~ /^$r$/)
				{
#					print "r\t$r in line[2]\t$line[2]\n";
					$T_or_F = 1;
				}
				else
				{
#					print "NOT FOUND\tr = $r\t\t$line[2]\n";
				}
			}
			if ($T_or_F < 1)
			{
#				print "NOT $r in $line[2]\n";
#				print "orfs{$line[1]} = $orfs{$line[1]}\n";
				$orfs{$line[1]} = "$orfs{$line[1]}\t$line[2]\t$line[0]";
#				print "orfs{$line[1]}\t=\t$orfs{$line[1]}\t$line[2]\t$line[0]";
#				print "orfs{$line[1]} = $orfs{$line[1]}\n";
			}
		}
		else
		{
			$orfs{$line[1]} = "$line[3]\t$line[2]\t$line[0]";
#			print "new hash orfs{$line[1]} created!\n content =\t$orfs{$line[1]}\n";
		}
	}
	close(IN_FUNCS);
	
	@orf_keys = keys(%orfs);
#	print "orf_keys =\t@orf_keys\n";
	foreach $zed (@orf_keys)
	{
		$entry = $orfs{$zed};
#		print "orfs{$zed} =\t$orfs{$zed}\n";
#		print "entry =\t$entry\n";
		@hash_contents = split(/\t/,$entry);
		$elems = scalar(@hash_contents);
#		print "\n\n$zed\n";
#		print "hash_contents =\t@hash_contents\tlength = $elems\n";
		$count = 0;
		
		print OUT_FUNCS "$zed\t";	
#		print "$zed\t";
		
		while($count < 3)
		{
			print OUT_FUNCS "$hash_contents[$count]\t";
#			print "$hash_contents[$count]\t";
			$count = $count + 1;
		}
#		print "\n\t\t";
		if ($count < $elems)
		{
			print OUT_FUNCS "\n\t\t";
		}
		$mini_count = 0;
		while($count < $elems)
		{
			print OUT_FUNCS "$hash_contents[$count]\t";
#			print "$hash_contents[$count]\t";
			$count = $count + 1;
			$mini_count = $mini_count + 1;
			if (($mini_count > 1) && ($count < $elems))
			{
#				print "\n\t\t";
				print OUT_FUNCS "\n\t\t";
				$mini_count = 0;
			}
		}
		print OUT_FUNCS "\n";
#		print "\n";
	}
	close(OUT_FUNCS);
}



