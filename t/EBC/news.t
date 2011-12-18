#
#===============================================================================
#
#         FILE:  news.t
#
#  DESCRIPTION:  tests the WebService::EBC::News module
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  monsenhor (monsenhor), monsenhor@cpan.org
#      COMPANY:  studiodesign88.com
#      VERSION:  1.0
#      CREATED:  11/17/2011 05:34:22 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use Test::More tests => 7;                      # last test to print

use WebService::EBC::News;

my $news = new WebService::EBC::News;

ok($news->find({ebc_link => 'http://agenciabrasil.ebc.com.br/noticia/2011-11-17/negros-recebem-quase-40-menos-por-hora-de-trabalho-do-que-demais-camadas-da-populacao-segundo-dieese'}), 'Can find a ebc news');

ok ($news->{url}    , $news->{url}    );
ok ($news->{content}, 'Retrieve a content');
ok ($news->{texto}  , $news->{texto}  );
ok ($news->{titulo} , $news->{titulo} );
ok ($news->{sinopse}, $news->{sinopse});
ok ($news->{media});
