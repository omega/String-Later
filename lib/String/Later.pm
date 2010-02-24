package String::Later;

use Moose;

has 'object' => (is => 'ro', isa => 'Object', weak_ref => 1, required => 1);
has 'method' => (is => 'ro', isa => 'Str|CodeRef', required => 1);

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;
    
    if (scalar(@_) == 2) {
        # short hand we hope :p
        # XXX: Should we also perhaps tweak the method so it is consistant here?
        return $class->$orig(object => $_[0], method => $_[1]);
    } else {
        return $class->$orig(@_);
    }
};

use overload '""' => sub {
    shift->later_string;
    
}, fallback => 1;

sub later_string {
    my $self = shift;
    
    my $meth = $self->method;
    my $obj  = $self->object;
    
    $obj->$meth();
}
1;