#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebService::EBC' ) || print "Bail out!
";
}

diag( "Testing WebService::EBC $WebService::EBC::VERSION, Perl $], $^X" );
