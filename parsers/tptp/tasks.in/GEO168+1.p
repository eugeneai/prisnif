%------------------------------------------------------------------------------
% File     : GEO168+1 : TPTP v5.4.0. Released v3.2.0.
% Domain   : Geometry
% Problem  : Pappus2 implies Pappus1
% Version  : Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : p2p1 [Bez05]

% Status   : Theorem
% Rating   : 0.96 v5.2.0, 1.00 v4.0.1, 0.95 v4.0.0, 1.00 v3.3.0, 0.89 v3.2.0
% Syntax   : Number of formulae    :   27 (   1 unit)
%            Number of atoms       :   77 (   0 equality)
%            Maximal formula depth :   26 (   5 average)
%            Number of connectives :   50 (   0 ~  ;   4  |;  24  &)
%                                         (   0 <=>;  22 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    5 (   1 propositional; 0-4 arity)
%            Number of functors    :   17 (  17 constant; 0-0 arity)
%            Number of variables   :   62 (   1 singleton;  59 !;   3 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(assumption1,axiom,
    ( colinear(a,b,c,l)
    & colinear(d,e,f,m) )).

fof(assumption2,axiom,
    ( colinear(b,f,g,n)
    & colinear(c,e,g,o) )).

fof(assumption3,axiom,
    ( colinear(b,d,h,p)
    & colinear(a,e,h,q) )).

fof(assumption4,axiom,
    ( colinear(c,d,i,r)
    & colinear(a,f,i,s) )).

fof(goalam,axiom,
    ( incident(a,m)
   => goal )).

fof(goalbm,axiom,
    ( incident(b,m)
   => goal )).

fof(goalcm,axiom,
    ( incident(c,m)
   => goal )).

fof(goaldl,axiom,
    ( incident(d,l)
   => goal )).

fof(goalel,axiom,
    ( incident(e,l)
   => goal )).

fof(goalfl,axiom,
    ( incident(f,l)
   => goal )).

fof(goal4,axiom,(
    ! [A] :
      ( ( incident(g,A)
        & incident(h,A)
        & incident(i,A) )
     => goal ) )).

fof(colinearity_elimination1,axiom,(
    ! [A,B,C,D] :
      ( colinear(A,B,C,D)
     => incident(A,D) ) )).

fof(colinearity_elimination2,axiom,(
    ! [A,B,C,D] :
      ( colinear(A,B,C,D)
     => incident(B,D) ) )).

fof(colinearity_elimination3,axiom,(
    ! [A,B,C,D] :
      ( colinear(A,B,C,D)
     => incident(C,D) ) )).

fof(reflexivity_of_point_equal,axiom,(
    ! [A,B] :
      ( incident(A,B)
     => point_equal(A,A) ) )).

fof(symmetry_of_point_equal,axiom,(
    ! [A,B] :
      ( point_equal(A,B)
     => point_equal(B,A) ) )).

fof(transitivity_of_point_equal,axiom,(
    ! [A,B,C] :
      ( ( point_equal(A,B)
        & point_equal(B,C) )
     => point_equal(A,C) ) )).

fof(reflexivity_of_line_equal,axiom,(
    ! [A,B] :
      ( incident(A,B)
     => line_equal(B,B) ) )).

fof(symmetry_of_line_equal,axiom,(
    ! [A,B] :
      ( line_equal(A,B)
     => line_equal(B,A) ) )).

fof(transitivity_of_line_equal,axiom,(
    ! [A,B,C] :
      ( ( line_equal(A,B)
        & line_equal(B,C) )
     => line_equal(A,C) ) )).

fof(pcon,axiom,(
    ! [A,B,C] :
      ( ( point_equal(A,B)
        & incident(B,C) )
     => incident(A,C) ) )).

fof(lcon,axiom,(
    ! [A,B,C] :
      ( ( incident(A,B)
        & line_equal(B,C) )
     => incident(A,C) ) )).

fof(pappus1,axiom,(
    ! [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q] :
      ( ( colinear(A,B,C,J)
        & colinear(D,E,F,K)
        & colinear(B,F,G,L)
        & colinear(C,E,G,M)
        & colinear(B,D,H,N)
        & colinear(A,E,H,O)
        & colinear(C,D,I,P)
        & colinear(A,F,I,Q) )
     => ( ? [R] : colinear(G,H,I,R)
        | line_equal(L,M)
        | line_equal(N,O)
        | line_equal(P,Q) ) ) )).

fof(unique,axiom,(
    ! [A,B,C,D] :
      ( ( incident(C,A)
        & incident(C,B)
        & incident(D,A)
        & incident(D,B) )
     => ( point_equal(C,D)
        | line_equal(A,B) ) ) )).

fof(line,axiom,(
    ! [A,B] :
      ( ( point_equal(A,A)
        & point_equal(B,B) )
     => ? [C] :
          ( incident(A,C)
          & incident(B,C) ) ) )).

fof(point,axiom,(
    ! [A,B,C] :
      ( ( line_equal(C,C)
        & line_equal(B,B) )
     => ? [A] :
          ( incident(A,B)
          & incident(A,C) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).

%------------------------------------------------------------------------------
