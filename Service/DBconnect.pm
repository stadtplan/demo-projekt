package DBconnect;
use strict;
use warnings FATAL => 'all';
use DBI;


# Datenbankverbindung aufbauen
   # Mögliche user: horst, demo

my $singleton;

sub new {
        my $class = shift;
        $singleton ||= bless {}, $class;
    }

sub connect {
   my $self = shift;
   if (exists $self->{dbh}) {
       $self->{dbh};
   } else {
      my $driver   = "Pg";
      my $database = "demo";
      my $connection = "DBI:$driver:dbname = $database ; host = 127.0.0.1 ; port = 5432";
      my $userid   = "demo";
      my $password = "demo";
      $self->{dbh} =  DBI->connect($connection,$userid,$password);
   }
}

1;