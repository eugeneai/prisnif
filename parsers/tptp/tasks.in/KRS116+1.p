%------------------------------------------------------------------------------
% File     : KRS116+1 : TPTP v5.4.0. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : DL Test: t4.1 Dynamic blocking example
% Version  : Especial.
% English  :

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : inconsistent_description-logic-Manifest623 [Bec03]

% Status   : Unsatisfiable
% Rating   : 0.00 v3.1.0
% Syntax   : Number of formulae    :   18 (   1 unit)
%            Number of atoms       :   54 (   0 equality)
%            Maximal formula depth :   10 (   5 average)
%            Number of connectives :   39 (   3 ~  ;   0  |;  12  &)
%                                         (  13 <=>;  11 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :   21 (   0 propositional; 1-2 arity)
%            Number of functors    :    1 (   1 constant; 0-0 arity)
%            Number of variables   :   37 (   0 singleton;  30 !;   7 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_UNS_RFO_NEQ

% Comments : Sean Bechhofer says there are some errors in the encoding of
%            datatypes, so this problem may not be perfect. At least it's
%            still representative of the type of reasoning required for OWL.
%------------------------------------------------------------------------------
%----Thing and Nothing
fof(axiom_0,axiom,
    ( ! [X] :
        ( cowlThing(X)
        & ~ cowlNothing(X) ) )).

%----String and Integer disjoint
fof(axiom_1,axiom,
    ( ! [X] :
        ( xsd_string(X)
      <=> ~ xsd_integer(X) ) )).

%----Super cUnsatisfiable
fof(axiom_2,axiom,
    ( ! [X] :
        ( cUnsatisfiable(X)
       => ca(X) ) )).

%----Super cUnsatisfiable
fof(axiom_3,axiom,
    ( ! [X] :
        ( cUnsatisfiable(X)
       => ? [Y] :
            ( rs(X,Y)
            & ca_Ax2(Y) ) ) )).

%----Equality ca
fof(axiom_4,axiom,
    ( ! [X] :
        ( ca(X)
      <=> ~ ( ? [Y] : ra_Px1(X,Y) ) ) )).

%----Equality caxcomp
fof(axiom_5,axiom,
    ( ! [X] :
        ( caxcomp(X)
      <=> ? [Y0] : ra_Px1(X,Y0) ) )).

%----Equality cc
fof(axiom_6,axiom,
    ( ! [X] :
        ( cc(X)
      <=> ! [Y] :
            ( rinvR(X,Y)
           => ca_Vx7(Y) ) ) )).

%----Equality ca_Ax2
fof(axiom_7,axiom,
    ( ! [X] :
        ( ca_Ax2(X)
      <=> ( ! [Y] :
              ( rp(X,Y)
             => ca_Vx3(Y) )
          & ! [Y] :
              ( rp(X,Y)
             => ca_Vx5(Y) )
          & ! [Y] :
              ( rr(X,Y)
             => cc(Y) )
          & ? [Y] :
              ( rr(X,Y)
              & cowlThing(Y) )
          & ? [Y] :
              ( rp(X,Y)
              & cowlThing(Y) )
          & ! [Y] :
              ( rp(X,Y)
             => ca_Vx4(Y) ) ) ) )).

%----Equality ca_Vx3
fof(axiom_8,axiom,
    ( ! [X] :
        ( ca_Vx3(X)
      <=> ? [Y] :
            ( rr(X,Y)
            & cowlThing(Y) ) ) )).

%----Equality ca_Vx4
fof(axiom_9,axiom,
    ( ! [X] :
        ( ca_Vx4(X)
      <=> ? [Y] :
            ( rp(X,Y)
            & cowlThing(Y) ) ) )).

%----Equality ca_Vx5
fof(axiom_10,axiom,
    ( ! [X] :
        ( ca_Vx5(X)
      <=> ! [Y] :
            ( rr(X,Y)
           => cc(Y) ) ) )).

%----Equality ca_Vx6
fof(axiom_11,axiom,
    ( ! [X] :
        ( ca_Vx6(X)
      <=> ! [Y] :
            ( rinvS(X,Y)
           => caxcomp(Y) ) ) )).

%----Equality ca_Vx7
fof(axiom_12,axiom,
    ( ! [X] :
        ( ca_Vx7(X)
      <=> ! [Y] :
            ( rinvP(X,Y)
           => ca_Vx6(Y) ) ) )).

%----Inverse: rinvP
fof(axiom_13,axiom,
    ( ! [X,Y] :
        ( rinvP(X,Y)
      <=> rp(Y,X) ) )).

%----Inverse: rinvR
fof(axiom_14,axiom,
    ( ! [X,Y] :
        ( rinvR(X,Y)
      <=> rr(Y,X) ) )).

%----Inverse: rinvS
fof(axiom_15,axiom,
    ( ! [X,Y] :
        ( rinvS(X,Y)
      <=> rs(Y,X) ) )).

%----Transitive: rp
fof(axiom_16,axiom,
    ( ! [X,Y,Z] :
        ( ( rp(X,Y)
          & rp(Y,Z) )
       => rp(X,Z) ) )).

%----i2003_11_14_17_21_33997
fof(axiom_17,axiom,
    ( cUnsatisfiable(i2003_11_14_17_21_33997) )).

%------------------------------------------------------------------------------
