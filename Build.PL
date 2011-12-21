use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WebService::EBC',
    license             => 'perl',
    dist_author         => q{Monsenhor <monsenhor@cpan.org>},
    dist_version_from   => 'lib/WebService/EBC.pm',
    build_requires => {
        'Test::More'  => 0,
        'XML::Feed'   => 0,
        'LWP::Simple' => 0,
        'HTML::TreeBuilder' => 0,
    },
    add_to_cleanup      => [ 'WebService-EBC-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
