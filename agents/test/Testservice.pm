package Testservice;

use strict;
use vars qw($name $formurl $login $password $id_email $id_title $id_firstname $id_lastname);
use vars qw($id_street $id_zipcode $id_city $id_prefix $id_phone);
use vars qw($id_birthday $id_birthmonth $id_birthyear);

sub setup(){
	#$name = "Testservice";
	#$formurl = "http://localhost/testservice/index.php";
}

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

	$login = "$id_firstname$id_lastname";
	$login =~ s/\ //g;
	$login = lc($login);

	$id_street = undef;
	$id_zipcode = undef;
	$id_city = undef;
	$id_email = undef;
	$id_title = undef;
	$id_prefix = undef;
	$id_phone = undef;
	$id_birthday = undef;
	$id_birthmonth = undef;
	$id_birthyear = undef;
}

#$ mech-dump http://localhost/testservice/index.php
#POST http://localhost/testservice/index.php?signup=true
#  namefield=                     (text)
#  passfield=                     (text)
#  <NONAME>=Submit                (submit)

sub signup{
	use WWW::Mechanize;

	#print "##FORMURL:$formurl\n##";

	my $mech = WWW::Mechanize->new(agent => "OSST/0.1");
	$mech->get($formurl);
	$mech->submit_form(
		form_number => 1,
		fields => {"namefield" => $login,
			"passfield" => $password}
	);
}

1;
