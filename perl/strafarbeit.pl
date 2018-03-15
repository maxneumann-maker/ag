# Addition von 1..100 (ohne Gauﬂ)

use strict;

my $zaehler;
my $summe;


while ($zaehler < 100) {
   $zaehler = $zaehler + 1;
   $summe = $summe + $zaehler;
   print "Zaehler ist $zaehler und Summe ist $summe.\n"
   }