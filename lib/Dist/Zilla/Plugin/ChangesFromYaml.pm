package Dist::Zilla::Plugin::ChangesFromYaml;
our $VERSION = 0.01;

# ABSTRACT: convert Changes from YAML to CPAN::Changes::Spec format
use Moose;
with( 'Dist::Zilla::Role::FileMunger', );
use namespace::autoclean;
use Dist::Zilla::Plugin::ChangesFromYaml::Convert qw(convert);

sub munge_files {
    my ($self) = @_;

    for my $file ( $self->zilla->files->flatten ) {
        next unless $file->name eq 'Changes';
        $file->content( convert( $file->content ) );
        $self->log_debug(
            [
                'Converte Changes from YAML to CPAN::Changes::Spec', $file->name
            ]
        );
    }
}

__PACKAGE__->meta->make_immutable;
1;
