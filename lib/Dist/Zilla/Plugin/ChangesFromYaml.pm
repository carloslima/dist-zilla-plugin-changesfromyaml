package Dist::Zilla::Plugin::ChangesFromYaml;
# ABSTRACT: convert Changes from YAML to CPAN::Changes::Spec format
our $VERSION = '0.001'; # VERSION

use Moose;
with( 'Dist::Zilla::Role::FileMunger' );
use namespace::autoclean;
use Dist::Zilla::Plugin::ChangesFromYaml::Convert qw(convert);

sub munge_file {
    my ($self, $file) = @_;

    return unless $file->name eq 'Changes';

    $file->content( convert( $file->content ) );
    $self->log_debug(
        [
            'Converte Changes from YAML to CPAN::Changes::Spec', $file->name
        ]
    );
}

__PACKAGE__->meta->make_immutable;
1;
