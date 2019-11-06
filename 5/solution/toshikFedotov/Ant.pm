# OO-realization for Langton's ant 

package Ant;

use strict;
use warnings;
use v5.10;

use Exporter;
use parent qw( Exporter );
our @EXPORT_OK = qw(
    new
    travel
);

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
    my ($self_ref, $dir) = @_;
    our %self; *self = $self_ref;
    
    ( $self{dir_x}, $self{dir_y} ) = ( $dir == LEFT ) ? ( -$self{dir_y}, $self{dir_x} ) : ( $self{dir_y}, -$self{dir_x} );
}

sub step_forward {
    my ($self_ref, $field_size) = @_;
    our %self; *self = $self_ref;
    
    $self{pos_x} = ( $self{pos_x} + $self{dir_x} + $field_size ) % $field_size;
    $self{pos_y} = ( $self{pos_y} + $self{dir_y} + $field_size ) % $field_size;
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
