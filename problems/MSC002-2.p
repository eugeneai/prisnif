{
  e[][at(something,here,now)] {
    a[Situation,Thing][held(Thing,let_go(Situation))] {
      e[][False] {}};
    a[Situation_k11,Thing_e1y][at(Thing_e1y,here,Situation_k11)] {
      e[][red(Thing_e1y)] {}};
    a[Situation_wSk,Place,Thing_81U][at(Thing_81U,Place,Situation_wSk)] {
      e[][at(Thing_81U,Place,let_go(Situation_wSk))] {}};
    a[Situation_3uO1,Place_OsE2,Thing_erY1][at(Thing_erY1,Place_OsE2,Situation_3uO1)] {
      e[][at(Thing_erY1,Place_OsE2,pick_up(Situation_3uO1))] {}};
    a[Situation_8Ah,Place_udJ3,Thing_5dd2][at(Thing_5dd2,Place_udJ3,Situation_8Ah)] {
      e[][grabbed(Thing_5dd2,pick_up(go(Place_udJ3,let_go(Situation_8Ah))))] {}};
    a[Situation_d3R3,Thing_ec92][red(Thing_ec92),put(Thing_ec92,there,Situation_d3R3)] {
      e[][answer(Situation_d3R3)] {}};
    a[Another_place,Situation_Pwd,Place_UqS,Thing_5OE3][at(Thing_5OE3,Place_UqS,Situation_Pwd),grabbed(Thing_5OE3,Situation_Pwd)] {
      e[][put(Thing_5OE3,Another_place,go(Another_place,Situation_Pwd))] {}};
    a[Another_place_FWN3,Situation_nj41,Place_xN13,Thing_8NL2][at(Thing_8NL2,Place_xN13,Situation_nj41)] {
      e[][] {
        a[][] {
          e[][held(Thing_8NL2,Situation_nj41)] {};
          e[][at(Thing_8NL2,Place_xN13,go(Another_place_FWN3,Situation_nj41))] {}}}};
    a[Situation_s2E1][answer(Situation_s2E1)] {
      e[][False] {}}}
}
