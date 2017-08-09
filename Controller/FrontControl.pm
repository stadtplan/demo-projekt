package FrontControl;
use strict;
use warnings FATAL => 'all';
use HTML::Template;
use Service::DBconnect;
use Service::DBaction;
use DBI;
use DDP;

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

   # Fetch each row and push it into @loop. "ar" = ArrayReferenz
   # @loop is an Array of Hashreferences with the fieldnames as keys of the hashes
   # that is needed by <TMPL_LOOP> of the Template

   my @loop;

   foreach my $row (@ar_rows) {
      my @fields = @$row;
      my %content = (
         'id'        => $fields[0],
         'name'      => $fields[1],
         'capacity'  => $fields[2],
         'created'   => $fields[3],
         'modified'  => $fields[4]
      );
      push(@loop, \%content);
   }

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storage.tmpl', );

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
   my $template = HTML::Template->new(filename => 'Templates/storage.tmpl', );

   # Sending the data to the Template
   $template->param(data_loop => \@loop);

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}

sub storage_new {
   my ($self) = @_;

}

sub server_new {
   my ($self) = @_;

}

sub storage_delete {
   my ($self) = @_;

}

sub server_delete {
   my ($self) = @_;

}

sub storage_edit {
   my ($self) = @_;

}

sub server_edit {
   my ($self) = @_;

}


1;