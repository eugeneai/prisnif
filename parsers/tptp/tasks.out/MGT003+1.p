{
  e[X,P1,P2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),survival_chance(X,P1,T1),survival_chance(X,P2,T2),greater(T2,T1)] {
    a[X,T1,T2][reorganization_free(X,T1,T2)] {
      e[][reorganization_free(X,T1,T1),reorganization_free(X,T2,T2)] {}};
    a[X,T][organization(X,T)] {
      e[I][inertia(X,I,T)] {}};
    a[X,Y,T1,T2,I1,I2,P1,P2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),survival_chance(X,P1,T1),survival_chance(Y,P2,T2),greater(I2,I1)] {
      e[][greater(P2,P1)] {}};
    a[X,I1,I2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),inertia(X,I1,T1),inertia(X,I2,T2),greater(T2,T1)] {
      e[][greater(I2,I1)] {}};
    a[][greater(P2,P1)] {
      e[][False] {}}}
}