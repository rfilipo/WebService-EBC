#!perl -T

use Test::More tests => 1;
use YACx::EBC;
use utf8;

my $brnews = YACx::EBC->new (
      feeds => [
         'http://agenciabrasil.ebc.com.br/feed/ultimasnoticias/feed.xml',
      ],
      flow    => {}
);

my $ultimas = $brnews->refresh;

use Data::Dumper;
use Time::Piece;
ok ($ultimas, 'retrieve last news');
foreach my $ultima (@{$ultimas}){
   foreach my $item (@{$ultima->{feed}->{rss}->{items}}){
      $item->{pubDate} =~ s/\ \+0000//g;
      my $date       = Time::Piece->strptime($item->{pubDate}, "%a, %d %b %Y %T");
      my $datestring = $date->hms . " " . $date->dmy . " - " ; 
 
      print "* " . $datestring;
      foreach my $cat (@{$item->{category}}){
      	  print $cat ." ";
      }
      print "\n" . $item->{link};
      print "\n" . $item->{title} . "\n";
   }
}

