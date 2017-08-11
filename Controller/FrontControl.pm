package FrontControl;
use strict;
use warnings FATAL => 'all';
use HTML::Template;
use DBI;
use DDP;
use Service::DBconnect;
use Service::DBaction;
use Models::Storage;
use Models::Server;


# Konstruktor
sub new {
   my ($class, $cgi, $dbh) = @_;
   my $self = bless {
         cgi => $cgi,
         dbh => $dbh,
      } , $class;
   return $self;
}


sub handle_request {
   my ($self) = @_;

   my $cgi = $self->{cgi};

   my $path = $cgi->_name_and_path_from_env;
   my @knots = split '/', $path;
   if (@knots) { shift @knots;}

   my $method = join ('_', @knots);

   if ($method) {
      if ($self->can($method)) {

         $self->$method($knots[0]);

      } else {$self->error_site();}

   } else {$self->index_site();}
}

sub error_site {
   my ($self) = @_;

   my $cgi = $self->{cgi};

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/error.tmpl', );

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;
   }

sub index_site {
   my ($self) = @_;

   my $cgi = $self->{cgi};

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/home.tmpl', );

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub storage_showall {
   my ($self) = shift @_;
   my ($tablename) = shift @_;

   my $cgi = $self->{cgi};

   #retrieving the data from the database

   my $dbh = $self->{dbh};
   my $obj_DBaction = DBaction->new($dbh,$tablename);
   my @ar_rows = $obj_DBaction->show_all();

   # Fetch each row and push it into @loop, if it is not deleted. "ar" = ArrayReferenz
   # @loop is an Array of Hashreferences with the fieldnames as keys of the hashes
   # that is needed by <TMPL_LOOP> of the Template

   my @loop;

   foreach my $row (@ar_rows) {
      my @fields = @$row;
      if (!$fields[5]) {
         my %content = (
            'id'       => $fields[0] ,
            'name'     => $fields[1] ,
            'capacity' => $fields[2] ,
            'created'  => $fields[3] ,
            'modified' => $fields[4]
         );
         push(@loop , \%content);
      }
   }

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storages.tmpl', );

   # Sending the data to the Template
   $template->param(data_loop => \@loop);

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub server_showall {
   my ($self) = shift @_;
   my ($tablename) = shift @_;

   my $cgi = $self->{cgi};

   #retrieving the data from the database

   my $dbh = $self->{dbh};
   my $obj_DBaction = DBaction->new($dbh,$tablename);
   my @ar_rows = $obj_DBaction->show_all();


   # Fetch each row and push it into @loop. "ar" = ArrayReferenz
   # @loop is an Array of Hashreferences with the fieldnames as keys of the hashes
   # that is needed by <TMPL_LOOP> of the Template

   my @loop;

   foreach my $row (@ar_rows) {
      my @fields = @$row;
      my %content = (
         'id'        => $fields[0],
         'name'      => $fields[1],
         'op_system' => $fields[2],
         'storage'   => $fields[3],
         'md5'       => $fields[4],
         'created'   => $fields[5],
         'modified'  => $fields[6]
      );
      push(@loop, \%content);
   }

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/servers.tmpl', );

   # Sending the data to the Template
   $template->param(data_loop => \@loop);

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub storage_edit {
   my ($self) = shift @_;
   my ($tablename) = 'storage';

   my $cgi = $self->{cgi};
   my $dbh = $self->{dbh};

   #my $id = $cgi->url_param('id');

   my $obj_DBaction = DBaction->new( $dbh , $tablename );

   if ($cgi->request_method eq 'POST') {
      my $new_name = $cgi->param('name');
      my $capacity = $cgi->param('capacity');
      my $id = $cgi->param('id');

      $obj_DBaction->update_record($id, $new_name, $capacity);
   }

   my $obj_record = $obj_DBaction->get_record('id',$cgi->url_param('id'));


#   # Compare the sent data with the DB-Data. If it differs, change it.
#   if ($capacity != $obj_record->get_capacity()) {
#      $obj_record->set_capacity($capacity);
#   }
#
#   if (($cgi->param('name')) ne ($obj_record->get_name())) {
#      $obj_record->set_name($cgi->param('name'));
#   }


   # Assemble the data for the template
   my %content = (
      'id'       => $obj_record->get_id(),
      'name'     => $obj_record->get_name(),
      'capacity' => $obj_record->get_capacity()
   );
   my @record = \%content;

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storage-edit.tmpl' ,);

   # Sending the data to the Template
   $template->param(data_loop => \@record);

   # print the template
   print $cgi->header(-type => 'text/html' , -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub server_edit {
   my ($self) = @_;

}

sub storage_new {
   my ($self) = @_;
   my ($tablename) = 'storage';

   my $cgi = $self->{cgi};
   my $dbh = $self->{dbh};

   # $cgi->param() provides a list, therefore youhave to turn it into scalar context like follws,
   # or just use "" like in line 214

   #my $new_name = ($cgi->param('new_name'));
   #my $size = ${$cgi->param('size')};

   my $obj_DBaction = DBaction->new( $dbh , $tablename );
   my $obj_new_record = $obj_DBaction->insert_record("FTL000000666",000000666);


   # Assemble the data for the template
   my %content = (
      'id'       => $obj_new_record->get_id(),
      'name'     => $obj_new_record->get_name(),
      'capacity' => $obj_new_record->get_capacity()
   );
   my @record = \%content;

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storage-edit.tmpl' ,);

   # Sending the data to the Template
   $template->param(data_loop => \@record);

   # print the template
   print $cgi->header(-type => 'text/html' , -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub server_new {
   my ($self) = @_;

}

sub storage_delete {
   my ($self) = @_;
   my ($tablename) = 'storage';

   my $cgi = $self->{cgi};
   my $dbh = $self->{dbh};

   my $obj_DBaction = DBaction->new( $dbh , $tablename );
   $obj_DBaction->delete_record_by_id($cgi->param('id'));

   # Assemble the data for the template
   my %content = (
      'id'       => '-',
      'name'     => '-',
      'capacity' => '-'
   );
   my @record = \%content;

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storage-edit.tmpl' ,);

   # Sending the data to the Template
   $template->param(data_loop => \@record);

   # print the template
   print $cgi->header(-type => 'text/html' , -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}


sub server_delete {
   my ($self) = @_;

}


1;