package Ant;

use Data::Dumper;
use strict;
use warnings;

use Exporter;
use parent qw( Exporter );

our @EXPORT_OK = qw(
    travel
    step_forward
    turn
    TURN_LEFT
    TURN_RIGHT
);

=encoding utf8
=head1 Ant
Реализация муравья Лэнгтона.
=cut

use constant {
    TURN_LEFT  => -1,
    TURN_RIGHT => 1,
};

=head2 travel()
Осуществляет передвижение муравья по полю
    travel( \@field, $pos_x, $pos_y, $steps, $dir_x, $dir_y );
@field - массив массивов (см. perldoc L<perllol>) с числами, где -1 - чёрная клетка, а 1 - белая. Пример:
    @field = (
        [ -1, -1, -1 ],
        [ -1,  1, -1 ],
        [ -1, -1, -1 ],
    );
$pos_x/$pos_y - стартовые координаты муравья
$steps        - количество шагов которое сделает муравей
$dir_x/$dir_y - направление муравья. Пример:
    my ( $dir_x, $dir_y ) = ( -1, 0 );
=cut

sub travel {
    my ( $field, $pos_x, $pos_y, $steps, $dir_x, $dir_y ) = @_;
    my $field_size = @$field;

    foreach (0..$steps) {
        if ($field -> [$pos_x][$pos_y] == -1 ) {
            ($dir_x, $dir_y) = turn($dir_x, $dir_y, TURN_LEFT);
            $field -> [$pos_x][$pos_y] = 1;
            ($pos_x, $pos_y) = step_forward( $pos_x, $pos_y, $field_size, $dir_x, $dir_y );
        }
        if ( $field -> [$pos_x][$pos_y] == 1 ) {
            ($dir_x, $dir_y) = turn($dir_x, $dir_y, TURN_RIGHT);
            $field -> [$pos_x][$pos_y] = -1;
            ($pos_x, $pos_y) = step_forward( $pos_x, $pos_y, $field_size, $dir_x, $dir_y );
        }
    }
}

=head2 step_forward()
Производит шаг в заданном направлении, возвращает новые координаты муравья.
Поле замкнуто. Например, переходя через левую границу - муравей попадает на правый край.
    my ( $new_x, $new_y ) = step_forward( $pos_x, $pos_y, $field_size, $dir_x, $dir_y );
=cut

sub step_forward {
    my ($pos_x, $pos_y, $field_size, $dir_x, $dir_y) = @_;
    $pos_x += $dir_x;
    $pos_y += $dir_y;

    if ($pos_x >= $field_size) {
        $pos_x = 0;
    }
    if ($pos_y >= $field_size) {
        $pos_y = 0
    }
    return ($pos_x, $pos_y);
}

=head2 turn()
Поворачивает муравья налево или направо.
    my ( $vec_x, $vec_y ) = turn( -1, 0, TURN_LEFT );
=cut

sub turn {
    my ( $dir_x, $dir_y, $turn_side ) = @_;

    if ( $turn_side == TURN_LEFT ) {
        if ( $dir_x == 0 ) {
            $dir_x = -$dir_y;
            $dir_y = 0;
        }
        else {
            $dir_y = $dir_x;
            $dir_x = 0;
        }
    }
    elsif ($turn_side == TURN_RIGHT) {
        if ($dir_x == 0) {
            $dir_x = $dir_y;
            $dir_y = 0;
        }
        else {
            $dir_y = -$dir_x;
            $dir_x = 0;
        }
    }

    return ( $dir_x, $dir_y );
}

1
