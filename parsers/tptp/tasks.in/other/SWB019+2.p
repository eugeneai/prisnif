%------------------------------------------------------------------------------
% File     : SWB019+2 : TPTP v5.4.0. Released v5.2.0.
% Domain   : Semantic Web
% Problem  : Disjoint Annotation Properties
% Version  : [Sch11] axioms : Reduced > Incomplete.
% English  :

% Refs     : [Sch11] Schneider, M. (2011), Email to G. Sutcliffe
% Source   : [Sch11]
% Names    : 019_Disjoint_Annotation_Properties [Sch11]

% Status   : Unsatisfiable
% Rating   : 0.00 v5.2.0
% Syntax   : Number of formulae    :    2 (   0 unit)
%            Number of atoms       :   12 (   0 equality)
%            Maximal formula depth :   10 (   8 average)
%            Number of connectives :   11 (   1   ~;   0   |;   9   &)
%                                         (   1 <=>;   0  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&)
%            Number of predicates  :    2 (   0 propositional; 1-3 arity)
%            Number of functors    :   10 (   9 constant; 0-1 arity)
%            Number of variables   :    4 (   0 sgn;   4   !;   0   ?)
%            Maximal term depth    :    2 (   1 average)
% SPC      : FOF_UNS_RFO_NEQ

% Comments :
%------------------------------------------------------------------------------
fof(owl_eqdis_propertydisjointwith,axiom,(
    ! [P1,P2] :
      ( iext(uri_owl_propertyDisjointWith,P1,P2)
    <=> ( ip(P1)
        & ip(P2)
        & ! [X,Y] :
            ~ ( iext(P1,X,Y)
              & iext(P2,X,Y) ) ) ) )).

fof(testcase_premise_fullish_019_Disjoint_Annotation_Properties,axiom,
    ( iext(uri_rdf_type,uri_skos_prefLabel,uri_owl_AnnotationProperty)
    & iext(uri_rdfs_subPropertyOf,uri_skos_prefLabel,uri_rdfs_label)
    & iext(uri_rdf_type,uri_skos_altLabel,uri_owl_AnnotationProperty)
    & iext(uri_rdfs_subPropertyOf,uri_skos_altLabel,uri_rdfs_label)
    & iext(uri_owl_propertyDisjointWith,uri_skos_prefLabel,uri_skos_altLabel)
    & iext(uri_skos_prefLabel,uri_ex_foo,literal_plain(dat_str_foo))
    & iext(uri_skos_altLabel,uri_ex_foo,literal_plain(dat_str_foo)) )).

%------------------------------------------------------------------------------
