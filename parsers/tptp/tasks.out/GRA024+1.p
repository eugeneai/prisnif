{
  e[][less_than(n1,n2),less_than(n2,n3),less_than(n3,n4),less_than(n4,n5),less_than(n5,n6),less_than(n6,n7),less_than(n7,n8),less_than(n8,n9),less_than(n9,n10),less_than(n10,n11)] {
    a[A,B,C,D,E,F][red(A,B),red(A,C),red(B,C),red(A,D),red(B,D),red(C,D),red(A,E),red(B,E),red(C,E),red(D,E),red(A,F),red(B,F),red(C,F),red(D,F),red(E,F)] {
      e[][goal] {}};
    a[A,B,C,D,E,F][green(A,B),green(A,C),green(B,C),green(A,D),green(B,D),green(C,D),green(A,E),green(B,E),green(C,E),green(D,E),green(A,F),green(B,F),green(C,F),green(D,F),green(E,F)] {
      e[][goal] {}};
    a[A,B][red(A,B),green(A,B)] {
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