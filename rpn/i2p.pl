#!/usr/bin/env perl

use strict;
use warnings;

do { print "USAGE: $0 <infix.txt>\n"; exit 0 }
    unless $ARGV[0];

my ($char, @stack);

open my $fh, '<', $ARGV[0] or die $!;
while ( (read $fh, $char, 1) != 0 ) {
    ( $char =~ /\d/ ) ?
        print $char :
        &do_something
}
close $fh; 

print " ", pop @stack while defined $stack[-1];

# реализация алгоритма Дейкстра (только +, -, *, /)
sub do_something {
    if ( not defined $stack[-1] or $char eq '(' ) {
        push @stack, $char
    }
    elsif ( $char eq ')' ) {
        while ($stack[-1] ne '(') {
            print " ", pop @stack; 
        }
        
        pop @stack
    }
    elsif ( $char eq '*' or $char eq '/' ) {
        while ( $stack[-1] eq '*' or $stack[-1] eq '/' ) {
            print " ", pop @stack
        }

        push @stack, $char
    }
    elsif ( $char eq '+' or $char eq '-' ) {
        print " ", pop @stack while (
            defined $stack[-1] and (
            $stack[-1] eq '+' or
            $stack[-1] eq '-' or
            $stack[-1] eq '*' or
            $stack[-1] eq '/'
        ));

        push @stack, $char
    }
}
