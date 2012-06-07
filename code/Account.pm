package Account;

use strict;

sub store{
	my $mod = shift;
	my $accountfile = shift;

	my @nonidlist = ("name", "formurl", "login", "password");
	my @idlist = (@nonidlist, "id_email", "id_title", "id_firstname", "id_lastname", "id_street", "id_zipcode", "id_city", "id_prefix", "id_phone", "id_birthday", "id_birthmonth", "id_birthyear");

	open(F, ">$accountfile");
	foreach my $id(@idlist){
		my $id_field = eval "\$" . $mod . "::$id";
		if((defined($id_field)) && ($id_field ne "")){
			print F "$id=$id_field\n";
		}
	}
	close(F);
}

1;
