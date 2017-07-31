package DBConnect;
use strict;
use warnings FATAL => 'all';
use DBI;


# Datenbankverbindung aufbauen
   # Mögliche user: horst, demo

sub connect {
   my ($self) = @_;
   
   my $driver   = "Pg";
   my $database = "demo";
   my $dsn      = "DBI:$driver:dbname = $database ; host = 127.0.0.1 ; port = 5432";
   my $userid   = "demo";
   my $password = "demo";
   my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
   
   # print 'Opened db successfully'."\n";

   return 1;
}

# Prepares the query and sends it to the db
sub execute {
   my ($self) = @_;
   
}

# Brings up all records of a table. Expects tablename.
sub showall {
   my ($self) = @_;

}

# Adds a record to a table. Expects record-object.
sub insert_record {
   my ($self) = @_;

}

# Changes a record in table. Expects record-object.
sub update_record {
   my ($self) = @_;
   
}

# Removes a record from a table. Expects record-object
sub delete_record {
   my ($self) = @_;
   
}

1;