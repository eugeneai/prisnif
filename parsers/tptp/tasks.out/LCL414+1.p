{
  e[A][] {
    a[P,Q][] {
      e[][] {
        a[][a_truth(implies(P,Q))] {
          e[][False] {}}};
      e[][] {
        a[][a_truth(P)] {
          e[][False] {}}};
      e[][a_truth(Q)] {}};
    a[P,Q][] {
      e[][a_truth(implies(P,implies(Q,P)))] {}};
    a[P,Q,R][] {
      e[][a_truth(implies(implies(P,implies(Q,R)),implies(implies(P,Q),implies(P,R))))] {}};
    a[P,Q][] {
      e[][a_truth(implies(implies(not(P),not(Q)),implies(Q,P)))] {}};
    a[][a_truth(implies(A,A))] {
      e[][False] {}}}
}