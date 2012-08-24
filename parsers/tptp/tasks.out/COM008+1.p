%------------------------------------------------------------------------------
% File     : COM008+1 : TPTP v5.4.0. Released v3.2.0.
% Domain   : Computing Theory
% Problem  : Induction step in Newman's Lemma
% Version  : Especial > Reduced > Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : nl [Bez05]

% Status   : Theorem
% Rating   : 0.62 v5.4.0, 0.61 v5.3.0, 0.70 v5.2.0, 0.43 v5.0.0, 0.60 v4.1.0, 0.61 v4.0.1, 0.58 v4.0.0, 0.60 v3.7.0, 0.00 v3.5.0, 0.25 v3.4.0, 0.58 v3.3.0, 0.67 v3.2.0

% Syntax   : Number of formulae    :   11 (   2 unit)
%            Number of atoms       :   29 (   0 equality)
%            Maximal formula depth :    7 (   4 average)
%            Number of connectives :   18 (   0 ~  ;   1  |;   9  &)
%                                         (   0 <=>;   8 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    4 (   1 propositional; 0-2 arity)
%            Number of functors    :    3 (   3 constant; 0-0 arity)
%            Number of variables   :   22 (   0 singleton;  19 !;   3 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(found,axiom,(
    ! [A] :
      ( ( transitive_reflexive_rewrite(b,A)
        & transitive_reflexive_rewrite(c,A) )
     => goal ) )).

fof(assumption,axiom,
    ( transitive_reflexive_rewrite(a,b)
    & transitive_reflexive_rewrite(a,c) )).

fof(reflexivity,axiom,(
    ! [A] : equalish(A,A) )).

fof(symmetry,axiom,(
    ! [A,B] :
      ( equalish(A,B)
     => equalish(B,A) ) )).

fof(equality_in_transitive_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( equalish(A,B)
     => transitive_reflexive_rewrite(A,B) ) )).

fof(rewrite_in_transitive_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( rewrite(A,B)
     => transitive_reflexive_rewrite(A,B) ) )).

fof(transitivity_of_transitive_reflexive_rewrite,axiom,(
    ! [A,B,C] :
      ( ( transitive_reflexive_rewrite(A,B)
        & transitive_reflexive_rewrite(B,C) )
     => transitive_reflexive_rewrite(A,C) ) )).

fof(lo_cfl,axiom,(
    ! [A,B,C] :
      ( ( rewrite(A,B)
        & rewrite(A,C) )
     => ? [D] :
          ( transitive_reflexive_rewrite(B,D)
          & transitive_reflexive_rewrite(C,D) ) ) )).

fof(ih_cfl,axiom,(
    ! [A,B,C] :
      ( ( rewrite(a,A)
        & transitive_reflexive_rewrite(A,B)
        & transitive_reflexive_rewrite(A,C) )
     => ? [D] :
          ( transitive_reflexive_rewrite(B,D)
          & transitive_reflexive_rewrite(C,D) ) ) )).

fof(equalish_or_rewrite,axiom,(
    ! [A,B] :
      ( transitive_reflexive_rewrite(A,B)
     => ( equalish(A,B)
        | ? [C] :
            ( rewrite(A,C)
            & transitive_reflexive_rewrite(C,B) ) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).

%------------------------------------------------------------------------------
