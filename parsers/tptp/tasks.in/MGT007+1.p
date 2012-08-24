%--------------------------------------------------------------------------
% File     : MGT007+1 : TPTP v5.4.0. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Reproducibility decreases during reorganization.
% Version  : [PB+94] axioms.
% English  :

% Refs     : [PB+92] Peli et al. (1992), A Logical Approach to Formalizing
%          : [PB+94] Peli et al. (1994), A Logical Approach to Formalizing
%          : [Kam94] Kamps (1994), Email to G. Sutcliffe
% Source   : [Kam94]
% Names    : THEOREM 7 [PB+92]
%          : T7FOL1 [PB+94]

% Status   : Theorem
% Rating   : 0.12 v5.4.0, 0.13 v5.3.0, 0.22 v5.2.0, 0.00 v5.0.0, 0.05 v4.1.0, 0.06 v4.0.1, 0.05 v3.7.0, 0.00 v3.2.0, 0.11 v3.1.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    6 (   0 unit)
%            Number of atoms       :   38 (   0 equality)
%            Maximal formula depth :   21 (  12 average)
%            Number of connectives :   36 (   4 ~  ;   0  |;  25  &)
%                                         (   1 <=>;   6 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    6 (   0 propositional; 2-3 arity)
%            Number of functors    :    0 (   0 constant; --- arity)
%            Number of variables   :   35 (   0 singleton;  32 !;   3 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(mp1,axiom,
    ( ! [X,T] :
        ( organization(X,T)
       => ? [R] : reliability(X,R,T) ) )).

fof(mp2,axiom,
    ( ! [X,T] :
        ( organization(X,T)
       => ? [A] : accountability(X,A,T) ) )).

fof(mp_not_in_TR,axiom,
    ( ! [X,T] :
        ( organization(X,T)
       => ? [A] : reproducibility(X,A,T) ) )).

%----Reliability and accountability require that organizational
%----structures be highly reproducible.
fof(a2_FOL,hypothesis,
    ( ! [X,Y,T1,T2,R1,R2,A1,A2,Rp1,Rp2] :
        ( ( organization(X,T1)
          & organization(Y,T2)
          & reliability(X,R1,T1)
          & reliability(Y,R2,T2)
          & accountability(X,A1,T1)
          & accountability(Y,A2,T2)
          & reproducibility(X,Rp1,T1)
          & reproducibility(Y,Rp2,T2) )
       => ( greater(Rp2,Rp1)
        <=> ( greater(R2,R1)
            & greater(A2,A1) ) ) ) )).

%----The process of attempting reorganization lowers reliability of
%----performance.
fof(a6_FOL,hypothesis,
    ( ! [X,R1,R2,A1,A2,T1,T2,Ta,Tb] :
        ( ( organization(X,T1)
          & organization(X,T2)
          & reorganization(X,Ta,Tb)
          & reliability(X,R1,T1)
          & reliability(X,R2,T2)
          & accountability(X,A1,T1)
          & accountability(X,A2,T2)
          & ~ greater(Ta,T1)
          & greater(T2,T1)
          & ~ greater(T2,Tb) )
       => ( greater(R1,R2)
          & greater(A1,A2) ) ) )).

fof(t7_FOL,conjecture,
    ( ! [X,Rp1,Rp2,T1,T2,Ta,Tb] :
        ( ( organization(X,T1)
          & organization(X,T2)
          & reorganization(X,Ta,Tb)
          & reproducibility(X,Rp1,T1)
          & reproducibility(X,Rp2,T2)
          & ~ greater(Ta,T1)
          & greater(T2,T1)
          & ~ greater(T2,Tb) )
       => greater(Rp1,Rp2) ) )).

%--------------------------------------------------------------------------
