package Alien::Kiwisolver;
# ABSTRACT: Alien package for the Kiwi C++ implementation of the Cassowary constraint solving algorithm

use strict;
use warnings;

use parent qw(Alien::Base);

sub inline_auto_include {
	return  [ 'kiwi/kiwi.h' ];
}

sub Inline {
	my ($self, $lang) = @_;

	if( $lang =~ /^CPP$/ ) {
		my $params = Alien::Base::Inline(@_);

		$params->{CCFLAGSEX} = $self->runtime_prop->{cppstdflag};

		$params->{PRE_HEAD} = <<'		EOF';
		#if defined(_MSC_VER) || defined(__MINGW32__)
		#  define NO_XSLOCKS /* To avoid Perl wrappers of C library */
		#endif

		#ifdef __cplusplus
			// Avoid Perl's "seed" macro that breaks <algorithm> by including <algorithm> first.
			#include <algorithm>
		#endif

		EOF

		return $params;
	}
}


1;
__END__

=head1 Inline support

This module supports L<Inline's with functionality|Inline/"Playing 'with' Others">.

=head1 SEE ALSO

L<Kiwi solver|https://kiwisolver.readthedocs.io/>


