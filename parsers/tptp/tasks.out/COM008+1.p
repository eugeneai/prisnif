{
  e[][transitive_reflexive_rewrite(a,b),transitive_reflexive_rewrite(a,c)] {
    a[A][transitive_reflexive_rewrite(b,A),transitive_reflexive_rewrite(c,A)] {
      e[][goal] {}};
    a[A][] {
      e[][equalish(A,A)] {}};
    a[A,B][equalish(A,B)] {
      e[][equalish(B,A)] {}};
    a[A,B][equalish(A,B)] {
      e[][transitive_reflexive_rewrite(A,B)] {}};
    a[A,B][rewrite(A,B)] {
      e[][transitive_reflexive_rewrite(A,B)] {}};
    a[A,B,C][transitive_reflexive_rewrite(A,B),transitive_reflexive_rewrite(B,C)] {
      e[][transitive_reflexive_rewrite(A,C)] {}};
    a[A,B,C][rewrite(A,B),rewrite(A,C)] {
      e[D][transitive_reflexive_rewrite(B,D),transitive_reflexive_rewrite(C,D)] {}};
    a[A,B,C][rewrite(a,A),transitive_reflexive_rewrite(A,B),transitive_reflexive_rewrite(A,C)] {
      e[D][transitive_reflexive_rewrite(B,D),transitive_reflexive_rewrite(C,D)] {}};
    a[A,B][transitive_reflexive_rewrite(A,B)] {
      e[][] {
        a[][] {
          e[][equalish(A,B)] {};
          e[C][rewrite(A,C),transitive_reflexive_rewrite(C,B)] {}}}};
    a[][goal] {
      e[][False] {}}}
}