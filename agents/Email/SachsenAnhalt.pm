package SachsenAnhalt;

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
	use LWP::Simple;

	my $mech = WWW::Mechanize->new(agent => "OSST/0.1");
	$mech->get($formurl);

	my $image = $mech->find_image(url_regex => qr/checkNumber/);
	mirror($image->url_abs(), "_captcha.png");
	system("tesseract _captcha.png _captcha");
	open(F, "_captcha.txt");
	my $captcha = <F>;
	chomp $captcha;
	close(F);

	$mech->submit_form(
		form_number => 1,
		fields => {"OBJECT[ACT_LASTNAME]" => $id_lastname,
			"OBJECT[ACT_FIRSTNAME]" => $id_firstname,
			"OBJECT[ACT_STREET]" => $id_street,
			"OBJECT[ACT_CITY]" => $id_city,
			"OBJECT[ACT_POSTALCODE]" => $id_zipcode,
			"OBJECT[ACT_COUNTRY]" => "Deutschland",
			"OBJECT[ACT_ALIAS]" => $login,
			"OBJECT[ACT_PASSWORD]" => $password,
			"OBJECT[ACT_PASSWORDCONFIRM]" => $password,
			"CHECKNUMBER" => "$captcha"}
	);
}

1;
