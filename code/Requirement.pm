package Requirement;

use strict;

sub new{
	my $class = shift;
	my $self = {
		domain => "",
		properties => {}
	};
	bless($self, $class);
	return $self;
}

sub load{
	my $file = shift;

	my $req = Requirement->new;

	open(F, $file) or die "Error: Requirements file '$file' cannot be loaded.\n";
	while(<F>){
		chomp;
		my ($key, $value) = split("=", $_);
		#print "## $key = $value\n";
		if($key eq "domain"){
			$req->{domain} = $value;
		}else{
			$req->{properties}->{$key} = $value;
		}
	}
	close(F);

	return $req;
}

1;
