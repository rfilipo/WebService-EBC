#!perl -T

use Test::More tests => 10;
use WebService::EBC;

# init some feeds
my $brnews = WebService::EBC->new (
      feeds => [
         'http://agenciabrasil.ebc.com.br/feed/ultimasnoticias/feed.xml',
#         'http://tvbrasil.ebc.com.br/reporterbrasil/rss/last/'
      ],
      flow    => {}
);

ok($brnews, 'Cria um EBC');

# create the feeds list
ok ($brnews->refresh, 'retrieve all feeds');

# process the ultimas noticias
my $noti = $brnews->get_feed(0);

ok ($noti, 'get news');
isa_ok($noti, 'WebService::EBC::Feed');
isa_ok($noti->feed, 'XML::Feed');

isa_ok($noti->news->[0], 'WebService::EBC::News');
my $news = $noti->news->[0];
use Data::Dumper;
print Dumper $noti->feed->items(0);
 
exit;
ok ($news->{titulo},'Have a title');
ok ($news->{sinopse},'Have a sinopsis');
ok ($news->{content},'Have a content');

isa_ok($noti->picture->[0], 'WebService::EBC::Picture');

my $tv   = $brnews->get_feed(1);
ok ($tv, 'get tv');
isa_ok($tv->video->[0], 'WebService::EBC::Video');


