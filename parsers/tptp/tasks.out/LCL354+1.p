{
  e[P,Q][meets(P,Q)] {
    a[P,Q,R,S][meets(P,Q),meets(P,S),meets(R,Q)] {
      e[][meets(R,S)] {}};
    a[P,Q,R,S][meets(P,Q),meets(R,S)] {
      e[][bc(<~>,bc(<~>,t(meets,[P,S]),ip_q(e,[T],conj([t(meets,[P,T]),t(meets,[T,S])]))),ip_q(e,[T],conj([t(meets,[R,T]),t(meets,[T,Q])])))] {}};
    a[P][] {
      e[Q,R][meets(Q,P),meets(P,R)] {}};
    a[R,S,T][] {
      e[][] {
        a[][meets(R,P)] {
          e[][False] {}}};
      e[][] {
        a[][meets(Q,S)] {
          e[][False] {}}};
      e[][] {
        a[][meets(R,T)] {
          e[][False] {}}};
      e[][] {
        a[][meets(T,S)] {
          e[][False] {}}}}}
}