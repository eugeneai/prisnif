:-dynamic(fol/2).
:-dynamic(q_option/2).
:-dynamic(ast/1).

q_set_option(Atom, Value):-
        retract(q_option(Atom, _)),!,
        assertz(q_option(Atom,Value)),!.
q_set_option(Atom, Value):-
        assertz(q_option(Atom,Value)),!.

q_syn_error(Error, _, _):-
        syntax_error_info('<input>', 0, 0, Error).

q_formula(F) -->
        q_pcf_formula(F) ;
        q_ip_formula(F).

q_ip_quant(ip_q(S,L,I)) -->
        q_quant_sign(S),
        q_quant_var_list(L),
        q_imp(I).

q_ip_formula(Q) -->
        q_ip_quant(Q);
        q_imp(Q).

q_imp(imp(D,I)) -->
        q_disj(D), ['>'], q_disj(I).
q_imp(equ(A,B)) -->
        q_disj(A), ['<>'], q_disj(B).
q_imp(D) -->
        q_disj(D).

q_disj(disj([A,B])) -->
        q_conj(A), ['+'], q_conj(B).
q_disj(C) -->
        q_conj(C).

q_conj(conj([A,B])) -->
        q_lit(A), ['&'], q_lit(B).
q_conj(E) -->
        q_lit(E).

q_lit(neg(L)) -->
        ['~'], q_plit(L);
        ['-'], q_plit(L).
q_lit(L) -->
        q_plit(L).

q_plit(L) -->
        q_term(L) ;
        ['('], q_ip_formula(L), [')'];
        q_ip_quant(L).

q_formula_cmd(cmd_fm(T,D)) -->
        ['fm'], q_simple_term(T), ['='],
        q_formula(D).

q_simple_term(t(N,L)) -->
        q_name(N), ['('], q_var_list(L), [')'].
q_simple_term(t(N)) -->
        q_name(N).

q_pcf_formula(L) -->
        q_pcf_fm_list(L);
        q_pcf_quant(L).

q_quant_sign(S) -->
        ['!'], {S=a};
        ['?'], {S=e}.

q_pcf_quant(q(S, L, C, Fs)) -->
        q_quant_sign(S),
        q_quant_var_list(L),
        [':'],
        q_conjunct(C),
        q_pcf_fm_list(Fs).

q_quant_var_list(L) -->
         ['{'], ['}'], {L=[]};
         ['{'], q_var_list(L), ['}'];
         q_var_list(L);
        { L=[] }.


q_pcf_fm_list(Fl) -->
         ['{'], ['}'], {Fl=[]};
         ['['], [']'], {Fl=[]};
         ['{'], q_pcf_list(Fl),  ['}'];
         ['['], q_pcf_list(Fl),  [']'];
        { Fl=[] }.

q_pcf_list([Q|T]) -->
        q_pcf_quant(Q), [';'], q_pcf_list(T).
q_pcf_list([Q]) -->
        q_pcf_quant(Q).

q_var_list([N|T]) -->
        q_name(N), [','], q_var_list(T).
q_var_list([N]) -->
        q_name(N).

q_conjunct(L) -->
         ['{'], ['}'], {L=[]};
         ['{'], q_term_list(L), ['}'];
         q_term_list(L) ;
         { L=[] }.

q_term(t(N,T)) -->
	q_name(N), ['('], q_term_list(T), [')'].
q_term(t(N)) -->
	q_name(N).

q_name(T, [T|O], O):-
        atom(T).

q_term_list([T|L]) -->
	q_term(T), [','], q_term_list(L).
q_term_list([T]) -->
	q_term(T).

q_load(Stream, Atom):-
        open_output_atom_stream(OStream),!,
        q_clean_stream(Stream,OStream),!,
        close_output_atom_stream(OStream, Atom),!.

q_lex(Stream, Lex):-
        q_load(Stream, Atom),
        open_input_atom_stream(Atom, S),
        q_lex1(S, Lex),
        close_input_atom_stream(S).

q_lex1(Stream, L) :-
        read_token(Stream, Term),!,
        (
           Term=punct(end_of_file),
           L=[],!;
           !,
           q_conv_lex(Term, T),
           q_lex1(Stream, Tail),
           app(T, Tail, L)
        ).

q_clean_stream(I,O):-
        q_clean_stream(I,O,false).

q_clean_stream(I, O, Comment):-
        get_char(I, C),
        (
         C=end_of_file -> true;
         C='\n' -> write(O, '#new_line\n'),
               q_clean_stream(I,O, false);
         C='#' -> write(O, ' '),
               q_clean_stream(I,O, true);
         Comment=true -> write(O, ' '),
               q_clean_stream(I,O, true);
         write(O, C),
               q_clean_stream(I,O, false)
        ).


app([], L, L).
app([X|L1], L2, [X|L3]):-
        app(L1, L2, L3).

q_conv_lex(var(I), O) :-
        q_conv_ex(I,O),!.
q_conv_lex(punct(I),O) :-
        q_conv_ex(I,O),!.
q_conv_lex(I,O):-
        q_conv_ex(I,O),!.

q_conv_ex('&-', ['&','-']):-!.
q_conv_ex(A, [A]).

% Lexical stream from atom.
q_lex_s(A, L):-
        open_input_atom_stream(A, S), !,
        q_lex(S, L), !,
        close_input_atom_stream(S), !.


%formula reduction.
q_rd(I,O):-
        q_r(I,T),!,
        q_rd(T,O).

q_rd(cmd_fm(T, F), O):-!,
        q_rd(F,R),
        q_rr(cmd_fm(T, R), O).
q_rd(neg(A), O):-!,
	q_rd(A,A1),
        q_rr(neg(A1), O).
q_rd(conj(L), O):-!,
	q_rd_elems(L,L1),
        q_rr(conj(L1), O).
q_rd(disj(L), O):-!,
        q_rd_elems(L,L1),
        q_rr(disj(L1), O).
q_rd(imp(A,B), O):-!,
        q_rd(A,A1),
        q_rd(B,B1),
        q_rr(imp(A1,B1), O).
q_rd(ip_q(S,L,I), O):-!,
        q_r_dups(L,L1),
        q_rd(I,I1),
        q_rr(ip_q(S,L1,I1), O).
q_rd(q(S,L,T, F), O):-!,
        q_r_dups(L,L1),
        q_r_dups(T,T1),
        q_rd_elems(F,F1),
        q_rr(q(S,L1,T1,F1), O).

q_rd(I,I).

q_rd_elems([],[]):-!.
q_rd_elems([X|T], [RX|RT]):-
	q_rd(X,RX),
	q_rd_elems(T,RT).

q_rr(I,O):-
        q_r(I,O),!.
q_rr(I,I).

q_r_dups([],[]).
q_r_dups([X|T],T):-
        q_in(X,T),!.
q_r_dups(X,X).

q_in(X,[X|_]):-!.
q_in(X,[_|T]):-!,
        q_in(X,T).

q_r(ip_q(_,_,t(X)), t(X)):-q_in(X,['True','False']), !. % are the !'s really needed?
q_r(neg(ip_q(S,V,E)), ip_q(AS,V,neg(E))):-
        q_alter_q(S,AS),!.
q_r(conj([]), t('True')):-!.
q_r(disj([]), t('False')):-!.
q_r(conj([A]), A):-!.
q_r(disj([A]), A):-!.
q_r(conj([A,A]),A):-!. % XXX Should be generalized.
q_r(disj([A,A]),A):-!. % XXX Should be generalized.
q_r(imp(A,A), t('True')):-!.
q_r(equ(A,A), t('True')):-!.
q_r(neg(neg(E)), E):-!.

%flatten the conjunctions and disjunctions

q_r(conj(L), R):- member(conj(_), L),!,
        q_flat(conj(L), R).
q_r(disj(L), R):- member(disj(_), L),!,
        q_flat(disj(L), R).

q_r(disj(L), t('True')):- member(t('True'), L),!.
q_r(conj(L), t('False')):- member(t('False'), L),!.

q_r(conj(L), conj(R)):- member(t('True'), L),!,
        q_remove_in(L, t('True'), R).
q_r(disj(L), disj(R)):- member(t('False'), L),!,
        q_remove_in(L, t('False'), R).

q_r(conj(L), t('False')):-
        member(A, L),
        member(neg(A), L),
        !.
q_r(disj(L), t('True')):-
        member(A, L),
        member(neg(A), L),
        !.
q_r(disj(L), imp(conj(Con), B)):-
        member(X,L),
        q_neg_lit(X, _),
        !,
        q_split_cd([], disj(L), Con, [], B),!.



q_r(q(e, A,ZA, F), q(e, NA,NZA, NF)):-
        member(q(a,[],[], [R]),F),!,
        q_remove_in(F, q(a, [],[], [R]), F1),
        R=q(e, B, ZB, FBs),
        append(A,B, NA), % Variables in A and B will be already renamed.
        append(ZA,ZB, NZA),
        append(F1, FBs, NF).


q_r(imp(t('True'),B), B):-!.
q_r(imp(_, t('True')), t('True')):-!.
q_r(imp(t('False'),_), t('False')):-!.
q_r(imp(A,neg(B)), imp(conj([A,B]), t('False'))):-!.
q_r(imp(neg(A),B), disj([A,B])):-!.
q_r(neg(imp(A,B)), conj([A,neg(B)])):-!.
q_r(neg(t('False')), t('True')):-!.
q_r(neg(t('True')), t('False')):-!.

q_r(neg(conj(L)), disj(R)):-!,
        q_all_neg(L,R).
q_r(neg(disj(L)), conj(R)):-!,
        q_all_neg(L,R).

q_r(equ(A,B), conj([imp(A,B), imp(B,A)])):-!.
q_r(xor(A,B), conj([imp(A,neg(B)), imp(neg(A),B)])):-!.

q_alter_q(a,e).
q_alter_q(e,a).

q_all_neg([],[]):-!.
q_all_neg([X|T],[neg(X)|R]):-
        q_all_neg(T,R).

q_flat(conj([]), conj([])).
q_flat(conj([conj(L)|T]), conj(R)):-!,
	q_flat(conj(L), conj(L1)),
	q_flat(conj(T), conj(T1)),
	append(L1, T1, R).
q_flat(conj([X|T]), conj([X|T1])):-
	q_flat(conj(T), conj(T1)).

q_flat(disj([]), disj([])).
q_flat(disj([disj(L)|T]), disj(R)):-!,
	q_flat(disj(L), disj(L1)),
	q_flat(disj(T), disj(T1)),
	append(L1, T1, R).
q_flat(disj([X|T]), disj([X|T1])):-
	q_flat(disj(T), disj(T1)).

% Remove 'inessential' terms from the list. E.g. all True's from a conjunction.
q_remove_in([], _, []):-!.
q_remove_in([A|T], A, R):-!,
        q_remove_in(T, A, R).
q_remove_in([B|T], A, [B|R]):-
        q_remove_in(T, A, R).


% XXX stack overflow on a + ~a.

q_pcf_apply_subst([], _, []):-!.
q_pcf_apply_subst([t(N)|T], S, [t(N)|NT]):-!,
        q_pcf_apply_subst(T, S, NT).
q_pcf_apply_subst([t(N,L)|T], S, [t(N,NL)|NT]):-!,
        q_pcf_apply_subst(L, S, NL),
        q_pcf_apply_subst(T, S, NT).
q_pcf_apply_subst([X|T], S, [Y|NT]):-
        X=..[Op,A|Args_],!,
        q_pcf_apply_subst([A|Args_], S, NArgs),
        Y=..[Op|NArgs],
        q_pcf_apply_subst(T, S, NT).
q_pcf_apply_subst([X|T], S, [Y|NT]):-
        member(Y-X, S),!,
        q_pcf_apply_subst(T, S, NT).
q_pcf_apply_subst([X|T], S, [X|NT]):-!,
        q_pcf_apply_subst(T, S, NT).

q_pcf_unnamed(I, O):-
        %             +  -  +Subst +Vars, -Vars
        q_pcf_unnamed(I, O, [],    [],   _).

q_pcf_unnamed(q(S, V, T, Fs), q(S, NV, NT, UFs), Subst, VI, VO):-
        q_var_subst(V, VI, Subst,   NV, NVI, NSubst),
        q_pcf_apply_subst(T, NSubst, NT),
        q_pcf_unnamed(Fs, UFs, NSubst, NVI, VO).

q_pcf_unnamed([], [], _, VI, VI).
q_pcf_unnamed([F|T], [NF|NT], Subst, VI, VO):-
        q_pcf_unnamed(F, NF, Subst, VI, VO1),
        q_pcf_unnamed(T, NT, Subst, VO1, VO).

q_var_subst([],    VI, S,  [],      VI,      S):-!.
q_var_subst([X|T], VI, SI,  [NX|NT], VO, [NX-X|SR]):-
        member(X, VI), !,
        q_gen_name(X, VI, NX),
        q_var_subst(T, [NX|VI], SI,  NT, VO, SR).
q_var_subst([X|T], VI, SI,  [X|NT], VO, SR):-
        q_var_subst(T, [X|VI], SI,  NT, VO, SR).

q_gen_name(V, Vars, NV):-
        atom_concat(V,'_', V_),
        new_atom(V_, NVG),
        atom_chars(NVG, NVCs),
        q_gen_c_clean(NVCs, CNVCs),
        atom_chars(NV1, CNVCs),
        (member(NV1,Vars)->
         q_gen_name(V, Vars, NV);
         NV=NV1)
        .

q_gen_c_clean([],[]).
q_gen_c_clean([X|T], [Y|NT]):-
        q_gen_c_r(X,Y),
        q_gen_c_clean(T, NT).

% #, $, &, _, @
q_gen_c_r('#','3'):-!.
q_gen_c_r('$','4'):-!.
q_gen_c_r('&','7'):-!.
q_gen_c_r('_','_'):-!.
q_gen_c_r('@','2'):-!.
q_gen_c_r(X,X).



%q_subst(S, [], [], S):-!.
%q_subst(S, [X|T], [X1|T1], [X1-X|R]):-!,
%        q_subst(S, T, T1, R).


% --------- Conversion to PCF, RD=rd if defined adds reduction step ---
q_to_pcf(fof(_, _, A, _), B):-!,
        q_to_pcf(A, B).

q_to_pcf(A, B):-
        !,
        q_to_pcf_a(A,B),
        !.

q_to_pcf(A, B, rd):-!,
        q_rd(A, A1),!,
        q_to_pcf(A1,B),!.


% Construction of the PCF tree

q_to_pcf_a(ip_q(a,L,I), q(a, L, T,F)):- !,
        q_to_pcf_a_a(I, T,F).

q_to_pcf_a(ip_q(e,L,I), q(a,[],[],[O])):-!,
        q_to_pcf_e(ip_q(e,L,I), O).

q_to_pcf_a(I, q(a,[], T,F)):-
        q_to_pcf_a_a(I, T,F).

q_to_pcf_e(ip_q(a,L,I), q(e,[],[],[O])):-!,
        q_to_pcf_a(ip_q(a, L,I), O).

q_to_pcf_e(ip_q(e,L,I), q(e,L, T,F)):-!,
        q_to_pcf_e_e(I, T,F).

q_to_pcf_e(I, q(e,[], T,F)):-
        q_to_pcf_e_e(I, T,F).

% individual conversion

q_cnv_term(t(_)):-!.
q_cnv_term(t(_,_)):-!.

% split conjunction on two subconjuncts: first one is conjunction of atoms, other one is more complex formulae.

q_neg_lit(neg(A), A):-
        q_cnv_term(A),!.
q_neg_lit(imp(A, t('False')), A):-
        q_cnv_term(A).

%          IC IF         OC   OCo, OFs
q_split_cd([],disj([]),  [],  [],  disj([])):-!.
q_split_cd([],disj([A]), [A1],[],  disj([])):-
        q_neg_lit(A, A1),!.
q_split_cd([],disj([A]), [],  [],  disj([A])):-!.

q_split_cd([],disj([A|T]), [A1|TC], TCo, disj(Fs)):-
        q_neg_lit(A, A1),!,
        q_split_cd([], disj(T), TC, TCo, disj(Fs)).
q_split_cd([],disj([A|T]),      TC, TCo, disj([A|Fs])):-!,
        q_split_cd([], disj(T), TC, TCo, disj(Fs)).

q_split_cd([], F, [],[],F):-!. % Other nondisj variants

q_split_cd([X|T],I, [X|CA],CF, O):-
	q_cnv_term(X),!,
	q_split_cd(T,I, CA,CF, O).
q_split_cd([X|T],I, CA,[X|CF],O):-
	q_split_cd(T,I, CA,CF,O).

q_to_pcf_a_a(imp(A,B), [A|Con], [F]):-
        q_cnv_term(A),!,
	q_split_cd([], B, Con, [], Fs), % Comp here will be [] as first argument is []
        q_rd(Fs,RFs), % Possibly remove empty disjunctions
        q_to_pcf_e(RFs, F).

q_to_pcf_a_a(imp(conj(L),B), Con, FE):-
	q_split_cd(L, B, Con, Comp, Fs),
        (
         Comp=[], !, F=Fs;
         q_rd(disj([neg(conj(Comp)),Fs]), F)
        ),
        (
         F=disj(_),!, q_to_pcf_a_a(F,_, FE);
         q_to_pcf_e(F,FFE), FE=[FFE]
        ).

q_to_pcf_a_a(imp(A,B), [], [FE]):-
        q_rd(disj([neg(A),B]), F),
        q_to_pcf_e(F, FE).

q_to_pcf_a_a(disj([]), [t('False')], []):-!.
q_to_pcf_a_a(disj([X|T]), [], [FX|TF]):-!,
	q_to_pcf_e(X,FX),
	q_to_pcf_a_a(disj(T), _, TF).

q_to_pcf_a_a(neg(A), [A], [F]):-!,
        q_to_pcf_e(t('False'), F).

q_to_pcf_a_a(I, [], [F]):-!,
        q_to_pcf_e(I, F).

%
q_to_pcf_e_e_l([], []):-!.
q_to_pcf_e_e_l([X|T], [TC|TT]):-!,
	q_to_pcf_a(X,TC),
	q_to_pcf_e_e_l(T, TT).

q_to_pcf_e_e(conj(L), C, F):-
	q_split_cd(L, [], C, FF, _),!,
        q_rd(conj(FF),RFF),
        (
         RFF=conj(CRFF)->
             q_to_pcf_e_e_l(CRFF, F);
         q_to_pcf_a(RFF, PCF_F), F=[PCF_F]
        ).

q_to_pcf_e_e(imp(A,B), [], [F]):-!,
        q_to_pcf_a(imp(A,B), F).

q_to_pcf_e_e(disj(L), [], [F]):-!,
        q_to_pcf_a(disj(L), F).

q_to_pcf_e_e(neg(A), [], [F]):-!,
        q_to_pcf_a(neg(A), F).

q_to_pcf_e_e(ip_q(S,L,I), [], [F]):-!,
        q_to_pcf_a(ip_q(S,L,I), F).

q_to_pcf_e_e(A, [A], []). % The only terminal leave

% writing pcfs

q_tab_space('  ').

q_tabs(0):-!.
q_tabs(1):-!,
        q_tab_space(S),
        write(S).
q_tabs(N):-N>1,
        q_tabs(1),
        N1 is N-1,
        q_tabs(N1).

q_pcf_print(Q):-
        q_pcf_print0(Q, 0).

q_pcf_tq_w(S, L, T):-
        write(S), write(' '), write_l(L), write(':'), write_l(T), nl.

q_pcf_print0(q(a, L, T, F), N):-!,
        q_tabs(N),
        q_pcf_tq_w('A', L, T),
        N1 is N + 1,
        q_pcf_print0_l(F, N1).

q_pcf_print0(q(e, L, T, []), N):-!,
        q_tabs(N),
        q_pcf_tq_w('E', L, T).

q_pcf_print0(q(e, L, T, F), N):-!,
        q_tabs(N),
        q_pcf_tq_w('E', L, T),
        N1 is N + 1,
        q_pcf_print0_l(F, N1).

q_pcf_print0_l([]):-!.
q_pcf_print0_l([X], N):-!,
        q_pcf_print0(X, N).

q_pcf_print0_l([X|T], N):-!,
        q_pcf_print0(X, N),
        q_pcf_print0_l(T,N).

is_true(t('True',_)).
is_true(t('True')).

write_l([]):-!.
write_l([X]):-is_true(X),!.

write_l([t(X)]):-!,
        write(X).
write_l([t(X,[])]):-!,
        write(X).
write_l([t(X, As)]):-!,
        write(X),
        write('('),write_l(As),write(')').

write_l([A=B]):-!,
        write('=('),
        write_l([A]),
        write(','),
        write_l([B]),
        write(')').
write_l([X]):-!,
        write(X).
write_l([X|T]):-
        is_true(X),!,
        write_l(T).
write_l([X|T]):-!,
        write_l([X]), write(','),
        write_l(T).

% Prisnif print.

q_pcf_pp(A):-
        q_pcf_pp(A,0).

q_pcf_pp(q(S,X,T,L), N):-!,
        nl,q_tabs(N),write(S),
        write('['),write_l(X),write(']'),
        write('['),write_l(T),write(']'),
        write(' {'),
        M is N + 1,
        q_pcf_ppl(L, M),
        write('}').

q_pcf_pp(F, sq, N):-
        write('{'),
        q_pcf_pp(F, N),!,
        write('}').

q_pcf_ppb(Bases):-!,
        write('{'),
        q_pcf_ppl(Bases, 1),!,
        nl,
        write('}'),
        nl.

q_pcf_ppl([], _):-!.
q_pcf_ppl([X], N):-!,
        q_pcf_pp(X, N).
q_pcf_ppl([X|T], N):-!,
        q_pcf_pp(X, N),!,
        write(';'),
        q_pcf_ppl(T, N).

% --------------------------------------- TPTP interpreter --------------------------------------------
ast_to_ip(I,O) :-
        ap(I,O).

ap(s(annotated_formula, I), O):-!,
        ap(I, O).


ap(s(fof_annotated, _, _,  NameS, _, RoleS, _, FS, AnnS, _, _), fof(Name, Role, F, Ann)):-!,
        ap(NameS, Name),
        ap(RoleS, Role),
        ap(FS, F),
        ap(AnnS, Ann).

ap(s(cnf_annotated, _, _,  NameS, _, RoleS, _, FS, AnnS, _, _), cnf(Name, Role, F, Ann)):-!,
        ap(NameS, Name),
        ap(RoleS, Role),
        ap(FS, F),
        ap(AnnS, Ann).


ap(s(annotations, l(null)), nil):-!.
ap(s(annotations, _, SourceS, InfoS), annotation(Source, Info)):-!,
        ap(SourceS, Source),
        ap(InfoS, Info).

ap(s(name,s(atomic_word,l(lower_word,X))), X):-!.
ap(s(formula_role, l(_,X)), X):-!.

ap(s(fof_formula, FS), F):-!,
        ap(FS, F).

ap(s(disjunction, FS, _, DS), [F | T]):-!,
        ap(DS, T),
        ap(FS, F).

ap(s(disjunction, FS), [F]):-!,
        ap(FS, F).

ap(s(literal, _, FS), neg(F)):-!,
        ap(FS, F).

ap(s(literal, FS), F):-!,
        ap(FS, F).

ap(s(cnf_formula, _, FS, _), F):-!,
        ap(FS, F).

ap(s(unitary_formula, l('LPAREN',_), FS, l('RPAREN',_)), F):-!,
        ap(FS,F).

ap(s(unitary_formula, FS), F):-!,
        ap(FS,F).

ap(s(unary_formula, UConnS, FS), S):-!,
        ap(UConnS, UConn),
        ap(FS,F),
        uo(UConn, F, S).

ap(s(unary_connective, l(_, C)),C):-!.

ap(s(binary_connective, l(_, C)),C):-!.

ap(s(quantified_formula, QS, _, VarsS, _, _, UFS), ip_q(Q, Vars, F)):-!,
        ap(QS,Q),
        ap(VarsS, Vars),
        ap(UFS, F).

ap(s(quantifier, l(_, '!')), a):-!.
ap(s(quantifier, l(_, '?')), e):-!.

ap(s(variable_list, VS, _, VLS), [V|T]):-!,
        ap(VLS, T),
        ap(VS, V).
ap(s(variable_list, VS), [V]):-!,
        ap(VS, V).

ap(s(binary_formula, BF), F):-!,
        ap(BF, F).

ap(s(assoc_binary, FS), F):-!,
        ap(FS, F).

ap(s(nonassoc_binary, F1S, ConnS, F2S), S):-!,
        ap(F1S, F1),
        ap(F2S, F2),
        ap(ConnS, Conn),!,
        bcn(Conn, F1, F2, S).

ap(s(or_formula, F1S, _, F2S), disj([F1,F2])):-!,
        ap(F1S, F1),
        ap(F2S, F2).

ap(s(and_formula, F1S,_, F2S), conj([F1,F2])):-!,
        ap(F1S, F1),
        ap(F2S, F2).

ap(s(variable, l(_, X)),X):-!.

ap(s(atomic_formula, FS), F):-!,
        ap(FS, F).

ap(s(plain_atom, FS), F):-!,
        ap(FS, F).

ap(s(plain_term, FuS, _, C, _), t(Fu,L)):-!,
        ap(FuS, Fu),
        ap(C, L).

ap(s(plain_term,C), F):-!,
        ap(C, F).


ap(s(functor, C), F):-!,
        ap(C, F).

ap(s(atomic_word, l(_,Name)), Name):-!.

ap(s(arguments, TermS, _, AS), [Term | T]):-!,
        ap(TermS, Term),
        ap(AS, T).

ap(s(arguments, TermS, AS), [Term | T]):-!,
        ap(TermS, Term),
        ap(AS, T).

ap(s(arguments, TermS), [Term]):-!,
        ap(TermS, Term).

ap(s(term, TS), T):-!,
        ap(TS, T).

ap(s(function_term, TS), T):-!,
        ap(TS, T).

ap(s(defined_atom, AS, OpS, CS), Pred):-!,
        ap(AS, A),
        ap(OpS, Op),
        ap(CS, C),
        Pred =.. [Op, A,C].

ap(s(defined_infix_pred, l(_, Op)), Op):-!.



ap(s(constant, TS), T):-!,
        ap(TS, T).

ap(I,c__(I)).


%connectives ----------------

bcn('<=>', F1, F2, equ(F1,F2)):-!.

bcn('<~>', F1, F2, xor(F1,F2)):-!.

bcn('=>', F1, F2, imp(F1,F2)):-!.

bcn('<=', F1, F2, imp(F2,F1)):-!.

bcn(C, F1, F2, unknown_bc(C, F1, F2)).

uo('~', F, neg(F)):-!.

uo(O,F, unknown_uo(O,F)).

%-------------------------------------------------------------
% Translator of the language used in Eugene Cherkashin's PH.D.

q_command_list([]) --> q_command_end.
q_command_list([C]) --> q_command(C),  q_command_end.
q_command_list(T) --> q_command_end, q_command_list(T).
q_command_list([C|T]) --> q_command(C),  q_command_end, q_command_list(T).

q_command(cmd(show, Param)) --> [sw], q_command_show(Param).
q_command(cmd(prisnif, Param)) --> [pp], q_command_show(Param).
q_command(cmd(formula, T, Exp)) --> [fm], q_command_fm(T, Exp).
q_command(cmd(input, Atom)) --> [i], q_name(Atom).

q_command_end --> [full_stop].
q_command_end --> [';'].
q_command_end --> ['.'].

q_command_show(P) --> q_formula(P).
q_command_fm(P, Exp) --> q_term(P), ['='], q_formula(Exp).

%-------------------------------------------------------------
% Command Executors ($$$)
q_do_command_list([]):-!.
q_do_command_list([C|T]):-
	q_do_command(C),
	q_do_command_list(T).

q_do_command(cmd(show, Exp)):-!,
        q_link(Exp, LExp, []),!,
        q_to_pcf(LExp, Pcf, rd),!,
        q_pcf_print(Pcf),
        nl.

q_do_command(cmd(prisnif, Exp)):-!,
        q_link(Exp, LExp, []),!,
        q_to_pcf(LExp, Pcf, rd),!,
        q_pcf_pp(Pcf),
        nl.

q_do_command(cmd(formula, Term, Exp)):-!,
        assertz(fol(Term, Exp)),!,
        write(Term),!,
        write(' added.'), nl.

q_do_command(cmd(input, Atom)):-!,
        open(Atom, read, Stream, []),!,
        q_load(Stream, AtomProg),!,
        write('Loaded text:'),nl,
        write(AtomProg), nl,
        close(Stream),!,
        q_tr_command_list(AtomProg, [], _),
        format('Input success for \'~a\'.~n',[Atom]).

q_do_command(C):-
	write('Command \''), write(C), write('\' not supported'), nl.

% Interprete a string.
q_interp(I):-
	q_tr_command_list(I,[],S),!,
	q_do_command_list(S).


% linking the formula

q_link(t(Name, P1), Exp1, Subst):-
        fol(t(Name,P2), Exp),
        length(P1, LP), length(P2, LP),!,
        q_subst(Subst, P1, P2, NSubst),!, % P1 instead of P2
        q_apply_subst(Exp, NSubst, Exp1, []).

q_link(t(Name), Exp1, Subst):-
        fol(t(Name), Exp),!,
        q_apply_subst(Exp, Subst, Exp1, []).

q_link(F,F, _).

q_subst(S, [], [], S):-!.
q_subst(S, [X|T], [X1|T1], [X1-X|R]):-!,
        q_subst(S, T, T1, R).

% Now the lists.
q_apply_subst([], _, [], _):-!.
q_apply_subst([X|T], Subst, [AX|AT], Vars):-
        q_apply_subst(X, Subst, AX, Vars),!,
        q_apply_subst(T, Subst, AT, Vars),!.

q_apply_subst(ip_q(S, V, E), Subst, ip_q(S, V, NE), Vars):-!,
        q_t_vars(V, TV),        % A bad patch t(X) = X as a quantifier variable.
        append(TV, Vars, NVars),!,
        q_apply_subst(E, Subst, NE, NVars).

q_apply_subst(E, Subst, NS, Vars):-
        E=..[t|_],                 % Is it a term t(...) structure.
        \+ member(E, Vars),
        member(E-S, Subst), !,
        q_link(S, NS, Subst), !.

q_apply_subst(E, Subst, NE, Vars):-
        E=..[t,Name|Args],!,              % Is it a term t(...) structure.
        q_apply_subst(Args, Subst, NArgs, Vars),!,
        E1=..[t,Name|NArgs],!,
        q_link(E1, NE, Subst), !.

q_apply_subst(E, Subst, AE, Vars):-
        E=..[Op | Args],
        q_apply_subst(Args, Subst, AArgs, Vars),!,
        AE=..[Op | AArgs],!.

q_apply_subst(E, _, E, _).

q_t_vars([], []).
q_t_vars([X|T], [t(X)|TT]):-
        q_t_vars(T,TT).

% -----------------------------------------------------------------------------------------------------------
% Functional tests

test1_input('v(x,y,z), K(v), p(K(v)), P{}[]$!@#$^&*(), a^b, a>b, a&b.;').
test2_conjunct('{p(x),p(y),p(f(x),g(x,y))}').
test2_conjunct('{}').
test2_conjunct('').
test4_pcf_quantifier('!x,y,z:{p(x),p(y),p(f(x),g(x,y))} {?{a,b}:{p(a),p(b)};?c:q(c)}').

test5_formula('fm test(a,b,c)=!x,y,z:{p(x),p(y),p(f(x),g(x,y))} {?{a,b}:{p(a),p(b)};?c:q(c)}').


test_rd('a>a','True').
test_rd('(a>a)>a','a').
test_rd('a+a','a').
test_rd('a+T','True').
test_rd('a','a').
test_rd('a&a','a').
test_rd('T&a','a').
test_rd('T&F','False').
test_rd('T+F','True').
test_rd('-(a>b)','a&-b').
test_rd('-(T)', 'False').
test_rd('-(a>(a>a))', 'False').
test_rd('a<>a', 'True').

test_fm('fm a1(y)=(! {y}(b(x,y), A=B<>c(y,x)))&d(y,y). fm a2(y)=c(y). fm a=a1(c)&a2(q). sw a2(i). pp a.').
% test_fm('fm a1(y)=! {y}{b(x,y),c(y,x)}{}&d(y,y). fm a2(y)=c(y). fm a=a1(c)&a2(q). sw a2(i). pp a.').
test_fm('i \'test.fpc\'.').

test(on, 1, '/translate/lexical', A, L, []) :-
        test1_input(A),
        q_lex_s(A,L).

% should be refactored for easier use.
test(on, 2, '/translate/conjunct', A, [], S) :-
       test2_conjunct(A),
       q_lex_s(A, L),
       q_conjunct(S, L, []).

test(on, 3, '/translate/term', A, R, S) :-
       test2_conjunct(A),
       q_lex_s(A, [_|L]),
       q_term(S, L, R).

test(on, 4, '/translate/pcf_quantifier', A, [], S) :-
       test4_pcf_quantifier(A),
       q_lex_s(A, L),
       q_pcf_quant(S, L, []).

test(on, 5, '/translate/formula', A, [], S) :-
       test5_formula(A),
       q_lex_s(A, L),
       q_formula_cmd(S, L, []).

test(on, 6, '/translate/formula/ip', A, [], S) :-
        A='!x ?y,c,f,t c>b&c(f(x))',
        q_lex_s(A, L),
        % trace,
        q_ip_formula(S, L, []).

test(on, 7, '/reduce/1', A, S, S2):-
        test_rd(A,B),
        q_tr_formula(A, [],  S),
        q_tr_formula(B, [],  S2),
        q_rd(S,S2).

test(on, 8, '/conversion/1', A, S2, Pcf):-
        test(on, 7, _, A, _, S2),
	q_to_pcf(S2, rd, Pcf),
        q_pcf_print(Pcf).

/*
test(on, 9, '/TPTP/transtation/1', nil, nil, S):-
        consult('Parser_allen/_.pl'),
        ast(I),
        ast_to_ip(I,S).
*/

test(on, 10, '/TPTP/po-conversion/1', I, nil, S):-
        test(on, 9, _,  _,  _, I),
        %I=fof(_,_,F,_),
        %q_rd(F, R),
        %write('TPTP IP:'), write(F),nl,
        %write('Reduced:'), write(R),nl,
        %trace,
        q_to_pcf(I, S, rd),
        q_pcf_pp(S,sq).

test(on, 101, '/translate/FM/1', I, [], _):-
	test_fm(I),
        q_interp(I).

test(N):-
        nl,
        test(on, N, X, I, O, S),
        write('Test:'),
	write(N), write(X), nl,
        write(I), write(' '),
        write(O),
        write(' Struct='), write(S),
        nl,
        write('Ok.'),nl, nl, fail
        .
test(_):-
        nl, write('No more successful tests.'), nl, nl.

t(X):-
        test(X).

t:-t(101).

q_tr_formula(I, R, S) :-
        q_lex_s(I,L),
        q_formula(S, L, R).

q_tr_command_list(I, R, S) :-
        q_lex_s(I,L),
        q_command_list(S, L, R).

all_ast(L):-
        findall(X, ast(X), L).

all_ast_ip(Source, IPLI, IPLO):-
        read_term(Source, ast(A), []), !,
        %format('Read: ~w ~n', [A]),
        all_ip([A],[IP]),!,
        all_ast_ip(Source, [IP|IPLI], IPLO).
all_ast_ip(Source, IPL, IPL).



all_ip([], []).
all_ip([A|TA], [IP|TI]):-
        ast_to_ip(A, fof(_,Type, IP1,_)),!,
        q_cnv_type(Type, IP1, OP1),
        q_rd(OP1, IP),!,
        all_ip(TA, TI),!.
all_ip([A|TA], [IP|TI]):-
        ast_to_ip(A, cnf(_,Type, D,_)),!,
        q_rd(disj(D), D1),
        q_cnv_cnf_type(Type, D1, OP1),
        q_rd(OP1, IP),!,
        all_ip(TA, TI),!.


q_cnv_type(conjecture, I, neg(I)):-!.
q_cnv_type(_, I, I):-!.

q_cnv_cnf_type(Type, I, ip_q(a, V, I)):-
        q_cnv_cnf_known_type(Type),
        q_collect_vars(I, [], V),
        V=[_|_],!,
        !.
q_cnv_cnf_type(Type, I, I):-
        q_cnv_cnf_known_type(Type),!.

q_cnv_cnf_known_type(negated_conjecture).
q_cnv_cnf_known_type(axiom).

q_collect_vars([], VI, VI):-!.
q_collect_vars([X], VI, VO):-!,
        q_collect_vars(X, VI, VO).
q_collect_vars([X,Y|T], VI, VO):-!,
        q_collect_vars([X], VI, RC),
        q_collect_vars([Y|T], RC, VO).
q_collect_vars(t(_), VI, VI):-!.
q_collect_vars(t(_, L), VI, VO):-!,
        q_collect_vars(L, VI, VO).
q_collect_vars(E, VI, VO):-
        E=..[Op],
        read_token_from_atom(Op, var(V)),
        (member(V, VI) -> VO=VI;
         VO=[V|VI]
         ),
        !.
q_collect_vars(E, VI, VI):-
        E=..[_],!.
q_collect_vars(E, VI, VO):-
        E=..[_|Args],!,
        q_collect_vars(Args, VI, VO).


as_conj([], t('True')):-!.
as_conj([X], conj([X])):-!.
as_conj([X,Y], conj([X,Y])):-!.
as_conj([X|T], conj([X|CT])):-!,
        as_conj(T, conj(CT)).

main(PCF):-

        write('Getting all formulas.'),nl,
        q_option(input_file, Name),
        open(Name, read, Source),
        % write(L), nl, nl,
        write('Converting to IP list.'),nl,
        all_ast_ip(Source, [], IPL), !,
        % write(IPL),
        write('Converting to conjunction.'),nl,
        as_conj(IPL, IP),!,
        write('Reduction.'),nl,
        q_rd(IP,IPR),!,
	% write(IPR), nl,
        write('Converting to PCF.'),nl,
        q_to_pcf(IPR, CPCF, rd),!,
        write('Unnaming the PCF.'),nl,
        q_pcf_unnamed(CPCF, UCPCF),!,
        % write(UCPCF),nl,nl,
        write('Converted. Reducing the PCF.'), nl,
        q_rd(UCPCF, PCF), !,
        % write(PCF), nl,
        PCF=q(a,[],_, Bases),
        %write(Bases),
        q_option(output_file_name, OName),
        format('Making Output ~w file.~n',[OName]),
        open(OName,'write', S),
        set_output(S),
        q_pcf_ppb(Bases), !,
        close(S).


m(PCF):-
        main(PCF),
        nl.

tr(Name):-
        q_set_option(input_file, Name),
        % consult(Name),
        m(PCF),
        q_pcf_print(PCF).

tr:-
        tr('input.pl').

main_program:- %notrace,
        q_set_option(output_file_name, 'result.p'),
        current_prolog_flag(argv, [_|L]),!,
        main_program(L,f).

main_program([],t):-!.
main_program([],f):-!,          % Default behaviour
%        t.
        tr.

main_program([X|T],_):-
        prog([X|T], R),!,
        main_program(R,t).

prog(['--out',Name|R], R):-!,
        q_set_option(output_file_name, Name).

prog(['--tptp',Name|R], R):-!,
        tr(Name),!.

prog(['--test', 'all' |R], R):-
        test(_),fail; true,!.

prog(['--test', SNum |R], R):-
        number_atom(Num, SNum),!,
        test(Num),fail; true,!.

prog(['--tests' |R], R):-
        test(_),fail; true,!.

prog([_|T], T):-!.

:- initialization(main_program).
