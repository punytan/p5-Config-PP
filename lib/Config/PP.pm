package Config::PP;
use strict;
use warnings;

use parent 'Exporter';
our @EXPORT  = qw(config_get config_set);

use Data::Dumper;
use File::Spec;
use Carp;

our $VERSION = '0.01';
our $DIR     = File::Spec->catfile($ENV{HOME}, '.ppconfig');

# path: $DIR/${namespace}.pl

sub config_get ($) {
    my $namespace = shift;
    my $path = path($namespace);
    return (do $path or Carp::croak "$!: $path");
}

sub config_set ($$) {
    my ($namespace, $data) = @_;
    my $path = path($namespace);

    open my $fh, ">", $path or Carp::croak "$!: $path";
    print {$fh} Dumper($data);
    close $fh or Carp::croak $!;
}

sub path {
    my $namespace = shift;

    unless (-d $DIR) {
        mkdir $DIR, 0700 or Carp::croak "Can't mkdir: $DIR";
    }

    File::Spec->catfile($DIR, "${namespace}.pl");
}

1;
__END__

=head1 NAME

Config::PP -

=head1 SYNOPSIS

  use Config::PP;

  config_set "example.com", {hoge => 'fuga'};

  print Dumper config_get "example.com";


=head1 DESCRIPTION

Config::PP is

=head1 AUTHOR

punytan E<lt>punytan@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
