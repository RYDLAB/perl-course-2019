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
my ($dir)= @_;

return -s $dir if -f $dir;

opendir($d, $dir) if -d $dir;
my $size = 0;
my @files = readdir($d);

foreach my $file (@files){
if ($file !~ /\./){
$size += tree_size("$dir/$file");
}
}

closedir($d);
return $size;

}

=head2 tree_size_i()

Возвращает суммарный размер файлов (в байтах) в заданном каталоге. (B<Итеративная версия, необязательное задание>)

my $size = tree_size( '~/foo' );

=cut

sub tree_size_i {
...
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
my ($dir) = @_;
my %hash;

return -s $dir if -f $dir;

opendir (DIR, $dir) if (!(-f $dir)) or die "i can`t";

my @files = readdir(DIR);

foreach my $file (@files){
next if $file =~/^\.\.?$/;
$hash{$file} = tree("$dir/$file");
}

closedir(DIR);
return \%hash;
}

1
