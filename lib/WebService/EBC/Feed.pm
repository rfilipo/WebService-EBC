package WebService::EBC::Feed;

use warnings;
use strict;
use XML::Feed;
use Moose;
use WebService::EBC::News;
use WebService::EBC::Picture;
use WebService::EBC::Video;


=head1 NAME

WebService::EBC::Feed

A feed facility. Parse the feed and retrieve news, pictures and videos.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

has 'feed' => (
      is      => 'rw',
      isa     => 'XML::Feed',
      lazy    => 1,
      default => sub { XML::Feed->new('RSS') }
);


=head1 SYNOPSIS

Perhaps a little code snippet.

    use WebService::EBC;

    my $foo = WebService::EBC->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 load

=cut

sub load {
    my $self    = shift;
    my $feed_uri = shift;
    my $uri = new URI($feed_uri);
    $self->feed(XML::Feed->parse($uri)) or croack XML::Feed->errstr;
    return $self->{feed};
}

=head2 news

=cut

sub news {
    my $self = shift;
    my $result = [];
    $result->[0] = new WebService::EBC::News;
    return $result;
}

=head2 video

=cut

sub video {
    my $self = shift;
    my $result = [];
    $result->[0] = new WebService::EBC::Video;
    return $result;
}

=head2 picture

=cut

sub picture {
    my $self = shift;
    my $result = [];
    $result->[0] = new WebService::EBC::Picture;
    return $result;
}



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
