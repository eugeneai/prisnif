{
  e[][equalish(n0,n0),equalish(n1,n1)] {
    a[][equalish(n0,n1)] {
      e[][False] {}};
    a[][equalish(n1,n0)] {
      e[][False] {}};
    a[X1,X2,X3,X4][equalish(X1,X1),equalish(X2,X2),equalish(X3,X3),equalish(X4,X4)] {
      e[Z][f(X1,X2,X3,X4,Z)] {}};
    a[X1,X2,X3,X4,Y1,Y2,Y3,Y4,Z][f(X1,X2,X3,X4,Z),f(Y1,Y2,Y3,Y4,Z)] {
      e[][equalish(X1,Y1),equalish(X2,Y2),equalish(X3,Y3),equalish(X4,Y4)] {}}}
}