{
  e[][less_than(n1,n2),less_than(n2,n3),less_than(n3,n4),less_than(n4,n5)] {
    a[A,B,C][red(A,B),red(B,C),red(A,C)] {
      e[][goal] {}};
    a[A,B,C][green(A,B),green(B,C),green(A,C)] {
      e[][goal] {}};
    a[A,B,C][less_than(A,B),less_than(B,C)] {
      e[][less_than(A,C)] {}};
    a[A,B][less_than(A,B)] {
      e[][] {
        a[][] {
          e[][red(A,B)] {};
          e[][green(A,B)] {}}}};
    a[][goal] {
      e[][False] {}}}
}