package Plack::Server::Standalone::Prefork::Server::Starter;

use strict;
use warnings;

use Server::Starter ();
use base qw(HTTP::Server::PSGI);

our $VERSION = '0.04';

sub new {
    my ($klass, %args) = @_;
    
    my ($hostport, $fd) = %{Server::Starter::server_ports()};
    if ($hostport =~ /(.*):(\d+)/) {
        $args{host} = $1;
        $args{port} = $2;
    } else {
        $args{port} = $hostport;
    }
    
    $args{max_workers} ||= 10;
    
    my $self = $klass->SUPER::new(%args);
    
    $self->{listen_sock} = IO::Socket::INET->new(
        Proto => 'tcp',
    ) or die "failed to create socket:$!";
    $self->{listen_sock}->fdopen($fd, 'w')
        or die "failed to bind to listening socket:$!";
    
    $self;
}

1;
__END__

=head1 NAME

Plack::Server::Standalone::Prefork::Server::Starter

=head1 SYNOPSIS

  % start_server --port=80 -- plackup -s Standalone::Prefork::Server::Starter

=head1 DESCRIPTION

Plack::Server::Standalone::Prefork::Server::Starter is a wrapper to manage L<PLack::Server::Standalone::Prefork> using L<Server::Starter>.

All parameters of L<Plack::Server::Standalone::Prefork> except "host" and "port" can be passed to this module.

=head1 AUTHOR

Kazuho Oku

=head1 NOTES

If you are looking for a standalone preforking HTTP server, then you should really look at L<Starman>.  However if your all want is a simple HTTP server that runs behind a reverse proxy, this good old module still does what it used to.

=head1 SEE ALSO

L<Starman>
L<Server::Starter>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
