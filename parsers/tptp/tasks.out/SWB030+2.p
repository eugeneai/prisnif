{
  e[BNODE_x][iext(uri_rdf_type,uri_ex_c,uri_owl_Class),iext(uri_owl_complementOf,uri_ex_c,BNODE_x),iext(uri_rdf_type,BNODE_x,uri_owl_Restriction),iext(uri_owl_onProperty,BNODE_x,uri_rdf_type),iext(uri_owl_hasSelf,BNODE_x,literal_typed(dat_str_true,uri_xsd_boolean))] {
    a[X,C][] {
      e[][] {
        a[][iext(uri_rdf_type,X,C)] {
          e[][icext(C,X)] {}};
        a[][icext(C,X)] {
          e[][iext(uri_rdf_type,X,C)] {}}}};
    a[Z,P,V][iext(uri_owl_hasSelf,Z,V),iext(uri_owl_onProperty,Z,P)] {
      e[][] {
        a[X][] {
          e[][] {
            a[][icext(Z,X)] {
              e[][iext(P,X,X)] {}};
            a[][iext(P,X,X)] {
              e[][icext(Z,X)] {}}}}}};
    a[Z,C][iext(uri_owl_complementOf,Z,C)] {
      e[][ic(Z),ic(C)] {
        a[X][] {
          e[][] {
            a[][icext(Z,X),icext(C,X)] {
              e[][False] {}};
            a[][] {
              e[][icext(C,X)] {};
              e[][icext(Z,X)] {}}}}}}}
}