# common functionality for tests.
# imported into main for ease of use.
package main;

require v5.14.0;

use Cwd;
use File::Basename;
use File::Copy;
use File::Path;
use File::Spec;
use File::Temp qw(tempdir);

use Test::More    ();

use vars qw($RUNNING_ON_WINDOWS);

my $module_code_dir;
BEGIN {
  require Exporter;
  use vars qw(@ISA @EXPORT @EXPORT_OK);
  @ISA = qw(Exporter);

  $RUNNING_ON_WINDOWS = ($^O =~ /^(mswin|dos|os2)/oi);

  # Clean PATH so taint doesn't complain
  if (!$RUNNING_ON_WINDOWS) {
    $ENV{'PATH'} = '/bin:/usr/bin:/usr/local/bin';
    # Remove tainted envs, at least ENV used in FreeBSD
    delete @ENV{qw(IFS CDPATH ENV BASH_ENV)};
  } else {
    # Windows might need non-system directories in PATH to run a Perl installation
    # The best we can do is clean out obviously bad stuff such as relative paths or \..\
    my @pathdirs = split(';', $ENV{'PATH'});
    $ENV{'PATH'} =
      join(';', # filter for only dirs that are canonical absolute paths that exist
        map {
              my $pathdir = $_;
              $pathdir =~ s/\\*\z//;
              my $abspathdir = File::Spec->canonpath(Cwd::realpath($pathdir)) if (-d $pathdir);
              if (defined $abspathdir) {
                $abspathdir  =~ /^(.*)\z/s;
                $abspathdir = $1; # untaint it
              }
              ((defined $abspathdir) and (lc $pathdir eq lc $abspathdir))?($abspathdir):()
            }
          @pathdirs);
  }
  
  # Fix INC to point to absolute path of built module
  if (-e 't/test_dir') { $module_code_dir = 'blib/lib'; }
  elsif (-e 'test_dir') { $module_code_dir = '../blib/lib'; }
  else { die "FATAL: not in or below test directory?\n"; }
  File::Spec->rel2abs($module_code_dir) =~ /^(.*)\z/s;
  $module_code_dir = $1;
  if (not -d $module_code_dir) {
    die "FATAL: not in expected directory relative to built code tree?\n";
  }
}

# use is run at compile time, but after the variable has been computed in the BEGIN block
use lib $module_code_dir;

sub sa_t_init {
  # everything it needed was in begin blocks
}

1;
