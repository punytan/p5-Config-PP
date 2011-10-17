use inc::Module::Install;
name 'Config-PP';
all_from 'lib/Config/PP.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More' => 0.98;
auto_set_repository;
auto_include;
WriteAll;
