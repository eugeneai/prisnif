%------------------------------------------------------------------------------
% File     : GEO169+1 : TPTP v5.4.0. Released v3.2.0.
% Domain   : Geometry
% Problem  : Reduction of 8 cases to 2 in Cronheim's proof of Hessenberg
% Version  : Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : cro_8_2 [Bez05]

% Status   : Theorem
% Rating   : 0.11 v5.4.0, 0.22 v5.3.0, 0.36 v5.2.0, 0.25 v5.0.0, 0.00 v4.1.0, 0.33 v4.0.1, 0.37 v4.0.0, 0.30 v3.7.0, 0.67 v3.5.0, 0.38 v3.4.0, 0.25 v3.3.0, 0.11 v3.2.0
% Syntax   : Number of formulae    :   51 (  28 unit)
%            Number of atoms       :   93 (   0 equality)
%            Maximal formula depth :    9 (   2 average)
%            Number of connectives :   42 (   0 ~  ;   4  |;  18  &)
%                                         (   0 <=>;  20 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    4 (   1 propositional; 0-2 arity)
%            Number of functors    :   19 (  19 constant; 0-0 arity)
%            Number of variables   :   27 (   0 singleton;  27 !;   0 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_EPR

% Comments :
%------------------------------------------------------------------------------
fof(goal_normal,axiom,(
    ! [A] :
      ( ( line_equal(A,A)
        & incident(bc,A)
        & incident(ac,A)
        & incident(ab,A) )
     => goal ) )).

fof(t1in2,axiom,
    ( ( incident(a1,b2c2)
      & incident(b1,a2c2)
      & incident(c1,a2b2) )
   => goal )).

fof(t2in1,axiom,
    ( ( incident(a2,b1c1)
      & incident(b2,a1c1)
      & incident(c2,a1b1) )
   => goal )).

fof(gap_a,axiom,
    ( incident(a1,b2c2)
    | incident(b2,a1c1) )).

fof(gap_b,axiom,
    ( incident(b1,a2c2)
    | incident(c2,a1b1) )).

fof(gap_c,axiom,
    ( incident(c1,a2b2)
    | incident(a2,b1c1) )).

fof(ia1b1,axiom,(
    incident(a1,a1b1) )).

fof(ib1a1,axiom,(
    incident(b1,a1b1) )).

fof(ia2b2,axiom,(
    incident(a2,a2b2) )).

fof(ib2a2,axiom,(
    incident(b2,a2b2) )).

fof(ia1c1,axiom,(
    incident(a1,a1c1) )).

fof(ic1a1,axiom,(
    incident(c1,a1c1) )).

fof(ia2c2,axiom,(
    incident(a2,a2c2) )).

fof(ic2a2,axiom,(
    incident(c2,a2c2) )).

fof(ic1b1,axiom,(
    incident(c1,b1c1) )).

fof(ib1c1,axiom,(
    incident(b1,b1c1) )).

fof(ic2b2,axiom,(
    incident(c2,b2c2) )).

fof(ib2c2,axiom,(
    incident(b2,b2c2) )).

fof(iooa,axiom,(
    incident(o,oa) )).

fof(ioob,axiom,(
    incident(o,ob) )).

fof(iooc,axiom,(
    incident(o,oc) )).

fof(ia1oa,axiom,(
    incident(a1,oa) )).

fof(ia2oa,axiom,(
    incident(a2,oa) )).

fof(ib1ob,axiom,(
    incident(b1,ob) )).

fof(ib2ob,axiom,(
    incident(b2,ob) )).

fof(ic1oc,axiom,(
    incident(c1,oc) )).

fof(ic2oc,axiom,(
    incident(c2,oc) )).

fof(ibc1,axiom,(
    incident(bc,b1c1) )).

fof(ibc2,axiom,(
    incident(bc,b2c2) )).

fof(iac1,axiom,(
    incident(ac,a1c1) )).

fof(iac2,axiom,(
    incident(ac,a2c2) )).

fof(iab1,axiom,(
    incident(ab,a1b1) )).

fof(iab2,axiom,(
    incident(ab,a2b2) )).

fof(triangle1,axiom,(
    ! [A] :
      ( ( incident(a1,A)
        & incident(b1,A)
        & incident(c1,A) )
     => goal ) )).

fof(triangle2,axiom,(
    ! [A] :
      ( ( incident(a2,A)
        & incident(b2,A)
        & incident(c2,A) )
     => goal ) )).

fof(notaa,axiom,
    ( point_equal(a2,a1)
   => goal )).

fof(notbb,axiom,
    ( point_equal(b2,b1)
   => goal )).

fof(notcc,axiom,
    ( point_equal(c2,c1)
   => goal )).

fof(notbc,axiom,
    ( line_equal(b1c1,b2c2)
   => goal )).

fof(notac,axiom,
    ( line_equal(a1c1,a2c2)
   => goal )).

fof(notab,axiom,
    ( line_equal(a1b1,a2b2)
   => goal )).

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

fof(unique,axiom,(
    ! [A,B,C,D] :
      ( ( incident(A,C)
        & incident(A,D)
        & incident(B,C)
        & incident(B,D) )
     => ( point_equal(A,B)
        | line_equal(C,D) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).

%------------------------------------------------------------------------------
