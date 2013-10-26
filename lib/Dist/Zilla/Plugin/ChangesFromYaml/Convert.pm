#!/usr/bin/env perl
package ChangesFromYaml;

use 5.010;
use strict;
use warnings;
use YAML::XS;
use CPAN::Changes;
use Exporter 'import';
our @EXPORT_OK(convert);

sub convert {
    my ($changes_yml) = @_;

    my @releases = Load( $changes_yml );

    for (@releases) {
        my $rel = CPAN::Changes::Release->new(
            version => $_->{version},
            date    => $_->{date},
        );

        $rel->add_changes($_) for @{ $_->{changes} };
        $changes->add_release($rel);
    }
    return $changes->serialize;
}
