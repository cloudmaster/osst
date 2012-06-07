package TelekomCloud;

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

	$login = Crypt::GeneratePassword::word(8, 10);
	$password = Crypt::GeneratePassword::word(8, 10);

	$id_firstname = $identity->{vcard_firstname};
	$id_lastname = $identity->{vcard_lastname};
	$id_title = "h"; # FIXME: derive from "Herr" somehow?
	$id_birthday = $identity->{vcard_birthday};
	$id_birthmonth = $identity->{vcard_birthmonth};
	$id_birthyear = $identity->{vcard_birthyear};

	$id_email = undef;
	$id_street = undef;
	$id_zipcode = undef;
	$id_city = undef;
	$id_prefix = undef;
	$id_phone = undef;
}

sub signup{
	use WWW::Mechanize;

	my $mech = WWW::Mechanize->new(agent => "OSST/0.1");
	$mech->get($formurl);
	$mech->submit_form(
		form_number => 2,
		fields => {salutation => $id_title, prename => $id_firstname, surename => $id_lastname, dobd => $id_birthday, dobm => $id_birthmonth, doby => $id_birthyear}
	);
	$mech->submit_form(
		form_number => 1,
		fields => {vspDataSicherheitscode => "???"}
	);
	# FIXME: captcha solver? ^^
	$mech->submit_form(
		form_number => 1,
		fields => {vspDataBenutzername => $login, vspDataEmailneu => "vspDataEmailneu_free"}
	);
	$mech->submit_form(
		form_number => 1,
		fields => {vspDataPasswort => $password, vspDataPasswort2 => $password, vspDataSicherheitsantwort => "bldsfjsdifjsidfjsg"}
	);
	# FIXME: automatische Auswahl der Sicherheitsfrage? ^^
	$mech->submit_form(
		form_number => 1,
		fields => {vspDataVirenscan => "off"}
	);
	# FIXME: Zustimmungs-Checkbox? ^^
}

1;
