package Firemail;

use strict;
use vars qw($name $formurl $login $password $id_email $id_title $id_firstname $id_lastname);
use vars qw($id_street $id_zipcode $id_city $id_prefix $id_phone);
use vars qw($id_birthday $id_birthmonth $id_birthyear);

sub setupservice{
	my $service = shift(@_);

	$name = $service->{name};
	$formurl = $service->{formurl};
}

sub setupidentity{
	my $identity = shift(@_);

	use Crypt::GeneratePassword;
	#use Identity;

	$password = Crypt::GeneratePassword::word(8, 10);

	$id_firstname = $identity->{vcard_firstname};
	$id_lastname = $identity->{vcard_lastname};
	$id_street = $identity->{vcard_street};
	$id_zipcode = $identity->{vcard_zipcode};
	$id_city = $identity->{vcard_city};

	$login = "$id_firstname$id_lastname";
	$login =~ s/\ //g;
	$login = lc($login);

	$id_email = undef;
	$id_title = undef;
	$id_prefix = undef;
	$id_phone = undef;
	$id_birthday = undef;
	$id_birthmonth = undef;
	$id_birthyear = undef;
}

sub signup{
	use WWW::Mechanize;

	my $mech = WWW::Mechanize->new(agent => "OSST/0.1");
	$mech->get($formurl);
	$mech->submit_form(
		form_number => 1,
		fields => {"email_local" => $login,
			"firstname" => $id_firstname,
			"surname" => $id_lastname,
			"street" => $id_street,
			"no" => "9",
			"zip" => $id_zipcode,
			"city" => $id_city,
			"pass1" => $password,
			"pass2" => $password,
			"tos" => "true"}
	);
}

1;
