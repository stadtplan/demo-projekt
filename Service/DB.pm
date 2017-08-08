package DB;
use strict;
use warnings FATAL => 'all';
use DBI;


# Datenbankverbindung aufbauen
   # Mögliche user: horst, demo



sub new {
   my ($class) = @_;
   my $self = bless {
         driver => "Pg",
         database => "demo",
         host => "127.0.0.1",
         port => "5432",
         userid => "demo",
         password => "demo"
      } , $class;
   return $self;
}

#dsn => "DBI:$driver:dbname = $database ; host = 127.0.0.1 ; port = 5432"

sub connect {
   my ($self) = @_;

   my $driver   = $self->{driver};
   my $database = $self->{database};
   my $dsn      = "DBI:$driver:dbname = $database ; host = 127.0.0.1 ; port = 5432";
   my $userid   = $self->{userid};
   my $password = $self->{password};
   my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
   
   # print 'Opened db successfully'."\n";

   return 1;
}

# Prepares and executes the query and sends it to the db
sub execute {
   my ($self) = shift @_;
   my $query = shift @_;

   my $dbh = $self->connect();

   #Preparation of the query. sth steht für STringHandler
   my $sth = $dbh->prepare("$query") or die "Couldn't prepare statement: $DBI::errstr; stopped";

   #Execution of the prepared query
   $sth->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
}
if ($DBI::errstr) {return 0}
   else {return 1};


# Brings up all records of a table. Expects tablename.
sub show_all {
   my ($self) = shift @_;
   my $tablename = shift @_;

   my $query = "SELECT * FROM $tablename";
   my @data = $self->execute($query);

   return @data;
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