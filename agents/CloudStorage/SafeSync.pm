package SafeSync;

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

	$id_email = $identity->{vcard_email};
	$id_firstname = $identity->{vcard_firstname};
	$id_lastname = $identity->{vcard_lastname};

	$login = undef;
	$id_title = undef;
	$id_street = undef;
	$id_zipcode = undef;
	$id_city = undef;
	$id_prefix = undef;
	$id_phone = undef;
	$id_birthday = undef;
	$id_birthmonth = undef;
	$id_birthyear = undef;
}

sub signup{
	use WWW::Mechanize;

	my $mech = WWW::Mechanize->new(agent => "OSST/0.1");
	$mech->add_header(Accept_Language => "de");
	$mech->get($formurl);
	#$mech->get("file:///tmp/osst/register-safesync.html");
	$mech->submit_form(
		form_number => 1,
		fields => {name => "$id_firstname $id_lastname", email => $id_email, "password" => $password, "confirm_password" => $password}
	);
}

1;
