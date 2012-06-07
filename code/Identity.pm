package Identity;

use strict;

sub debug{
	my $s = shift(@_);
	#print $s;
}

sub new{
	my $class = shift;
	my $self = {
		identity => "",
		vcard_email => "",
		vcard_title => "",
		vcard_firstname => "",
		vcard_lastname => "",
		vcard_street => "",
		vcard_zipcode => "",
		vcard_city => "",
		vcard_prefix => "",
		vcard_phone => "",
		vcard_birthday => "",
		vcard_birthmonth => "",
		vcard_birthyear => ""
	};
	bless($self, $class);
	return $self;
}

sub setup(){
	#$vcard_email = "whatever\@whatever.ru";
	#$vcard_title = "UnusedTitleMr.";
}

sub check{
	my $mod = shift;

	my @idlist = ("id_email", "id_title", "id_firstname", "id_lastname", "id_street", "id_zipcode", "id_city", "id_prefix", "id_phone", "id_birthday", "id_birthmonth", "id_birthyear");

	my $counter = 0;
	my $reqcounter = 0;
	my @requests = ();
	foreach my $id(@idlist){
		my $id_field = eval "\$" . $mod . "::$id";
		if(!defined($id_field)){
			$counter++;
			debug "[c] ----: $id\n";
		}elsif($id_field eq ""){
			$reqcounter++;
			push @requests, $id;
			debug "[c] reqd: $id\n";
		}else{
			debug "[c] used: $id [$id_field]\n";
		}
	}

	my $sum = $#idlist + 1;
	my $index = sprintf("%3.2f", 100 * $counter / $sum);
	debug "   *** $counter fields out of $sum undefined (unused) -> privacy index: $index%\n";
	debug "   *** $reqcounter fields required but not set -> fails if >0\n";
	return ($index, @requests);
}

1;
