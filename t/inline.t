#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most tests => 1;

use Test::Needs qw(Inline::CPP);

subtest "Testing version" => sub {
	Inline->import( with => 'Alien::Kiwisolver' );
	Inline->bind( CPP => <<'EOF' );
char* kiwi_version() {
	return KIWI_VERSION;
}
EOF

	note kiwi_version();
	like kiwi_version(), qr/^[\d.]+$/, 'Got version';
};

done_testing;
