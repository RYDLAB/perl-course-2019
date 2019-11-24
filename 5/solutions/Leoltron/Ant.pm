package Ant;

use strict;
use warnings;

sub new {
    my $type = shift;
    my $self = {
        field => shift,
        x     => shift,
        y     => shift,
        dx    => shift,
        dy    => shift,
    };

    return bless $self, $type;
}

sub travel {
    my ($self, $step_count) = @_;

    for (0 .. $step_count - 1) {
        $self->step();
    }
}

sub step {
    my $self = shift;
    $self->turn();
    $self->invert_current_cell();
    $self->go_forward();
}

sub invert_current_cell {
    my $self = shift;
    $self->{field}->[$self->{y}][$self->{x}] *= -1;
}

sub go_forward {
    my $self = shift;
    my $field_size = $self->get_field_size();

    $self->{x} = ($self->{x} + $self->{dx} + $field_size) % $field_size;
    $self->{y} = ($self->{y} + $self->{dy} + $field_size) % $field_size;
}

sub get_field_size {
    return scalar @{shift->{field}};
}

sub turn {
    my $self = shift;

    $self->current_cell() == 1 ? $self->turn_left() : $self->turn_right();
}

sub current_cell {
    my $self = shift;

    return $self->{field}->[$self->{y}][$self->{x}];
}

sub turn_left {
    my $self = shift;

    ($self->{dx}, $self->{dy}) = (-$self->{dy}, $self->{dx})
}

sub turn_right {
    my $self = shift;

    ($self->{dx}, $self->{dy}) = ($self->{dy}, -$self->{dx})
}

1;
