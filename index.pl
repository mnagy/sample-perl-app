#!/usr/bin/perl

use Weather::Underground;

$place = "Brno, Czech Republic";
$weather = Weather::Underground->new(
	place => $place,
	debug => 0,
) || die "Error, could not create new weather object: $@\n";

$arrayref = $weather->get_weather()
|| die "Error, calling get_weather() failed: $@\n";

print "Content-type: text/html\n\n";
print <<EOF
<html>
<head><title>Weather in $place</title></head>
<body>
EOF
;
foreach (@$arrayref) {
	print "MATCH:\n";
	while (($key, $value) = each %{$_}) {
		print "\t$key = $value\n";
	}
	my %result = %{$_};
	print "<p>In $result{'place'}: $result{'celsius'}°C, $result{'conditions'}, Sun sets at $result{'sunset'}, last updated: $result{'updated'}.<p>";
}
print <<EOF
</body>
</html>
EOF
;
