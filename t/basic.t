use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::Cwd';
use SPVM 'Cwd';

use Cwd 'getcwd';

# getcwd
{
  my $expected_cur_dir = getcwd;
  ok(SPVM::TestCase::Cwd->getcwd($expected_cur_dir));
}

# getdcwd
if ($^O eq 'MSWin32') {
  my $cur_dir = Cwd::getdcwd();
  ok(SPVM::TestCase::Cwd->getdcwd($cur_dir));
}

# realpath, abs_path
{
  {
    my $path = 't/basic.t';
    my $realpath = SPVM::Cwd->realpath($path);
    my $perl_realpath = Cwd::realpath($path);
    warn $realpath;
    is($realpath, $perl_realpath);
  }
  {
    my $path = 't/lib/../basic.t';
    my $realpath = SPVM::Cwd->realpath($path);
    my $perl_realpath = Cwd::realpath($path);
    warn $realpath;
    is($realpath, $perl_realpath);
  }
}

# abs_path
{
  {
    my $path = 't/basic.t';
    my $abs_path = SPVM::Cwd->abs_path($path);
    my $realpath = SPVM::Cwd->realpath($path);
    is($abs_path, $realpath);
  }
}

done_testing;
