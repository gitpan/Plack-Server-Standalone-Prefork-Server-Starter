use inc::Module::Install;

all_from 'lib/Plack/Server/Standalone/Prefork/Server/Starter.pm';
readme_from 'lib/Plack/Server/Standalone/Prefork/Server/Starter.pm';

requires 'Plack' => 0.9920;
requires 'Parallel::Prefork' => 0.07;

requires 'Server::Starter' => 0.06;
test_requires 'Test::More' => 0.88;
test_requires 'Test::TCP'  => 0.15;

WriteAll;
