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

    @{$self}{qw( pos_x pos_y dir_x dir_y )} = ($pos_x, $pos_y, $dir_x, $dir_y);

    my $field_size = @$field;

    for( 1 .. $steps ) {
        my $cell = \$field->[$self->{'pos_x'}][$self->{'pos_y'}];
        $self->turn( $$cell );
        $self->step_forward( $field_size );
        $$cell = -$$cell;
    }

    return $self
}

sub step_forward {
    my ( $self, $field_size )  = @_;

    my ( $px, $py, $dx, $dy ) = \@{$self}{qw( pos_x pos_y dir_x dir_y )};

    $$px = ($$px + $$dx) % $field_size;
    $$py = ($$py + $$dy) % $field_size;
    
    return $self
}

sub turn {
    my ( $self, $turn_direction ) = @_;

    my ( $dx, $dy ) = \@{$self}{'dir_x', 'dir_y'};

    ( $$dx, $$dy ) = ( -$$dy,  $$dx ) if $turn_direction == TURN_LEFT;
    ( $$dx, $$dy ) = (  $$dy, -$$dx ) if $turn_direction == TURN_RIGHT;

    return $self
}

1
