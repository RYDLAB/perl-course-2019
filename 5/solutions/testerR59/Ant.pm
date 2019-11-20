package Ant;

use strict;
use warnings;

use parent qw( Exporter );

use constant {
    TURN_LEFT  => -1,
    TURN_RIGHT => 1,
};

sub create {
    my ($type, %params) = @_;

    my $self = {%params};
    $self->{'name'} //= 'Gary';

    bless($self, $type);
}

sub hello {
    my $self = shift;

    print "Hello, my name is $self->{'name'}.\n";

    return $self
}

sub travel {
    my ( $self, $field, $pos_x, $pos_y, $steps, $dir_x, $dir_y ) = @_;

    $self->{'pos_x'} = $pos_x;
    $self->{'pos_y'} = $pos_y;
    $self->{'dir_x'} = $dir_x;
    $self->{'dir_y'} = $dir_y;

    my $field_size = @$field;

    for( 1 .. $steps ) {
        my $turn_direction = $field->[$self->{'pos_x'}][$self->{'pos_y'}];
        $field->[$self->{'pos_x'}][$self->{'pos_y'}] = -$turn_direction;
        $self->turn( $turn_direction );
        $self->step_forward( $field_size );
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
    my ( $self, $turn_direction ) = @_;

    ($self->{'dir_x'}, $self->{'dir_y'}) = ( -$self->{'dir_y'},  $self->{'dir_x'} ) if $turn_direction == TURN_LEFT;
    ($self->{'dir_x'}, $self->{'dir_y'}) = (  $self->{'dir_y'}, -$self->{'dir_x'} ) if $turn_direction == TURN_RIGHT;

    return $self
}

1
