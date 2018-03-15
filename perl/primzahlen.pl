use strict;

my $zahl = 1;

while ($zahl < 100000000) {
	$zahl = $zahl + 1;
	
	my $zaehler = 2;
	my $istprimzahl = "ja";

	while ($zaehler < ($zahl / 2) + 1) {
		my $rest = $zahl % $zaehler;
		if ($rest == 0) {
			$istprimzahl = "nein";
			#last;
		}
		$zaehler = $zaehler +1;
	}


	if ($istprimzahl eq "ja") {
		print "$zahl ist eine Primzahl!\n"
	}
}
