#!/Users/c5261168/perl5/perlbrew/perls/perl-5.24.0/bin/perl
use strict;
use warnings FATAL => 'all';
use CGI;
use HTML::Template;
use Service::DB;
use Controller::FrontControl;


# Create the CGI-Object
my $cgi = CGI->new();

# Create the DB-Object
my $db = DB->new();
my $dbh = $db->connect();

my $front_control = FrontControl->new($cgi, $dbh);
$front_control->handle_request();

## Create the Template-Object
#my $template = HTML::Template->new(filename => 'Templates/view.tmpl', );
#
## print the template
#print $cgi->header(-type => 'text/html', -charset => 'utf-8');
#print $template->output;
#print $cgi->end_html;