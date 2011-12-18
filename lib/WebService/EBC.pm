package WebService::EBC;

use warnings;
use strict;
use Moose;
use XML::Feed;
use WebService::EBC::Feed;
use LWP::Simple;

#use MooseX::NonMoose;

has 'feeds' => (
      is  => 'rw',
      isa => 'ArrayRef',
);

has 'flow' => (
      is  => 'rw',
      isa => 'HashRef',
);

has 'result' => (
      is  => 'rw',
      isa => 'ArrayRef',
);

has 'url' => (
      is  => 'rw',
      isa => 'Str',
);

has 'content' => (
      is  => 'rw',
      isa => 'Str',
);

has 'sinopse' => (
      is  => 'rw',
      isa => 'Str',
);

has 'media' => (
      is  => 'rw',
      isa => 'Str',
);

has 'titulo' => (
      is  => 'rw',
      isa => 'Str',
);

has 'author' => (
      is  => 'rw',
      isa => 'Str',
);



=head1 NAME

WebService::EBC - The great new WebService::EBC!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

	use WebService::EBC;

	my $brnews = WebService::EBC->new (
	      feeds => [
		 'http://agenciabrasil.ebc.com.br/feed/ultimasnoticias/feed.xml',
		 'http://tvbrasil.ebc.com.br/reporterbrasil/rss/last/'
	      ],
	      flow    => { 
                     search => {title => {like => 'cerveja'}}, 
                     sort => 'title', 
                     only_links 
              }
	);
        # $links is ArrayRef
        my $links = $brnews->refresh;

=head1 DESCRIPTION

WebService::EBC read rss feeds and do DataFlow process in it.

You must specify one or more link feeds. If no flow specified no filter will be applied.

The refresh() method returns an array of links code like "<a href='/link'>My Link</a>".  

=cut


=head1 METHODS

=head2 ultimas

Return the posh links and titles from
http://agenciabrasil.ebc.com.br/ultimasnoticias

Read the page with


sub ultimas {
    my $self = shift;
    $self->flow( new DataFlow (
	# retrieve page
	[
	    URLRetriever => (
		baseurl => 'http://agenciabrasil.ebc.com.br/ultimasnoticias',
		ua_options => ()
	    )
	],
	# filter news as time, title, body and link
	[],
	# return posh data
	[]
    ));
    return $self->flow->output;
}
=cut

=head2 ultimas_json

Return json with links and titles from
http://agenciabrasil.ebc.com.br/ultimasnoticias

Read the page with


sub ultimas_json {
    my $self = shift;
    $self->flow( new DataFlow (
	# retrieve page
	[
	    URLRetriever => (
		baseurl => 'http://agenciabrasil.ebc.com.br/ultimasnoticias',
		ua_options => ();
	    )
	],
	# filter news as time, title, body and link
	[],
	# return json data
	[]
    ));
    return $feeds;
}

=cut


=head2 find_feeds

=cut

sub find_feeds {
    my $feeds =  [XML::Feed->find_feeds('http://rss.ebc.com.br/')];
    return $feeds;
}

=head2 refresh
    
   return all feeds as an ArrayRef

=cut

sub refresh {
    my $self = shift;
    my $result = [];

    foreach my $feed (@{$self->{feeds}}) {
        my $ebc_feed = new WebService::EBC::Feed();
        $ebc_feed->load($feed);
        push(@{$result}, $ebc_feed);
    }
    $self->result($result);
    return $result;
}

=head2 get_feed

   return the feed
    
=cut

sub get_feed {
    my $self = shift;
    my $feed = shift;
    my $result = new WebService::EBC::Feed();
    $result->load($self->{feeds}[$feed]);
    return $result;
}

sub find {
   # I will return an object ... hmmm
}

no Moose;
__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Monsenhor, C<< <monsenhor at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-yacx-ebc at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-EBC>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::EBC


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-EBC>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-EBC>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-EBC>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-EBC/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Monsenhor.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WebService::EBC
