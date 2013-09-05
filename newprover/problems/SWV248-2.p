{e[][] 
{ 
a[][c_lessequals(c_union(c_Message_Oanalz(c_union(v_G,v_H,tc_Message_Omsg)),c_Message_Osynth(v_G),tc_Message_Omsg),c_Message_Oanalz(c_union(c_Message_Osynth(v_G),v_H,tc_Message_Omsg)),tc_set(tc_Message_Omsg))] {e[][False]{}}; 
a[V_X,V_H][c_in(V_X,V_H,tc_Message_Omsg)] {e[][c_in(V_X,c_Message_Oanalz(V_H),tc_Message_Omsg),c_in(V_X,c_Message_Osynth(V_H),tc_Message_Omsg)]{}}; 
a[V_G,V_H][c_lessequals(V_G,V_H,tc_set(tc_Message_Omsg))] {e[][c_lessequals(c_Message_Oanalz(V_G),c_Message_Oanalz(V_H),tc_set(tc_Message_Omsg))]{}}; 
a[V_c,V_B,T_a,V_A,V_B][c_in(V_c,V_B,T_a)] {e[][c_in(V_c,c_union(V_A,V_B,T_a),T_a)]{}}; 
a[V_c,V_A,T_a,V_B][c_in(V_c,V_A,T_a)] {e[][c_in(V_c,c_union(V_A,V_B,T_a),T_a)]{}}; 
a[V_A,V_B,V_C,T_a][c_lessequals(V_B,V_C,tc_set(T_a)),c_lessequals(V_A,V_C,tc_set(T_a))] {e[][c_lessequals(c_union(V_A,V_B,T_a),V_C,tc_set(T_a)) ]{}}; 
a[V_A,V_B,T_a][c_in(c_Main_OsubsetI__1(V_A,V_B,T_a),V_B,T_a)] {e[][c_lessequals(V_A,V_B,tc_set(T_a))]{}}; 
a[V_A,V_B,T_a][] {e[][c_in(c_Main_OsubsetI__1(V_A,V_B,T_a),V_A,T_a)]{};e[][c_lessequals(V_A,V_B,tc_set(T_a))]{}}
 } }


