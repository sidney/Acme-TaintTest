require 5.014000;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'PL_FILES' => {},
  'EXE_FILES' => [],
  'NAME' => 'Acme::TaintTest',
  'VERSION_FROM' => 'lib/Acme/TaintTest.pm',
  'PREREQ_PM' => {
                   'Cwd' => 0,
                   'File::Spec' => 0,
                   'File::Temp' => 0,
                   'Test::More' => 0
                 },
  'INSTALLDIRS' => 'site'
)
;
