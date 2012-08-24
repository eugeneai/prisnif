%------------------------------------------------------------------------------
% File     : COM007+1 : TPTP v5.4.0. Released v3.2.0.
% Domain   : Computing Theory
% Problem  : Preservation of the Diamond Property under reflexive closure
% Version  : Especial > Reduced > Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : dpe [Bez05]

% Status   : Theorem
% Rating   : 0.12 v5.4.0, 0.13 v5.3.0, 0.17 v5.2.0, 0.07 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.33 v3.5.0, 0.12 v3.4.0, 0.08 v3.3.0, 0.00 v3.2.0

% Syntax   : Number of formulae    :   10 (   2 unit)
%            Number of atoms       :   23 (   0 equality)
%            Maximal formula depth :    7 (   4 average)
%            Number of connectives :   13 (   0 ~  ;   1  |;   5  &)
%                                         (   0 <=>;   7 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    4 (   1 propositional; 0-2 arity)
%            Number of functors    :    3 (   3 constant; 0-0 arity)
%            Number of variables   :   17 (   0 singleton;  16 !;   1 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(assumption,axiom,
    ( reflexive_rewrite(a,b)
    & reflexive_rewrite(a,c) )).

fof(goal_ax,axiom,(
    ! [A] :
      ( ( reflexive_rewrite(b,A)
        & reflexive_rewrite(c,A) )
     => goal ) )).

fof(reflexivity,axiom,(
    ! [A] : equalish(A,A) )).

fof(symmtery,axiom,(
    ! [A,B] :
      ( equalish(A,B)
     => equalish(B,A) ) )).

fof(substitution,axiom,(
    ! [A,B,C] :
      ( ( equalish(A,B)
        & reflexive_rewrite(B,C) )
     => reflexive_rewrite(A,C) ) )).

fof(equalish_in_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( equalish(A,B)
     => reflexive_rewrite(A,B) ) )).

fof(rewrite_in_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( rewrite(A,B)
     => reflexive_rewrite(A,B) ) )).

fof(equalish_or_rewrite,axiom,(
    ! [A,B] :
      ( reflexive_rewrite(A,B)
     => ( equalish(A,B)
        | rewrite(A,B) ) ) )).

fof(rewrite_diamond,axiom,(
    ! [A,B,C] :
      ( ( rewrite(A,B)
        & rewrite(A,C) )
     => ? [D] :
          ( rewrite(B,D)
          & rewrite(C,D) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).

%------------------------------------------------------------------------------
