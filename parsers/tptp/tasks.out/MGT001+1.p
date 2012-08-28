{
  e[X,Y,T1,T2,I1,I2,P1,P2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),survival_chance(X,P1,T1),survival_chance(Y,P2,T2),greater(I2,I1)] {
    a[X,T][organization(X,T)] {
      e[R][reliability(X,R,T)] {}};
    a[X,T][organization(X,T)] {
      e[A][accountability(X,A,T)] {}};
    a[X,T][organization(X,T)] {
      e[Rp][reproducibility(X,Rp,T)] {}};
    a[X,Y,R1,R2,A1,A2,P1,P2,T1,T2][organization(X,T1),organization(Y,T2),reliability(X,R1,T1),reliability(Y,R2,T2),accountability(X,A1,T1),accountability(Y,A2,T2),survival_chance(X,P1,T1),survival_chance(Y,P2,T2),greater(R2,R1),greater(A2,A1)] {
      e[][greater(P2,P1)] {}};
    a[X,Y,T1,T2,R1,R2,A1,A2,Rp1,Rp2][organization(X,T1),organization(Y,T2),reliability(X,R1,T1),reliability(Y,R2,T2),accountability(X,A1,T1),accountability(Y,A2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(R2,R1),greater(A2,A1)] {}};
        a[][greater(R2,R1),greater(A2,A1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[X,Y,T1,T2,Rp1,Rp2,I1,I2][organization(X,T1),organization(Y,T2),reorganization_free(X,T1,T1),reorganization_free(Y,T2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2),inertia(X,I1,T1),inertia(Y,I2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(I2,I1)] {}};
        a[][greater(I2,I1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[][greater(P2,P1)] {
      e[][False] {}}}
}