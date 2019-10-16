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
    my $dir = shift;
    if (-f $dir ) {return -s $dir;}
    elsif(-d $dir) {
        opendir(my $dh, $dir);
        my $sum = 0;
        my @files = readdir($dh);
        foreach my $file (@files) {
            next if $file =~ /^\.\.?$/; # Нашел это выражение для пропуска директорий '.' '..' во внешнем источнике
            $sum += tree_size("$dir/$file");
        }
        return $sum;
    }
}
=head2 tree_size_i()

Возвращает суммарный размер файлов (в байтах) в заданном каталоге. (B<Итеративная версия, необязательное задание>)

    my $size = tree_size( '~/foo' );

=cut

sub tree_size_i {
    

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
    my $dir = shift;
    my %hash;
    if (-f $dir) {
        return -s $dir;
    }
    else {
        opendir(my $dh, $dir) or die "can't opendir $dir";
	    my @files = readdir($dh);
        foreach my $file (@files) {
            next if $file =~ /^\.\.?$/;             # Нашел это выражение для пропуска директорий '.' '..' во внешнем источнике
            $hash{$file} = tree("$dir/$file");
        }
        return \%hash;
    }
}


1
