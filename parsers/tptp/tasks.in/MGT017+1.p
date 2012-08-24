%--------------------------------------------------------------------------
% File     : MGT017+1 : TPTP v5.4.0. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Length of reoganisation proportional to organization size
% Version  : [PB+94] axioms.
% English  : The length of reorganizational period grows by the size the
%            organization begins reorganization (if the bigger organization
%            survives it).

% Refs     : [PB+94] Peli et al. (1994), A Logical Approach to Formalizing
%          : [Kam94] Kamps (1994), Email to G. Sutcliffe
%          : [Kam95] Kamps (1995), Email to G. Sutcliffe
% Source   : [Kam94]
% Names    :

% Status   : Theorem
% Rating   : 0.12 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0, 0.00 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    4 (   0 unit)
%            Number of atoms       :   38 (   0 equality)
%            Maximal formula depth :   22 (  17 average)
%            Number of connectives :   34 (   0 ~  ;   0  |;  30  &)
%                                         (   0 <=>;   4 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    7 (   0 propositional; 2-3 arity)
%            Number of functors    :    0 (   0 constant; --- arity)
%            Number of variables   :   30 (   0 singleton;  29 !;   1 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_NEQ

% Comments : "Not published due to publication constraints." [Kam95].
%--------------------------------------------------------------------------
fof(mp5,axiom,
    ( ! [X,T] :
        ( organization(X,T)
       => ? [I] : inertia(X,I,T) ) )).

%----The level of structural inertia increases with size for each class
%----of organizations.
fof(a5_FOL,hypothesis,
    ( ! [X,Y,C,S1,S2,I1,I2,T1,T2] :
        ( ( organization(X,T1)
          & organization(Y,T2)
          & class(X,C,T1)
          & class(Y,C,T2)
          & size(X,S1,T1)
          & size(Y,S2,T2)
          & inertia(X,I1,T1)
          & inertia(Y,I2,T2)
          & greater(S2,S1) )
       => greater(I2,I1) ) )).

%----The length of reorganizational period grows by the inertia the
%----organization begin s reorganization (if the organization with
%----higher inertia survives it).
fof(a13_FOL,hypothesis,
    ( ! [X,Y,Rt,C,I1,I2,Ta,Tb,Tc] :
        ( ( organization(X,Ta)
          & organization(Y,Ta)
          & organization(Y,Tc)
          & class(X,C,Ta)
          & class(Y,C,Ta)
          & reorganization(X,Ta,Tb)
          & reorganization(Y,Ta,Tc)
          & reorganization_type(X,Rt,Ta)
          & reorganization_type(Y,Rt,Ta)
          & inertia(X,I1,Ta)
          & inertia(Y,I2,Ta)
          & greater(I2,I1) )
       => greater(Tc,Tb) ) )).

fof(t17_FOL,conjecture,
    ( ! [X,Y,Rt,C,S1,S2,Ta,Tb,Tc] :
        ( ( organization(X,Ta)
          & organization(Y,Ta)
          & organization(Y,Tc)
          & class(X,C,Ta)
          & class(Y,C,Ta)
          & reorganization(X,Ta,Tb)
          & reorganization(Y,Ta,Tc)
          & reorganization_type(X,Rt,Ta)
          & reorganization_type(Y,Rt,Ta)
          & size(X,S1,Ta)
          & size(Y,S2,Ta)
          & greater(S2,S1) )
       => greater(Tc,Tb) ) )).

%--------------------------------------------------------------------------
