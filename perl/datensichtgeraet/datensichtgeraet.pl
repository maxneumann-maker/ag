#!/usr/bin/perl

use strict;

my $datei;
my %datei_gestartet;
my %pid;
my $ort;

while (1) {
    &configsuche;
    &dateisuche;

    sleep 3;
    print "gewartet \n";
};

sub configsuche {
};

sub dateisuche {
    foreach $ort ("links", "mitte", "rechts") {
        opendir dir, "$ort";
        my @files = readdir dir;
        closedir dir;

        foreach $datei (@files){
            if ($datei eq "." or
                    $datei eq "..") {next}
            if ($datei_gestartet{$ort} ne $datei) {
                # Eine neue Datei anzeigen, d.h. erstmal den Viewer löschen...
                $datei_gestartet{$ort} = $datei;

                if (not $pid{$ort} == 0) {
                    system ("kill $pid{$ort}");
                }

                my $application;
                if ($datei =~ /.pdf/)  {$application = "xpdf"}
                if ($datei =~ /.jpg/)  {$application = "okular"}
                if ($datei =~ /.gif/)  {$application = "okular"}
                if ($datei =~ /.png/)  {$application = "okular"}
                if ($datei =~ /.html/) {$application = "konqueror"}
                if ($datei =~ /.doc/)  {$application = "calligrawords"}
                if ($datei =~ /.docx/) {$application = "calligrawords"}

                open CMD, ">dsg_command_$ort";
                if ($ort eq "links") {
                    print CMD "$application -geometry 150x500+10+10 $ort/$datei & \n";
                }
                elsif ($ort eq "mitte") {
                    print CMD "$application -geometry 150x500+400+10 $ort/$datei & \n";
                }
                elsif ($ort eq "rechts") {
                    print CMD "$application -geometry 150x500+700+10 $ort/$datei & \n";
                }
                print CMD 'echo $! > dsg_pid_' . "$ort";
                close CMD;
                system ( "bash dsg_command_$ort");
                sleep 3;

                open PID, "<dsg_pid_$ort";
                $pid{$ort} = <PID>;
                close PID;
            }
        }
    }
};
