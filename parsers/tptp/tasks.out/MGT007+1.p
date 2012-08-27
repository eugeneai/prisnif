{
  e[X,Rp1,Rp2,T1,T2,Ta,Tb][organization(X,T1),organization(X,T2),reorganization(X,Ta,Tb),reproducibility(X,Rp1,T1),reproducibility(X,Rp2,T2),greater(T2,T1)] {
    a[X,T][organization(X,T)] {
      e[R][reliability(X,R,T)] {}};
    a[X,T][organization(X,T)] {
      e[A][accountability(X,A,T)] {}};
    a[X,T][organization(X,T)] {
      e[A][reproducibility(X,A,T)] {}};
    a[X,Y,T1,T2,R1,R2,A1,A2,Rp1,Rp2][organization(X,T1),organization(Y,T2),reliability(X,R1,T1),reliability(Y,R2,T2),accountability(X,A1,T1),accountability(Y,A2,T2),reproducibility(X,Rp1,T1),reproducibility(Y,Rp2,T2)] {
      e[][] {
        a[][greater(Rp2,Rp1)] {
          e[][greater(R2,R1),greater(A2,A1)] {}};
        a[][greater(R2,R1),greater(A2,A1)] {
          e[][greater(Rp2,Rp1)] {}}}};
    a[X,R1,R2,A1,A2,T1,T2,Ta,Tb][organization(X,T1),organization(X,T2),reorganization(X,Ta,Tb),reliability(X,R1,T1),reliability(X,R2,T2),accountability(X,A1,T1),accountability(X,A2,T2),greater(T2,T1)] {
      e[][] {
        a[][] {
          e[][greater(Ta,T1)] {};
          e[][greater(T2,Tb)] {};
          e[][greater(R1,R2),greater(A1,A2)] {}}}};
    a[][greater(Ta,T1)] {
      e[][False] {}};
    a[][greater(T2,Tb)] {
      e[][False] {}};
    a[][greater(Rp1,Rp2)] {
      e[][False] {}}}
}
