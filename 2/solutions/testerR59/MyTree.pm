package MyTree;

use strict;
use warnings;
use v5.10;

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
    my ($filename) = @_;

    return -s _ if -f $filename;

    my $total_size = 0;
    if(-d $filename && opendir my $dir, $filename) {
        my @files = grep {$_ ne '.' && $_ ne '..'} readdir $dir;
        closedir $dir;
        $total_size += tree_size("$filename/$_") for @files;
    }

    return $total_size;
}

=head2 tree_size_i()

Возвращает суммарный размер файлов (в байтах) в заданном каталоге. (B<Итеративная версия, необязательное задание>)

    my $size = tree_size( '~/foo' );

=cut

sub tree_size_i {
    my @stack = @_;
    my $total_size = 0;

    while(@stack){
        my $filename = pop @stack;
        $total_size += -s _ if -f $filename;
        if(-d $filename && opendir my $dir, $filename){
            my @files = grep {$_ ne '.' && $_ ne '..'} readdir $dir;
            closedir $dir;
            push @stack, map {"$filename/$_"} @files;
        }
    }

    return $total_size;
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
    my ($filename) = @_;

    return -s _ if -f $filename;

    my $tree = {};
    if(-d $filename && opendir my $dir, $filename) {
        my @files = grep {$_ ne '.' && $_ ne '..'} readdir $dir;
        closedir $dir;
        $tree->{$_} = tree("$filename/$_") for @files;
    }

    return $tree;
}

1
