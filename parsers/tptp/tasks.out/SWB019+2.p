{
  e[][iext(uri_rdf_type,uri_skos_prefLabel,uri_owl_AnnotationProperty),iext(uri_rdfs_subPropertyOf,uri_skos_prefLabel,uri_rdfs_label),iext(uri_rdf_type,uri_skos_altLabel,uri_owl_AnnotationProperty),iext(uri_rdfs_subPropertyOf,uri_skos_altLabel,uri_rdfs_label),iext(uri_owl_propertyDisjointWith,uri_skos_prefLabel,uri_skos_altLabel),iext(uri_skos_prefLabel,uri_ex_foo,literal_plain(dat_str_foo)),iext(uri_skos_altLabel,uri_ex_foo,literal_plain(dat_str_foo))] {
    a[P1,P2][] {
      e[][] {
        a[][iext(uri_owl_propertyDisjointWith,P1,P2)] {
          e[][ip(P1),ip(P2)] {
            a[X,Y][] {
              e[][] {
                a[][iext(P1,X,Y)] {
                  e[][False] {}}};
              e[][] {
                a[][iext(P2,X,Y)] {
                  e[][False] {}}}}}};
        a[][ip(P1),ip(P2)] {
          e[][] {
            a[][] {
              e[X,Y][iext(P1,X,Y),iext(P2,X,Y)] {};
              e[][iext(uri_owl_propertyDisjointWith,P1,P2)] {}}}}}}}
}
