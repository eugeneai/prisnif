{
  e[X,Y,Rt,C,S1,S2,Ta,Tb,Tc][organization(X,Ta),organization(Y,Ta),class(X,C,Ta),class(Y,C,Ta),reorganization(X,Ta,Tb),reorganization(Y,Ta,Tc),reorganization_type(X,Rt,Ta),reorganization_type(Y,Rt,Ta),size(X,S1,Ta),size(Y,S2,Ta),greater(S2,S1)] {
    a[X,T][organization(X,T)] {
      e[I][inertia(X,I,T)] {}};
    a[X,Y,C,S1,S2,I1,I2,T1,T2][organization(X,T1),organization(Y,T2),class(X,C,T1),class(Y,C,T2),size(X,S1,T1),size(Y,S2,T2),inertia(X,I1,T1),inertia(Y,I2,T2),greater(S2,S1)] {
      e[][greater(I2,I1)] {}};
    a[X,Y,Rt,C,I1,I2,Ta,Tb,Tc][organization(X,Ta),organization(Y,Ta),class(X,C,Ta),class(Y,C,Ta),reorganization(X,Ta,Tb),reorganization(Y,Ta,Tc),reorganization_type(X,Rt,Ta),reorganization_type(Y,Rt,Ta),inertia(X,I1,Ta),inertia(Y,I2,Ta),greater(I2,I1)] {
      e[][] {
        a[][] {
          e[][organization(Y,Tc)] {};
          e[][greater(Tb,Tc)] {}}}};
    a[][organization(Y,Tc)] {
      e[][False] {}};
    a[][greater(Tb,Tc)] {
      e[][False] {}}}
}
