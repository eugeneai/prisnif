{
  e[][reflexive_rewrite(a,b),reflexive_rewrite(a,c)] {
    a[A][reflexive_rewrite(b,A),reflexive_rewrite(c,A)] {
      e[][goal] {}};
    a[A][] {
      e[][equalish(A,A)] {}};
    a[A,B][equalish(A,B)] {
      e[][equalish(B,A)] {}};
    a[A,B,C][equalish(A,B),reflexive_rewrite(B,C)] {
      e[][reflexive_rewrite(A,C)] {}};
    a[A,B][equalish(A,B)] {
      e[][reflexive_rewrite(A,B)] {}};
    a[A,B][rewrite(A,B)] {
      e[][reflexive_rewrite(A,B)] {}};
    a[A,B][reflexive_rewrite(A,B)] {
      e[][] {
        a[][] {
          e[][equalish(A,B)] {};
          e[][rewrite(A,B)] {}}}};
    a[A,B,C][rewrite(A,B),rewrite(A,C)] {
      e[D][rewrite(B,D),rewrite(C,D)] {}};
    a[][goal] {
      e[][False] {}}}
}