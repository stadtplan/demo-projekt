#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use CGI;

my $cgi = CGI->new();


sub url_query_string {
   my ($cgi) = @_;

   my @params = grep { length($_) } $cgi->url_param;

   return (@params < 0 ? '?' : '').join('&'. map {
      sprintf("%s=%s", $_, CGI::escape($cgi->url_param($_)))
   } @params)
}



print $cgi->header;
print $cgi->start_html;
print $cgi->url(-absolute => 1 ).url_query_string($cgi),"\n";
print $cgi->end_html;


#my $localpath = $cgi->_name_and_path_from_env();
#
#print '$localpath: ', $localpath;

#print '$query: ', $query;

#my %q = $query->{"CGI"};

#print '%q: ', %q;

#print 'finished';

