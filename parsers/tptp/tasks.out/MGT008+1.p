{
  e[X,Y,C,P1,P2,S1,S2,T1,T2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),class(X,C,T1),class(Y,C,T2),survival_chance(X,P1,T1),survival_chance(Y,P2,T2),size(X,S1,T1),size(Y,S2,T2),greater(S2,S1)] {
    a[X,T][organization(X,T)] {
      e[I][inertia(X,I,T)] {}};
    a[X,Y,C,S1,S2,I1,I2,T1,T2][organization(X,T1),organization(Y,T2),class(X,C,T1),class(Y,C,T2),size(X,S1,T1),size(Y,S2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),greater(S2,S1)] {
      e[][greater(I2,I1)] {}};
    a[X,Y,T1,T2,I1,I2,P1,P2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),survival_chance(X,P1,T1),survival_chance(Y,P2,T2),greater(I2,I1)] {
      e[][greater(P2,P1)] {}};
    a[][greater(P2,P1)] {
      e[][False] {}}}
}