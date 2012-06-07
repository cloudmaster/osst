package Service;

use strict;

sub new{
	my $class = shift;
	my $self = {
		name => "",
		iri => "",
		agentdescription => "",
		formurl => ""
	};
	bless($self, $class);
	return $self;
}

sub load{
	my $file = shift;

	my $srv = Service->new;

	open(F, $file) or die "Error: Service file '$file' cannot be loaded.\n";
	while(<F>){
		chomp;
		my ($key, $value) = split("=", $_);
		#print "## $key = $value\n";
		if($key eq "iri"){
			$srv->{iri} = $value;
		}elsif($key eq "name"){
			$srv->{name} = $value;
		}elsif($key eq "formurl"){
			$srv->{formurl} = $value;
		#}else{
		#	$srv->{properties}->{$key} = $value;
		}
	}
	close(F);

	return $srv;
}

1;
