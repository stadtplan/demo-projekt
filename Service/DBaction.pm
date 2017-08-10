package DBaction;
use strict;
use warnings FATAL => 'all';
use DBI;
use Service::DBconnect;
use Models::Storage;
use Models::Server;


# Konstruktor

sub new {
   my ($class,$dbh,$tablename,$id) =  @_;
   my $self = bless {
         dbh       => $dbh,
         tablename => $tablename,
      } , $class;
   return $self;
}

# Prepares and executes the query and sends it to the db

sub execute {
   my ($self, $query) = @_;

   my $dbh = $self->{dbh};

   #Preparation of the query. sth steht für STringHandler
   my $sth = $dbh->prepare("$query") or die "Couldn't prepare statement: $DBI::errstr; stopped";

   #Execution of the prepared query
   $sth->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";

   if ($sth) {$self->{sth}=$sth;}

   if ($DBI::errstr) {return 0}
   else {return 1};

}


# Brings up all records of a table. Expects tablename.

sub show_all {
   my ($self) = shift @_;

   my $query = "SELECT * FROM ".$self->{tablename}." ORDER BY id ASC;";
   my $return = $self->execute($query);

#   if ($return==0||$return==1) {
#      print 'something';
#   }
#   else {

      # $sth probably contains a Hash to an Array of Arrayreferences
      # This is goining to be decomposed and put in an array of arrayreferences for further use

      my @rows = ();
      while ( my @fields = $self->{sth}->fetchrow_array() ) {
         push(@rows, \@fields);

      }
   return @rows;
#   }
}

# Fetch one record from the database and return it as the particular object

sub get_record_by_id {
   my ($self, $id) = @_;

   my $query = "SELECT * FROM ".$self->{tablename}." WHERE id=".$id.";";
   $self->execute($query);

   # the record is used to instanviate a Storage-Object. The first Character of the tablename is switched to uppercase
   my @fields = $self->{sth}->fetchrow_array();
   my $tablename = ucfirst($self->{tablename});
   my $obj_record = $tablename->new(@fields);

   return $obj_record;

}


# Adds a record to a table. Expects record-object.

sub insert_record {
   my ($self) = @_;

}


# Changes a record in table. Expects record-object.

sub update_record {
   my ($self) = @_;
   
}


# Sets the 'deleted'-Flag of a record to 'true'. Expects record-object

sub delete_record_by_id {
   my ($self,$id) = @_;

   my $query = "UPDATE ".$self->{tablename}." SET deleted = 't' WHERE id = ".$id.";";
   $self->execute($query);
   
}


1;