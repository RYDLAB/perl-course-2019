package Ant;

use strict;
use warnings;

use constant {
    LEFT  => -1,
    RIGHT => 1,
};

sub new {
    my ($type, %params) = @_;

    my $self = {
	%params{qw/ pos_x pos_y dir_x dir_y /}
    };

    bless $self, $type;
}

sub travel {
    my ( $self, $field, $steps) = @_;

    my $call = \$field->[ $self->{pos_x} ][ $self->{pos_y} ];

    for( 1 .. $steps ) {
        $self->turn($$cell);
	$$cell *= -1;
	$self->step_forward(scalar @$field);
    }

    return $self
}

sub step_forward {
    my ( $self, $field_size )  = @_;

    $self->{'pos_x'} = ($self->{'pos_x'} + $self->{'dir_x'}) % $field_size;
    $self->{'pos_y'} = ($self->{'pos_y'} + $self->{'dir_y'}) % $field_size;
    
    return $self
}

sub turn {
    my ( $self, $dir ) = @_;
    my ( $x, $y ) = \@{$self}{qw/dir_x dir_y /};

    ( $$x, $$y ) = ($dir == LEFT) ? ( -$$y, $$x ) : ( $$y, -$$x);
}

1
