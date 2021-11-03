$dataDirectory = "/Users/jenniferbonetti/Desktop/dart101920_all/";
$lsFiles = `ls -1 $dataDirectory`;
@files = split(/\n/, $lsFiles);
$minMass = 66;
$maxMass = 169;
$maxMass2 = 600;
$inc = 0.025;

print "Card,Voltage,Label";
for($i=$minMass; $i<($maxMass+1+$inc);$i+=$inc){
	printf ",<%.3f%s",$i;
}
print "\n";
foreach $file (@files){
	chomp($file);
	$sample = $file;
	$sample =~ s/\.[^.]+$//;
	@blah = split(/_/,$sample);
	@blah2 = split(/-/,$sample);
	$Label = substr($blah[1],0,1);
	#$Volume = substr($blah[2],0,1);
	$Voltage = substr($blah2[1],0,2);
	print "$blah[0],$Voltage,$Label";
	$fname = $dataDirectory.$file;
	open($f,'<',$fname) or die "Could not open file $fname: $! \n";
	$counter = 0;

	$currentPlace = $minMass;

	close($f);
	open($f,'<',$dataDirectory.$file) or die "Could not open file $file \n";
	while(<$f>){
			chomp;
			@data = split();

		while($currentPlace < $data[0] && $currentPlace < $maxMass+1+$inc){
				print ",0";
				$currentPlace+=$inc;
		}
		if($data[0]<($currentPlace+$inc) && $data[0] > ($currentPlace-$inc) && $data[0] <= $maxMass+1) {
				printf(",$data[1]");				
				$currentPlace+=$inc;
		}	
		if($currentPlace > $maxMass+1 && $currentPlace < $maxMass2){
			$currentPlace+=$inc;
			$counter++;
		}
	$counter++;
	}
	close($f);
	print "\n";
}
