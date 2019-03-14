#!/usr/bin/perl 

system("mkdir Blast_Outs");
while(defined($db=glob("./LongestORF/*single"))) #formatdb cycle
{
	system("makeblastdb -in $db -dbtype 'prot'");
}


while(defined($fafile=glob("./LongestORF/*.HGsingle"))) #Blast 
{
	@accession_num_1=(split/\//,$fafile);
	@accession_num=(split/\./,$accession_num_1[-1]);
	while(defined($database=glob("./LongestORF/*.RMSsingle"))) 
	{
		#print "fafile = $fafile\tdatabase = $database\n";
		@dbparts_1=split(/\//,$database);
		@dbparts=split(/\./,$dbparts[-1]);
		system("blastp -query $fafile -db $database -evalue 1E-20 -outfmt 6 -out ./Blast_Outs/$accession_num[0].$dbparts[0].bla");
	}
}