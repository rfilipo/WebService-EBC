package WebService::EBC::News;

use warnings;
use strict;
use XML::Feed;
use LWP::Simple;
use Moose;
use MooseX::NonMoose;


=head1 NAME

WebService::EBC::News

A news object. Facilitie to access news in EBC

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

has 'texto' => (
      is  => 'rw',
      isa => 'Str',
);

has 'content' => (
      is  => 'rw',
      isa => 'Str',
);

has 'url' => (
      is  => 'rw',
      isa => 'Str',
);

has 'media' => (
      is  => 'rw',
      isa => 'ArrayRef',
);


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WebService::EBC;

    my $foo = WebService::EBC->new();
    $foo.
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

=head2 find

=cut

sub find {
    my $self = shift;
    my $hash = shift;

    use HTML::TreeBuilder;

    # download the news
    $self->content(get($hash->{ebc_link}));
    die "Couldn't get it!" unless defined $self->{content};
    $self->url($hash->{ebc_link});

    my $content;
    my $sinopse;
    my $titulo;
    my $media;
    my $tree = HTML::TreeBuilder->new;
    $tree->parse_content($self->content);  
    $content = $tree->look_down( 'id', 'content' );

 
    if($content) {
        # retrieve all content news
         my $textotree = $content->look_down( 'class', 'node' );
         $textotree = $textotree->look_down( 'class', 'content' );
         my $texto = join '',
	    map(
	      ref($_) ? $_->as_HTML : $_,
	      $textotree->content_list
	    );
         $self->texto( $texto );

         # retrieve the title
         my $titulotree = $content->look_down( 'class', 'title' );
         $titulo = join '',
	    map(
	      ref($_) ? $_->as_HTML : $_,
	      $titulotree->content_list
	    );
         $self->titulo( $titulo );

         # retireve a sinopse
         my $sinopsetree = $content->look_down( 'class', 'content' );
         $sinopse = join '',
	    map(
	      ref($_) ? $_->as_HTML : $_,
	      $sinopsetree->content_list
	    );
         $sinopse =~ s/\<img .*\/>//;
         my $sl = 360 - (length $titulo) * 2.8; # sinopse length
         if ($sl < 70){$sl = 0;} 
         $sinopse = substr($sinopse, 0, $sl);
         $sinopse =~ s/(\w+)$//;
         #$sinopse =~ s/(\<\w*)$//;
         $sinopse =~ s/(\&\w*)$//;

         $self->sinopse( $sinopse );
         
         # get the pictures
         $self->media( new WebService::EBC::Picture ({ 
		    dom => $content 
	        })->find;
         ) unless ! $content ;
    } else {
        $self->texto("No text in $_[0]?");
    }
    return $self;
}



=head2 function1

=cut

sub function1 {
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
