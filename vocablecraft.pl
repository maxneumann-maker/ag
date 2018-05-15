#!/usr/bin/perl

#* Vocablecraft.pl - ein einfacher Vokabeltrainer mit Perl/Tk
#
# Als erstes größeres Projekt, das einen wirklichen praktischen Nutzen im Alltagsleben
# eines Schülers hat, wollen wir einen Vokabeltrainer programmieren. Das Programm soll
# alle wesentlichen Funktionen bieten, die man von ihm erwarten kann: die Möglichkeit,
# Vokabeln einzugeben, als Liste anzeigen zu lassen, auszudrucken, abzuspeichern und
# in beide Richtungen zu üben. Die Benutzung soll durch eine grafische Oberfläche
# zugänglich gemacht werden.
#
# Zunächst regeln wir im Dateikopf...

#** einige organisatorische Dinge:
#
# Wir laden benötigte Pakete:

use strict;
use utf8;
use open ':encoding(utf8)';
use Tk;
use Tk::DialogBox;
use Tk::Pane;
#use Tk::BrowseEntry;


#** Jetzt kanns losgehen: das Startfenster:

my $mainwindow = MainWindow -> new( -title => "Vocablecraft 1.0" );
$mainwindow -> geometry ($mainwindow -> screenwidth . "x" . $mainwindow -> screenheight . "+0+0");

#** Die Menüleiste: 

my $menueleiste = $mainwindow -> Frame ( -relief => "raised", -borderwidth => 2 ) -> pack();

$menueleiste -> Menubutton(
    -text    => "Datei",
    -justify => 'left',
    -tearoff => 0,
    -relief  => 'groove',
    -menuitems => [
	 [ 'command' => "Laden",         -command => \&laden ],
	 [ 'command' => "Speichern",     -command => \&speichern ],
	 [ 'command' => "Liste drucken", -command => \&drucken,    -state => "disabled" ],
	 [ 'command' => "Beenden",       -command => \&beenden ]
    ]
    )->grid(

    $menueleiste -> Menubutton(
        -text      => "Vokabeln",
        -justify   => 'left',
        -tearoff   => 0,
        -relief    => 'groove',
        -menuitems => [
	     [ 'command' => "Neue Vokabel eingeben", -command => \&eingeben ],
	     [ 'command' => "Vokabel löschen",       -command => \&loeschen ]
	]
	),

    $menueleiste -> Menubutton(
        -text      => "Test",
        -justify   => 'left',
        -tearoff   => 0,
        -relief    => 'groove',
        -menuitems => [
	     [ 'command' => "Test Bedeutungen", -command => \&test_bedeutungen ],
	     [ 'command' => "Test Vokabeln",    -command => \&test_vokabeln ]
	]
	),
    );

#** Vorbereitungen

my $dateiname;
my @vokabel;
my @bedeutung;

# Wir wollen die Listen bei 1 beginnen, nicht bei 0, deshalb definieren wir eine Dummyvokabel als 0:
$vokabel[0] = "-";
$bedeutung[0] = "-";

my $arbeitsbereich;
&arbeitsbereich_aufbauen;


#** MainLoop
# Hier wartet das Programm auf Anweisungen aus den Menüs:

MainLoop;

#** Unterprogramme:

#*** Arbeitsbereich aufbauen
sub arbeitsbereich_aufbauen {
    $arbeitsbereich -> destroy() if Tk::Exists($arbeitsbereich);
    
    $arbeitsbereich = $mainwindow -> Scrolled( "Pane", 
					       -scrollbars => "soe", 
	#				       -sticky => "nesw",
	) -> pack (-fill => "both",
		   -expand => 1);
    
    $arbeitsbereich -> Label (-text => "Nr.") -> grid (
	$arbeitsbereich -> Label (-text => "Vokabeln"),
	$arbeitsbereich -> Label (-text => "Bedeutung"),
	);
    
    for (my $i = 1; $i < @vokabel; $i++) {
	$arbeitsbereich -> Label (-text => "$i") -> grid (
	    $arbeitsbereich -> Entry (-textvariable => \$vokabel[$i]),
	    $arbeitsbereich -> Entry (-textvariable => \$bedeutung[$i]),
	    )
    }
}

#*** Datei-Menü:
#**** laden
sub laden {    
    $dateiname = $mainwindow -> getOpenFile ( -title      => "Vokabeln laden" );

    open DATEI, "<$dateiname" ;
    my $anzahl = <DATEI>;

    for (my $i = 1; $i < $anzahl; $i++) {
	chomp( $vokabel[$i]   = <DATEI> );
	chomp( $bedeutung[$i] = <DATEI> );
    }

    &arbeitsbereich_aufbauen;
};


#**** speichern
sub speichern {
    my $s = $mainwindow -> DialogBox(
        -title   => "Vokabelliste speichern",
        -buttons => ["OK"]
    );

    $s -> Label (-text => "Dateiname:") -> grid(
	$s -> Entry (-textvariable => \$dateiname),
	);

    $s -> Show();

    open DATEI, ">$dateiname" ;
    my $anzahl = @vokabel;
    print DATEI "$anzahl\n";

    for (my $i = 1; $i < @vokabel; $i++) {
	print DATEI $vokabel[$i] . "\n";
	print DATEI $bedeutung[$i] . "\n";
    }
};
#**** drucken
#**** beenden
sub beenden {
    exit;
}

#*** Vokabel-Menü:
#**** eingeben
sub eingeben {
    my $neue_vokabel;
    my $neue_bedeutung;
    
    my $e = $mainwindow -> DialogBox(
        -title   => "Neue Vokabel eingeben",
        -buttons => ["OK"]
    );

    $e -> Label (-text => "Vokabel:") -> grid(
	$e -> Entry (-textvariable => \$neue_vokabel),
	);

    $e -> Label (-text => "Bedeutung:") -> grid(
	$e -> Entry (-textvariable => \$neue_bedeutung),
	);

    $e -> Show();

    push @vokabel, $neue_vokabel;
    push @bedeutung, $neue_bedeutung;

    &arbeitsbereich_aufbauen;
}
#**** loeschen
sub loeschen {
    my $z;
    my $l = $mainwindow -> DialogBox(
        -title   => "Einzelne Vokabel löschen",
        -buttons => ["OK", "Abbrechen"],
    );

    $l -> Label (-text => "Welche Vokabel soll aus der Liste gelöscht werden?") -> grid(
	$l -> Entry (-textvariable => \$z),
	);

    my $button = $l -> Show();

    if ($button eq "OK") {
	splice (@vokabel, $z, 1);
	splice (@bedeutung, $z, 1);
    }

    &arbeitsbereich_aufbauen;
}
#*** Test-Menü:
#**** Test Bedeutungen
sub test_bedeutungen {
    $arbeitsbereich -> destroy() if Tk::Exists($arbeitsbereich);
    
    my @v = @vokabel;
    my @b = @bedeutung;
    my $richtige;
    my $falsche;

  Start:
    my $z = int( rand(@v - 1) ) + 1;
    my $antwort = "";

    my $f = $mainwindow -> DialogBox(
        -title   => "Test",
        -buttons => ["OK"]
	);
    $f -> Label (-text => "Was bedeutet $v[$z]?") -> grid(
	$f -> Entry (-textvariable => \$antwort),
	);
    $f -> Show();
    chomp($antwort);

    my $a = $mainwindow -> DialogBox(
	-title   => "Test",
	-buttons => ["OK"]
	);

    if ($antwort eq $b[$z]) {
	$a -> Label (-text => "Genau richtig, $v[$z] bedeutet $b[$z].") -> grid();
	$a -> Show();

	$richtige++;
	splice (@v, $z, 1);
	splice (@b, $z, 1);

	if (@v == 1) {
	    goto Ende;
	}
	else {
	    goto Start;
	}
    }
    else {
	$a -> Label (-text => "Falsch, $v[$z] bedeutet $b[$z].") -> grid();
	$a -> Show();

	$falsche++;
	goto Start;
    }

  Ende:
    my $s = $mainwindow -> DialogBox(
	-title   => "Test",
	-buttons => ["OK"]
	);
    $s -> Label (-text => "Prima, du bist fertig! Alle Vokabeln waren gekonnt!\n Richtige Versuche: $richtige \n Falsche Versuche: $falsche") -> grid();
    $s -> Show();

    &arbeitsbereich_aufbauen;
}
#**** Test Vokabeln
sub test_vokabeln {
    $arbeitsbereich -> destroy() if Tk::Exists($arbeitsbereich);
    
    my @v = @vokabel;
    my @b = @bedeutung;
    my $richtige;
    my $falsche;

  Start:
    my $z = int( rand(@v - 1) ) + 1;
    my $antwort = "";

    my $f = $mainwindow -> DialogBox(
        -title   => "Test",
        -buttons => ["OK"]
	);
    $f -> Label (-text => "Was bedeutet $b[$z]?") -> grid(
	$f -> Entry (-textvariable => \$antwort),
	);
    $f -> Show();
    chomp($antwort);

    my $a = $mainwindow -> DialogBox(
	-title   => "Test",
	-buttons => ["OK"]
	);

    if ($antwort eq $v[$z]) {
	$a -> Label (-text => "Genau richtig, $v[$z] bedeutet $b[$z].") -> grid();
	$a -> Show();

	$richtige++;
	splice (@v, $z, 1);
	splice (@b, $z, 1);

	if (@v == 1) {
	    goto Ende;
	}
	else {
	    goto Start;
	}
    }
    else {
	$a -> Label (-text => "Falsch, $v[$z] bedeutet $b[$z].") -> grid();
	$a -> Show();

	$falsche++;
	goto Start;
    }

  Ende:
    my $s = $mainwindow -> DialogBox(
	-title   => "Test",
	-buttons => ["OK"]
	);
    $s -> Label (-text => "Prima, du bist fertig! Alle Vokabeln waren gekonnt!\n Richtige Versuche: $richtige \n Falsche Versuche: $falsche") -> grid();
    $s -> Show();

    &arbeitsbereich_aufbauen;
}

#** (c)
#
# Thomas Hilarius Meyer - thomas.hilarius.meyer@gmail.com
# Gemeinschaftsschule Gersheim
# Schulstraße 32
# 66453 Gersheim



