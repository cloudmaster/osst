package StratoHiDrive;

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
	#use Identity;

	$id_email = $identity->{vcard_email};
	$id_firstname = $identity->{vcard_firstname};
	$id_lastname = $identity->{vcard_lastname};
	$id_title = $identity->{vcard_title};
	$id_street = $identity->{vcard_street};
	$id_zipcode = $identity->{vcard_zipcode};
	$id_city = $identity->{vcard_city};
	$id_prefix = $identity->{vcard_prefix};
	$id_phone = $identity->{vcard_phone};

	$login = undef;
	$password = undef;
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
		fields => {title_gender => $id_title, first_name => $id_firstname, last_name => $id_lastname, street => $id_street, zipcode => $id_zipcode, city => $id_city,
		phone_city_prefix => $id_prefix, phone => $id_phone, email => $id_email, email_conf => $id_email, mediacode => "4209"}
	);
	# FIXME: (v) Ich habe die AGB, den Hinweis auf das Widerrufsrecht für Verbraucher sowie die Datenschutzrichtlinien der STRATO AG gelesen und akzeptiert.
	# => "Bestellung abschließen"
}

1;
