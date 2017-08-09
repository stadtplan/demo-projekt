#!/Users/c5261168/perl5/perlbrew/perls/perl-5.24.0/bin/perl
use strict;
use warnings FATAL => 'all';
use CGI;
use HTML::Template;
use Service::DBconnect;
use Controller::FrontControl;


# Create the CGI-Object
my $cgi = CGI->new();

# Create the DB-Object
my $db = DBconnect->new();
my $dbh = $db->connect();

my $front_control = FrontControl->new($cgi, $dbh);
$front_control->handle_request();
