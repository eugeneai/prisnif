{
  e[X,I1,I2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),inertia(X,I1,T1),inertia(X,I2,T2),greater(T2,T1)] {
    a[X,T][organization(X,T)] {
      e[Rp][reproducibility(X,Rp,T)] {}};
    a[X,T1,T2][reorganization_free(X,T1,T2)] {
      e[][reorganization_free(X,T1,T1),reorganization_free(X,T2,T2)] {}};
    a[X,Y,T1,T2,Rp1,Rp2,I1,I2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2),inertia(X,I1,T1),inertia(Y,I2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(I2,I1)] {}};
        a[][greater(I2,I1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[X,Rp1,Rp2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),reproducibility(X,Rp1,T1),reproducibility(X,Rp2,T2),greater(T2,T1)] {
      e[][greater(Rp2,Rp1)] {}};
    a[][greater(I2,I1)] {
      e[][False] {}}}
}