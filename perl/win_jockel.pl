use Tk;                                        # Bibliothek für Fenster laden!

my $window = MainWindow -> new;                # neues Hauptfenster anlegen!

$window -> title ("Hallo-Programm mit Win");   # Fenstertitel festlegen

$window -> Label  (-text => "Hallo, Du Jockel! \n Wer bist Du?")
        -> pack;                                     # eine Beschriftung

my $jockel;
$window -> Entry  (-textvariable => \$jockel)
        -> pack;                                     # ein Eingabefeld
		
$window -> Button (-text => "Schluss!",
                   -command => \&stoppen)
		-> pack ;                                    # ein Button
				 
$window -> Button (-text => "Weiter!",
                   -command => \&schreiben)
		-> pack ;				 
MainLoop;

sub stoppen {                                    # Unterprogramme für die Buttons
	exit;
}
sub schreiben {
    print "Hallo $jockel \n";
}