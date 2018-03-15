#!/usr/bin/perl

use strict;
use warnings;

use MIME::Lite;

my $smtpServer  = 'smtp.web.de';
my $smtpPort    = 587;
my $smtpUser    = ''; # <- Deine web.de-Adresse hier!
my $smtpPass    = ''; # <- Dein web.de-Passwort hier!

my $mailFrom    = ''; # <- Deine web.de-Adresse hier (evtl. mit Alias und <>)!
my $mailTo      = ''; # <- Deine Emfpänger-Adresse hier (evtl. mit Alias und <>)!
my $mailSubject = 'Gruesse von MIME::Lite';
my $mailType    = 'text/plain; charset="ISO-8859-15"'
my $mailBody    = "Hallo korkak,\n\nhier mein Mail-Text.\n\nGrüße\npayx";

my $msg = MIME::Lite->new(
    From        => $mailFrom
    , To        => $mailTo
    , Subject   => $mailSubject
    , Type      => $mailType
    , Data      => $mailBody
);	

# Daten ansehen:
# print "$smtpServer > $smtpPort > $smtpUser > $smtpPass";
# $msg->print_header;
# $msg->print;

$msg->send(
    smtp        => $smtpServer
    , Port      => $smtpPort
    , AuthUser  => $smtpUser
    , AuthPass  => $smtpPass
    , Timeout   => 90
    , Debug     => 1
);
