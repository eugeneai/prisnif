{
  e[A,A,B][empty(A)] {
    a[A,B][disjoint(A,B)] {
      e[][disjoint(B,A)] {}};
    a[A,B][in(A,B),in(B,A)] {
      e[][False] {}};
    a[A,B][] {
      e[][in(A,B)] {};
      e[][disjoint(singleton(A),B)] {}};
    a[][empty(A)] {
      e[][False] {}};
    a[][in(A,B)] {
      e[][False] {}};
    a[][disjoint(singleton(A),B)] {
      e[][False] {}}}
}