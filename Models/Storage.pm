package Storage;
use strict;
use warnings FATAL => 'all';



sub new {
   my ($class) = shift @_;
   my ($name, $capacity, $id, $creationtime, $updatetime, $deleted) = @_;

   my $self = bless {
         "id"          => $id,
         "name"        => $name,
         "capacity"    => $capacity,
         "creationtime"=> $creationtime,
         "updatetime"  => $updatetime,
         "deleted"     => $deleted,
    }, $class;
   return $self;

}

sub get_ID {
   my $self = @_;
   return $self->{id};
}

sub set_ID {
   my ($self , $new_value) = @_;
   $self->{id} = $new_value;
   return $self;
}

sub get_name {
   my $self = @_;
   return $self->{name};
}

sub set_name {
   my ($self , $new_value) = @_;
   $self->{name} = $new_value;
   return $self;
}

sub get_capacity {
   my $self = @_;
   return $self->{capacity};
}
sub set_capacity {
   my ($self , $new_value) = @_;
   $self->{capacity} = $new_value;
   return $self;
}

sub get_creationtime {
   my $self = @_;
   return $self->{creationtime};
}

sub get_updatetime {
   my $self = @_;
   return $self->{updatetime};
}

sub get_deleted {
   my $self = @_;
   return $self->{deleted};
}

sub set_deleted {
   my ($self , $new_value) = @_;
   $self->{deleted} = $new_value;
   return $self;
}
1;