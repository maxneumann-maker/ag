use strict;

my @vokabel =   ("dog",  "cat",   "mouse");
my @bedeutung = ("Hund", "Katze", "Maus");

my $index = rand 3,;

my $richtige = 0;
my $falsche = 0;

print "Hallo beim supercoolen Vokabeltrainer! \n";

print "Vokabel:    " . $vokabel[$index] . "\n";
print "Bedeutung: >";

my $antwort = <STDIN>;
chomp $antwort;

if ($antwort eq $bedeutung[$index]) {
	print "Hurra! Das ist richtig! Weiter so! \n";
	$richtige = $richtige + 1;
}
else {
	print "Leider nicht. Es heisst $bedeutung[$index] \n";
	$falsche = $falsche + 1;
};

print "Du hattest $richtige richtige und $falsche falsche Antworten! Uebe fleissig weiter!";