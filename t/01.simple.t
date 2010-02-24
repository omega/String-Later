#!/usr/bin/perl -w

use strict;
use Test::More 0.88;
use String::Later;


{
    package MyObject;
    
    use Moose;
    use String::Later;
    
    has 'name' => (is => 'ro', isa => 'Str');
    
    has 'count' => (traits => ['Counter'], is => 'ro', isa => 'Num', default => '0', handles => {inc => 'inc'});
    
    sub attrs {
        my $self = shift;
        return {
            label => String::Later->new($self, 'label'),
        };
    }
    
    sub label {
        my $self = shift;
        return $self->name . " - C: " . $self->count;
    }
}

my $obj = MyObject->new(name => "A");
is($obj->label, "A - C: 0");

my $attr = $obj->attrs;

is($attr->{label}, "A - C: 0");

$obj->inc;

is($attr->{label}, "A - C: 1");


done_testing();