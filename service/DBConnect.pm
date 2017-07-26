package DBConnect;
use strict;
use warnings FATAL => 'all';
use DBI;

# Datenbankverbindung aufbauen
   # Mögliche user: horst, demo

my $driver   = "Pg";
my $database = "warmup";
my $dsn      = "DBI:$driver:dbname = $database ; host = 127.0.0.1 ; port = 5432";
my $userid   = "demo";
my $password = "demo";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;

print 'Opened db successfully'."\n";





1;