{
  e[X,Y,C,Rp1,Rp2,S1,S2,T1,T2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),class(X,C,T1),class(Y,C,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2),size(X,S1,T1),size(Y,S2,T2),greater(S2,S1)] {
    a[X,T][organization(X,T)] {
      e[I][inertia(X,I,T)] {}};
    a[X,Y,T1,T2,Rp1,Rp2,I1,I2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2),inertia(X,I1,T1),inertia(Y,I2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(I2,I1)] {}};
        a[][greater(I2,I1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[X,Y,C,S1,S2,I1,I2,T1,T2][organization(X,T1),organization(Y,T2),class(X,C,T1),class(Y,C,T2),size(X,S1,T1),size(Y,S2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),greater(S2,S1)] {
      e[][greater(I2,I1)] {}};
    a[][greater(Rp2,Rp1)] {
      e[][False] {}}}
}