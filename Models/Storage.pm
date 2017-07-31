package Storage;
use strict;
use warnings FATAL => 'all';



sub new {
   my ($class) = shift @_;
   my ($name, $capacity, $PID, $CreationTime, $UpdateTime, $Deleted) = @_;

   return bless {
        "name"       => $name,
        "capacity"   => $capacity,
        "PID"        => $PID,
        "CreationTime"=> $CreationTime,
        "UpdateTime" => $UpdateTime,
        "Deleted"   => $Deleted,
    }, $class;

}


sub get_name {
   return $_[0]->{name};
}
sub set_name {
   my ($self , $new_value) = @_;
   $$self{name} = $new_value;
   return $self;
}


sub get_capacity {
   return $_[0]->{capacity};
}
sub set_capacity {
   my ($self , $new_value) = @_;
   $$self{capacity} = $new_value;
   return $self;
}


sub get_PID {
   return $_[0]->{PID};
}
sub set_PID {
   my ($self , $new_value) = @_;
   $$self{PID} = $new_value;
   return $self;
}


sub get_CreationTime {
   return $_[0]->{CreationTime};
}


sub get_UpdateTime {
   return $_[0]->{UpdateTime};
}


sub get_Deleted {
   return $_[0]->{Deleted};
}
sub set_Deleted {
   my ($self , $new_value) = @_;
   $$self{Deleted} = $new_value;
   return $self;
}
1;