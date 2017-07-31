#!/Users/c5261168/perl5/perlbrew/perls/perl-5.24.0/bin/perl
use strict;
use warnings FATAL => 'all';
use CGI;
use HTML::Template;



my $cgi = CGI->new();



## the fruit data - the keys are the fruit names and the values are
## pairs of color and shape contained in anonymous arrays
#my %fruit_data = (
#Apple => ['Red, Green or Yellow', 'Round'],
#Orange => ['Oränge', 'Round'],
#Pear => ['Green or Red', 'Pear-Shaped'],
#Banana => ['Yellöw', 'Curved'],
#);
#
my $template = HTML::Template->new(filename => 'Templates/view.tmpl', );
#
#my @loop;  # the loop data will be put in here
#
## fill in the loop, sorted by fruit name
#foreach my $name (sort keys %fruit_data) {
#      # get the color and shape from the data hash
#      my ($color, $shape) = @{$fruit_data{$name}};
#
#      # make a new row for this fruit - the keys are <TMPL_VAR> names
#      # and the values are the values to fill in the template.
#      my %row = (
#      name => $name,
#      color => $color,
#      shape => $shape
#      );
#
#      # put this row into the loop by reference
#      push(@loop, \%row);
#   }

# call param to fill in the loop with the loop data by reference.
#$template->param(fruit_loop => \@loop);

   $template->param(name => 'Hörst');
   $template->param(color => 'Blü');
   $template->param(shape => 'Peach');



   # print the template
   print $cgi->header(-type => 'text/html', -charset => 'utf-8');
   print $template->output;
   print $cgi->end_html;