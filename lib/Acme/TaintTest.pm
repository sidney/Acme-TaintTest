package Acme::TaintTest;
require v5.14.0;
use strict;
use warnings;

our $VERSION = "0.0.4";

print "This is a dummy, it's all in the tests\n";

1;
__END__

=encoding utf-8

=head1 NAME

Acme::TaintTest - The module doesn't do anything

=head1 SYNOPSIS

    use Acme::TaintTest;

=head1 DESCRIPTION

Acme::TaintTest began as a way of testing a Perl bug related to taint
checking that could only be made to be triggered on certain CPAN
tester machines. The author has retained it to use for any future
experiments that require subitting a module for CPAN testing. The
module itself is not intended to do anything.

=head1 LICENSE

Copyright (C) 2024 sidney.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

SIDNEY on CPAN

=cut

