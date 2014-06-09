use v5.18.2;
package dog;

sub sleep() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is dog, he is sleeping\n");
}

sub bark() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is dog, he is barking\n");
}

return 1;