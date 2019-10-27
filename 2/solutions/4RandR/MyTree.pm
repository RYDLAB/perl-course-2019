package MyTree;

use strict;
use warnings;
use v5.10;
use Data::Dumper;

use Exporter;

use parent qw( Exporter );
our @EXPORT_OK = qw ( tree_size tree_size_i tree );

=encoding utf8

=head1 MyTree

Для решения потребуются файловые тесты: perldoc -f -X

Функции:

    opendir

    readdir

Для отладки будет полезен модуль Data::Dumper.

Встроенные модули для обхода древа каталогов использовать нельзя.

=cut

=head2 tree_size()

Возвращает суммарный размер файлов (в байтах) в заданном каталоге. (B<Рекурсивная версия>)

    my $size = tree_size( '~/foo' );

=cut

sub tree_size {
    my $path = shift;
    my $size = 0;

    return -s $path if -f $path;

    opendir ( my $current_dir, $path );

    for (readdir $current_dir) {

        next if $_ eq '.' || $_ eq '..';
        $size += tree_size( "$path/$_" );
    }

    $size;
}

=head2 tree_size_i()

Возвращает суммарный размер файлов (в байтах) в заданном каталоге. (B<Итеративная версия, необязательное задание>)

    my $size = tree_size( '~/foo' );

=cut

sub tree_size_i {
    my $size = 0;
    my $path;

    while ( @_ ) {
        $path = shift;

        if ( -f $path ) { $size += -s $path; }
        else {
            opendir ( my $current_dir, $path );

            for (readdir $current_dir) {
                next if $_ eq '.' || $_ eq '..';
                push @_, "$path/$_";
            }
        } 
    }

    $size;

}

=head2 tree()

Возвращает анонимный хэш с древом каталогов. Если передано имя файла - вернёт его размер. (B<Рекурсивная>)

Примеры использования:

    my $size = tree( './foo.txt' );


    my $tree = tree( './a' );

Если содержимое каталога './a' равно a/b/foo.txt, где foo.txt имеет размер 4 байта:

    {
        b => { 'foo.txt' => 4 },
    }

=cut

sub tree {
    my $path = shift;
    my $tree = {};

    return -s $path if -f $path;

    opendir ( my $current_dir, $path );

    for (readdir $current_dir) {
        next if $_ eq '.' || $_ eq '..';
        $tree -> { $_ } = tree( "$path/$_" );
    }

    $tree;
}

1
