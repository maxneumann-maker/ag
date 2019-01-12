#! /usr/bin/perl


start:

system "clear";

print "\n";
print "               BBBBBB    M       M   III \n";
print "               B     B   MM     MM    I  \n";
print "               B     B   M M   M M    I  \n";
print "               BBBBBB    M  M M  M    I  \n";
print "               B     B   M   M   M    I  \n";
print "               B     B   M       M    I  \n";
print "               BBBBBB    M       M   III \n";
print "\n\n\n";
print " - Der BODY-MASS-INDEX-Berechner der GemS Gersheim - \n\n\n";

print "Schritt 1:\n";
print "Wie gross sind Sie (in cm) ? > ";

$groesse_cm = <STDIN>;

print "Schritt 2:\n";
print "Wie schwer sind Sie (in kg) ? > ";

$masse_kg = <STDIN>;

$groesse_m = $groesse_cm / 100 ;

# Division durch 0 vermeiden:
if ($groesse_m eq 0) {goto start}

# BMI-Formel:
$bmi = $masse_kg / ( $groesse_m * $groesse_m ) ;

# Runden auf zwei Nachkommastellen:
$bmi = ( int($bmi *100) ) / 100;

# Auswertung:
print "\n\n";
print "Ihr BMI ist $bmi , das heisst Sie haben ";

if    ($bmi < 16)   {print "starkes Untergewicht."}
elsif ($bmi < 17)   {print "mässiges Untergewicht."}
elsif ($bmi < 18.5) {print "leichtes Untergewicht."}
elsif ($bmi < 25)   {print "Normalgewicht."}
elsif ($bmi < 30)   {print "Übergewicht (Präadipositas)."}
elsif ($bmi < 35)   {print "Übergewicht (Adipositas Grad I)."}
elsif ($bmi < 40)   {print "Übergewicht (Adipositas Grad II)."}
else                {print "Übergewicht (Adipositas Grad III)."}

print "\n\n\n";
print "Neustart? >";

$scr = <STDIN>;

goto start;
