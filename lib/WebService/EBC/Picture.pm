package WebService::EBC::Picture;

use warnings;
use strict;
use Moose;
use MooseX::NonMoose;


=head1 NAME

WebService::EBC - The great new WebService::EBC!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

has 'titulo' => (
      is  => 'rw',
      isa => 'Str',
);

has 'sinopse' => (
      is  => 'rw',
      isa => 'Str',
);

has 'width' => (
      is  => 'rw',
      isa => 'Str',
);

has 'height' => (
      is  => 'rw',
      isa => 'Str',
);

has 'url' => (
      is  => 'rw',
      isa => 'Str',
);

has 'dom' => (
      is  => 'rw',
      isa => 'Str',
);


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WebService::EBC;

    my $foo = WebService::EBC->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut


sub BUILD {
        use Carp;
	my $self = shift;
	croak ('
EBC::Picture needs a url or a dom in the constructor, bad! 
	);
	') unless $self->{url} || $self->{dom};
        return $self;
}


sub find {
         $self = shift;
         my $content = $self->{dom};
         # retrieve the media
         my $mediatree = $content->look_down( '_tag', 'img' );
         my $url = $mediatree->attr('src') unless ! $mediatree;
         # if no image put a default one
         $url = "/images/ebc_evento4anos.png?http://" unless $url;
         $_ = $url;
         if (!  m/http\:\/\// ){
             $url = "http://agenciabrasil.ebc.com.br/". $url;
         }
         $media->[0] = { url => $url } ;
    
}

=head2 function2

=cut

sub function2 {
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
