{
  e[X,R1,R2,A1,A2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),reliability(X,R1,T1),reliability(X,R2,T2),accountability(X,A1,T1),accountability(X,A2,T2),greater(T2,T1)] {
    a[X,T][organization(X,T)] {
      e[Rp][reproducibility(X,Rp,T)] {}};
    a[X,Y,T1,T2,R1,R2,A1,A2,Rp1,Rp2][organization(X,T1),organization(Y,T2),reliability(X,R1,T1),reliability(Y,R2,T2),accountability(X,A1,T1),accountability(Y,A2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(R2,R1),greater(A2,A1)] {}};
        a[][greater(R2,R1),greater(A2,A1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[X,Rp1,Rp2,T1,T2][organization(X,T1),organization(X,T2),reorganization_free(X,T1,T2),reproducibility(X,Rp1,T1),reproducibility(X,Rp2,T2),greater(T2,T1)] {
      e[][greater(Rp2,Rp1)] {}};
    a[][] {
      e[][] {
        a[][greater(R2,R1)] {
          e[][False] {}}};
      e[][] {
        a[][greater(A2,A1)] {
          e[][False] {}}}}}
}