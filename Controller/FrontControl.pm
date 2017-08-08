package FrontControl;
use strict;
use warnings FATAL => 'all';
use HTML::Template;


sub new {
   my ($class, $cgi, $dbh) = @_;
   my $self = bless {
         cgi => $cgi,
         dbh => $dbh
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

   #print $cgi->header(-type => 'text/html', -charset => 'utf-8');

#   print $method;
#   print 'O'.@knots;
#   die;

   if ($method) {

      if ($self->can($method)) {
         $self->$method;
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
   my ($self) = @_;

   my $cgi = $self->{cgi};

   # Create the Template-Object
   my $template = HTML::Template->new(filename => 'Templates/storage.tmpl', );

   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;

}


1;