%------------------------------------------------------------------------------
% File     : GRA022+1 : TPTP v5.4.0. Released v3.2.0.
% Domain   : Graph Theory
% Problem  : 2-colored completed graph size 13 without subgraph of size 5
% Version  : Especial.
% English  : Find a 2-colored completed graph of size 13 without a complete
%            subgraph of size 5 which all the edges have the same color.

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : r5_13 [Bez05]

% Status   : CounterSatisfiable
% Rating   : 0.10 v5.4.0, 0.00 v5.3.0, 0.25 v5.0.0, 0.00 v4.1.0, 0.33 v4.0.1, 0.00 v3.4.0, 0.33 v3.3.0, 0.67 v3.2.0

% Syntax   : Number of formulae    :    7 (   1 unit)
%            Number of atoms       :   44 (   0 equality)
%            Maximal formula depth :   16 (   9 average)
%            Number of connectives :   37 (   0 ~  ;   1  |;  31  &)
%                                         (   0 <=>;   5 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    4 (   1 propositional; 0-2 arity)
%            Number of functors    :   13 (  13 constant; 0-0 arity)
%            Number of variables   :   17 (   0 singleton;  17 !;   0 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_CSA_EPR

% Comments :
%------------------------------------------------------------------------------
fof(ordering,axiom,
    ( less_than(n1,n2)
    & less_than(n2,n3)
    & less_than(n3,n4)
    & less_than(n4,n5)
    & less_than(n5,n6)
    & less_than(n6,n7)
    & less_than(n7,n8)
    & less_than(n8,n9)
    & less_than(n9,n10)
    & less_than(n10,n11)
    & less_than(n11,n12)
    & less_than(n12,n13) )).

fof(red_clique,axiom,(
    ! [A,B,C,D,E] :
      ( ( red(A,B)
        & red(A,C)
        & red(B,C)
        & red(A,D)
        & red(B,D)
        & red(C,D)
        & red(A,E)
        & red(B,E)
        & red(C,E)
        & red(D,E) )
     => goal ) )).

fof(green_clique,axiom,(
    ! [A,B,C,D,E] :
      ( ( green(A,B)
        & green(A,C)
        & green(B,C)
        & green(A,D)
        & green(B,D)
        & green(C,D)
        & green(A,E)
        & green(B,E)
        & green(C,E)
        & green(D,E) )
     => goal ) )).

fof(no_overlap,axiom,(
    ! [A,B] :
      ( ( red(A,B)
        & green(A,B) )
     => goal ) )).

fof(less_than_transitive,axiom,(
    ! [A,B,C] :
      ( ( less_than(A,B)
        & less_than(B,C) )
     => less_than(A,C) ) )).

fof(partition,axiom,(
    ! [A,B] :
      ( less_than(A,B)
     => ( red(A,B)
        | green(A,B) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).
%------------------------------------------------------------------------------