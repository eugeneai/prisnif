{
  e[Peanuts,John,Bill,Sue,Apples,Chicken][food(Apples),food(Chicken),eats(Bill,Peanuts),alive(Bill)] {
    a[X,Y][alive(Y),eats(Y,Chicken)] {
      e[][likes(Y,X)] {}};
    a[X][food(X)] {
      e[][likes(John,X)] {}};
    a[X][] {
      e[][] {
        a[][] {
          e[][] {
            a[Y][] {
              e[][] {
                a[][eats(Y,X)] {
                  e[][False] {}}};
              e[][] {
                a[][not_killed_by(Y,X)] {
                  e[][False] {}}}}};
          e[][food(X)] {}}}};
    a[X][eats(Bill,X)] {
      e[][eats(Sue,X)] {}};
    a[Y][alive(Y)] {
      e[][] {
        a[X][] {
          e[][not_killed_by(Y,X)] {}}}};
    a[][likes(John,Peanuts)] {
      e[][False] {}}}
}