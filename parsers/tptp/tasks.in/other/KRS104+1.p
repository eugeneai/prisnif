%------------------------------------------------------------------------------
% File     : KRS104+1 : TPTP v5.4.0. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : DL Test: fact1.1
% Version  : Especial.
% English  : If a, b and c are disjoint, then:
%                (a and b) or (b and c) or (c and a)
%            is unsatisfiable.

% Refs     : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : inconsistent_description-logic-Manifest601 [Bec03]

% Status   : Unsatisfiable
% Rating   : 0.00 v3.1.0
% Syntax   : Number of formulae    :   24 (   1 unit)
%            Number of atoms       :   53 (   0 equality)
%            Maximal formula depth :    5 (   4 average)
%            Number of connectives :   38 (   9 ~  ;   0  |;   7  &)
%                                         (  20 <=>;   2 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :   26 (   0 propositional; 1-2 arity)
%            Number of functors    :    1 (   1 constant; 0-0 arity)
%            Number of variables   :   37 (   0 singleton;  23 !;  14 ?)
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

%----Equality cUnsatisfiable
fof(axiom_2,axiom,
    ( ! [X] :
        ( cUnsatisfiable(X)
      <=> ~ ( ? [Y] : ra_Px5(X,Y) ) ) )).

%----Equality cUnsatisfiablexcomp
fof(axiom_3,axiom,
    ( ! [X] :
        ( cUnsatisfiablexcomp(X)
      <=> ( ca_Cx7(X)
          & ca_Cx8(X)
          & ca_Cx6(X) ) ) )).

%----Equality cUnsatisfiablexcomp
fof(axiom_4,axiom,
    ( ! [X] :
        ( cUnsatisfiablexcomp(X)
      <=> ? [Y0] : ra_Px5(X,Y0) ) )).

%----Super ca
fof(axiom_5,axiom,
    ( ! [X] :
        ( ca(X)
       => ca_Cx1(X) ) )).

%----Equality cb
fof(axiom_6,axiom,
    ( ! [X] :
        ( cb(X)
      <=> ? [Y0] : ra_Px3(X,Y0) ) )).

%----Super cb
fof(axiom_7,axiom,
    ( ! [X] :
        ( cb(X)
       => ccxcomp(X) ) )).

%----Equality cbxcomp
fof(axiom_8,axiom,
    ( ! [X] :
        ( cbxcomp(X)
      <=> ~ ( ? [Y] : ra_Px3(X,Y) ) ) )).

%----Equality cc
fof(axiom_9,axiom,
    ( ! [X] :
        ( cc(X)
      <=> ? [Y0] : ra_Px2(X,Y0) ) )).

%----Equality ccxcomp
fof(axiom_10,axiom,
    ( ! [X] :
        ( ccxcomp(X)
      <=> ~ ( ? [Y] : ra_Px2(X,Y) ) ) )).

%----Equality ca_Cx1
fof(axiom_11,axiom,
    ( ! [X] :
        ( ca_Cx1(X)
      <=> ( cbxcomp(X)
          & ccxcomp(X) ) ) )).

%----Equality ca_Cx1
fof(axiom_12,axiom,
    ( ! [X] :
        ( ca_Cx1(X)
      <=> ? [Y0] : ra_Px1(X,Y0) ) )).

%----Equality ca_Cx1xcomp
fof(axiom_13,axiom,
    ( ! [X] :
        ( ca_Cx1xcomp(X)
      <=> ~ ( ? [Y] : ra_Px1(X,Y) ) ) )).

%----Equality ca_Cx6
fof(axiom_14,axiom,
    ( ! [X] :
        ( ca_Cx6(X)
      <=> ~ ( ? [Y] : ra_Px6(X,Y) ) ) )).

%----Equality ca_Cx6xcomp
fof(axiom_15,axiom,
    ( ! [X] :
        ( ca_Cx6xcomp(X)
      <=> ( ca(X)
          & cb(X) ) ) )).

%----Equality ca_Cx6xcomp
fof(axiom_16,axiom,
    ( ! [X] :
        ( ca_Cx6xcomp(X)
      <=> ? [Y0] : ra_Px6(X,Y0) ) )).

%----Equality ca_Cx7
fof(axiom_17,axiom,
    ( ! [X] :
        ( ca_Cx7(X)
      <=> ? [Y0] : ra_Px7(X,Y0) ) )).

%----Equality ca_Cx7xcomp
fof(axiom_18,axiom,
    ( ! [X] :
        ( ca_Cx7xcomp(X)
      <=> ( cc(X)
          & ca(X) ) ) )).

%----Equality ca_Cx7xcomp
fof(axiom_19,axiom,
    ( ! [X] :
        ( ca_Cx7xcomp(X)
      <=> ~ ( ? [Y] : ra_Px7(X,Y) ) ) )).

%----Equality ca_Cx8
fof(axiom_20,axiom,
    ( ! [X] :
        ( ca_Cx8(X)
      <=> ~ ( ? [Y] : ra_Px8(X,Y) ) ) )).

%----Equality ca_Cx8xcomp
fof(axiom_21,axiom,
    ( ! [X] :
        ( ca_Cx8xcomp(X)
      <=> ? [Y0] : ra_Px8(X,Y0) ) )).

%----Equality ca_Cx8xcomp
fof(axiom_22,axiom,
    ( ! [X] :
        ( ca_Cx8xcomp(X)
      <=> ( cc(X)
          & cb(X) ) ) )).

%----i2003_11_14_17_20_50869
fof(axiom_23,axiom,
    ( cUnsatisfiable(i2003_11_14_17_20_50869) )).

%------------------------------------------------------------------------------
