%------------------------------------------------------------------------------
% File     : KRS124+1 : TPTP v5.4.0. Released v3.1.0.
% Domain   : Knowledge Representation (Semantic Web)
% Problem  : DL Test: heinsohn1.2
% Version  : Especial.
% English  : Tbox tests from [HK+94]

% Refs     : [HK+94] Heinsohn et al. (1994), An Empirical Analysis of Termi
%          : [Bec03] Bechhofer (2003), Email to G. Sutcliffe
%          : [TR+04] Tsarkov et al. (2004), Using Vampire to Reason with OW
% Source   : [Bec03]
% Names    : inconsistent_description-logic-Manifest642 [Bec03]

% Status   : Unsatisfiable
% Rating   : 0.00 v3.1.0
% Syntax   : Number of formulae    :   14 (   1 unit)
%            Number of atoms       :   31 (   0 equality)
%            Maximal formula depth :    6 (   4 average)
%            Number of connectives :   21 (   4 ~  ;   0  |;   4  &)
%                                         (   7 <=>;   6 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :   17 (   0 propositional; 1-2 arity)
%            Number of functors    :    1 (   1 constant; 0-0 arity)
%            Number of variables   :   19 (   0 singleton;  14 !;   5 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_UNS_RFO_NEQ

% Comments : Sean Bechhofer says there are some errors in the encoding of
%            datatypes, so this problem may not be perfect. At least it's
%            still representative of the type of reasoning required for OWL.
%          : Tests incoherency caused by disjoint concept
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
      <=> ( ? [Y] :
              ( rr(X,Y)
              & cowlThing(Y) )
          & ! [Y] :
              ( rr(X,Y)
             => ca_Ax3(Y) ) ) ) )).

%----Super cc
fof(axiom_3,axiom,
    ( ! [X] :
        ( cc(X)
       => cdxcomp(X) ) )).

%----Super cc1
fof(axiom_4,axiom,
    ( ! [X] :
        ( cc1(X)
       => cd1(X) ) )).

%----Super cc1
fof(axiom_5,axiom,
    ( ! [X] :
        ( cc1(X)
       => cd1xcomp(X) ) )).

%----Equality cd
fof(axiom_6,axiom,
    ( ! [X] :
        ( cd(X)
      <=> ~ ( ? [Y] : ra_Px1(X,Y) ) ) )).

%----Equality cdxcomp
fof(axiom_7,axiom,
    ( ! [X] :
        ( cdxcomp(X)
      <=> ? [Y0] : ra_Px1(X,Y0) ) )).

%----Equality cd1
fof(axiom_8,axiom,
    ( ! [X] :
        ( cd1(X)
      <=> ? [Y0] : ra_Px2(X,Y0) ) )).

%----Equality cd1xcomp
fof(axiom_9,axiom,
    ( ! [X] :
        ( cd1xcomp(X)
      <=> ~ ( ? [Y] : ra_Px2(X,Y) ) ) )).

%----Super ce3
fof(axiom_10,axiom,
    ( ! [X] :
        ( ce3(X)
       => cc(X) ) )).

%----Super cf
fof(axiom_11,axiom,
    ( ! [X] :
        ( cf(X)
       => cd(X) ) )).

%----Equality ca_Ax3
fof(axiom_12,axiom,
    ( ! [X] :
        ( ca_Ax3(X)
      <=> ( cd(X)
          & cc(X) ) ) )).

%----i2003_11_14_17_22_10903
fof(axiom_13,axiom,
    ( cUnsatisfiable(i2003_11_14_17_22_10903) )).

%------------------------------------------------------------------------------
