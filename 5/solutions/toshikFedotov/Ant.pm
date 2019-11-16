# OO-realization for Langton's ant 

package Ant;

use strict;
use warnings;
use v5.10;

use constant {
    LEFT => -1, 
    RIGHT => 1,
};


sub new {
    my ( $type, %params ) = @_; 
    my $self = {
        pos_x => $params{pos_x},
        pos_y => $params{pos_y},
        dir_x => $params{dir_x},
        dir_y => $params{dir_y},
    };
    bless $self, $type;
}

sub turn { 
    my ($self, $dir) = @_;
    our %ant; *ant = $self;
    
    ( $ant{dir_x}, $ant{dir_y} ) = ( $dir == LEFT ) ? ( -$ant{dir_y}, $ant{dir_x} ) : ( $ant{dir_y}, -$ant{dir_x} );
}

sub step_forward {
    my ($self, $field_size) = @_;
    our %ant; *ant = $self;
    
    $ant{pos_x} = ( $ant{pos_x} + $ant{dir_x} + $field_size ) % $field_size;
    $ant{pos_y} = ( $ant{pos_y} + $ant{dir_y} + $field_size ) % $field_size;
}

sub travel {
    my ($self, $field, $steps) = @_;
    for ( 1 .. $steps ) {
        if ( $field->[ $self->{pos_x} ][ $self->{pos_y} ] == 1 ) {
            $self->turn(RIGHT); 
            $field->[ $self->{pos_x} ][ $self->{pos_y} ] = -1;
            $self->step_forward(scalar @$field);
        }
        else {
            $self->turn(LEFT);
            $field->[ $self->{pos_x} ][ $self->{pos_y} ] = 1;
            $self->step_forward(scalar @$field);
        }
    }
}

1
