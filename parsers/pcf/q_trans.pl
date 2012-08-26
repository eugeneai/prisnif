
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

q_lex(Stream, L) :-
        read_token(Stream, Term),!,
        (
           Term=punct(end_of_file),
           L=[],!;
           !,
           q_conv_lex(Term, T),
           q_lex(Stream, Tail),
           app(T, Tail, L)
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

q_rd(cmd_fm(T, F), O):-
        q_rd(F,R),
        q_rr(cmd_fm(T, R), O).
q_rd(neg(A), O):-
	q_rd(A,A1),
        q_rr(neg(A1), O).
q_rd(conj(L), O):-
	q_rd_elems(L,L1),
        q_rr(conj(L1), O).
q_rd(disj(L), O):-
        q_rd_elems(L,L1),
        q_rr(disj(L1), O).
q_rd(imp(A,B), O):-
        q_rd(A,A1),
        q_rd(B,B1),
        q_rr(imp(A1,B1), O).
q_rd(ip_q(S,L,I), O):-
        q_r_dups(L,L1),
        q_rd(I,I1),
        q_rr(ip_q(S,L1,I1), O).
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

q_r(conj(L), R):- member(t('True'), L),!,
        q_remove_in(L, t('True'), R).
q_r(disj(L), R):- member(t('False'), L),!,
        q_remove_in(L, t('False'), R).

q_r(conj(L), t('False')):-
        member(A, L),
        member(neg(A), L),
        !.
q_r(disj(L), t('True')):-
        member(A, L),
        member(neg(A), L),
        !.

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

q_alter_q(a,e).
q_alter_q(e,a).

q_all_neg([],[]):-!.
q_all_neg([X|T],[neg(X)|R]):-
        q_all_neg(T,R).

/*
q_del_all(_, [], []).
q_del_all(X, [X|T], R):-!,
        q_a_del_all(X, T, R).
q_del_all(X, [Y|T], [Y|R]):-!,
        q_a_del_all(X, T, R).
*/

q_del_all(_, L, L). % FIXME: STUB to compile.

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
q_remove_in([A|T], _, [A|R]):-
        q_remove_in(T, A, R).


% XXX stack overflow on a + ~a.


% --------- Conversion to PCF, RD=rd if defined adds reduction step ---
q_to_pcf(fof(_, _, A, _), B):-!,
        % q_rd(A,A1),!,
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
%        write('-1a----a-a'), write([L,I]),nl,nl,
        q_to_pcf_a_a(I, T,F).

q_to_pcf_a(ip_q(e,L,I), q(a,[],[],[O])):-!,
%        write('-2a----a-e'), write([L,I]),nl,nl,
        q_to_pcf_e(ip_q(e,L,I), O).

q_to_pcf_a(I, q(a,[], T,F)):-
%        write('-3a----a-X'), write([L,I]),nl,nl,
        q_to_pcf_a_a(I, T,F).

q_to_pcf_e(ip_q(a,L,I), q(e,[],[],[O])):-!,
%        write('-1e----e-a'), write([L,I]),nl,nl,
        q_to_pcf_a(ip_q(a, L,I), O).

q_to_pcf_e(ip_q(e,L,I), q(e,L, T,F)):-!,
%        write('-2e----e-e'), write([L,I]),nl,nl,
        q_to_pcf_e_e(I, T,F).

q_to_pcf_e(I, q(e,[], T,F)):-
%        write('-3e----e-X'), write([I]),nl,nl,
        q_to_pcf_e_e(I, T,F).

% individual conversion

q_cnv_term(t(_)):-!.
q_cnv_term(t(_,_)):-!.

% split conjunction on two subconjuncts: first one is conjunction of atoms, other one is more complex formulae.

q_split_conj([],[],[]).
q_split_conj([X|T],[X|CA],CF):-
	q_cnv_term(X),!,
	q_split_conj(T,CA,CF).
q_split_conj([X|T],CA,[X|CF]):-
	q_split_conj(T,CA,CF).

q_to_pcf_a_a(imp(A,B), [A], [F]):-
        q_cnv_term(A),!,
	% XXX if B is a disjunction. It could be properly translated here
        q_to_pcf_e(B, F).

q_to_pcf_a_a(imp(conj(L),B), C, [FE]):-
	q_split_conj(L, C, FF),
        (
         FF=[], !, F=B;
         q_rd(disj([neg(conj(FF)),B]), F)
        ),
        q_to_pcf_e(F, FE).

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
	q_split_conj(L, C, FF),!,
        q_to_pcf_e_e_l(FF, F).

q_to_pcf_e_e(imp(A,B), [], [F]):-!,
        q_to_pcf_a(imp(A,B), F).

q_to_pcf_e_e(disj(L), [], [F]):-!,
        q_to_pcf_a(disj(L), F).

q_to_pcf_e_e(neg(A), [], [F]):-!,
        q_to_pcf_a(neg(A), F).

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
        write('Pr:'),write(Q),nl,
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

write_l([X]):-!,
        write(X).
write_l([X|T]):-
        is_true(X),!,
        write_l(T).
write_l([X|T]):-!,
        write_l([X]), write(','),
        write_l(T).

% Prisnif print.

q_pcf_pp(q(S,X,T,L)):-!,
        write(S),
        write('['),write_l(X),write(']'),
        write('['),write_l(T),write(']'),
        write('{'), q_pcf_ppl(L),write('}').

q_pcf_pp(F, sq):-
        write('{'),
        q_pcf_pp(F),!,
        write('}'),
        nl.

q_pcf_ppb([Bases]):-!,
        write('{'),
        q_pcf_ppl([Bases]),!,
        write('}'),
        nl.



q_pcf_ppl([]):-!.
q_pcf_ppl([X]):-!,
        q_pcf_pp(X).
q_pcf_ppl([X|T]):-!,
        q_pcf_pp(X),!,
        write('; '),
        q_pcf_ppl(T).

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

%ap(s(

/*
ap(s(defined_atom, FS), F):-!,
        ap(FS, F).
ap(s(system_atom, FS), F):-!,
        ap(FS, F).
*/

ap(I,c__(I)).


%connectives ----------------

bcn('<=>', F1, F2, equ(F1,F2)):-!.

bcn('=>', F1, F2, imp(F1,F2)):-!.

bcn(C, F1, F2, bc(C, F1, F2)).

uo('~', F, neg(F)):-!.

uo(O,F, unary_(O,F)).

%-------------------------------------------------------------
% Translator of the language used in Eugene Cherkashin's PH.D.

q_command_list([C]) --> q_command(C),  q_command_end.
q_command_list([C|T]) --> q_command(C),  q_command_end, q_command_list(T).

q_command(cmd(show, Param)) --> [sw], q_command_show(Param).
q_command(cmd(formula, T, Exp)) --> [fm], q_command_fm(T, Exp).

q_command_end --> [full_stop].

q_command_show(P) --> q_term(P).
q_command_fm(P, Exp) --> q_term(P), ['='], q_formula(Exp).

%-------------------------------------------------------------
% Command Executors ($$$)
q_do_command_list([]):-!.
q_do_command_list([C|T]):-
	q_do_command(C),
	q_do_command_list(T).

q_do_command(cmd(show, Param)):-!,
	write('SHOW:'),
	write(Param), nl.

q_do_command(_):-
	write('Command not supported'), nl.


% -----------------------------------------------------------------------------------------------------------
% Functional tests

test1_input('v(x,y,z), K(v), p(K(v)), P{}[]$!@#$^&*(), a^b, a>b, a&b').
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

test(on, 101, '/translate/FM/1', I, O, S):-
	I='fm a(x)=a>b. sw a(c).',
	q_tr_command_list(I,O,S),
	q_do_command_list(S).

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


% Just query AST as IP converted and reduced.

/*
aip(IPR):-
        ast(I),
        ast_to_ip(I, fof(_, _, IP, _)),
        q_rd(IP, IPR).
*/

% FIXME: STUB to compile.

all_ast(L):-
        findall(X, ast(X), L).

all_ip([], []).
all_ip([A|TA], [IP|TI]):-!,
        ast_to_ip(A, fof(_,_, IP1,_)),!,
        q_rd(IP1, IP),!,
        all_ip(TA, TI),!.


as_conj([], t('True')):-!.
as_conj([X], conj([X])):-!.
as_conj([X,Y], conj([X,Y])):-!.
as_conj([X|T], conj([X|CT])):-!,
        as_conj(T, conj(CT)).

main(PCF):-

        write('Getting all formulas.'),nl,
        all_ast(L),
        % write(L), nl, nl,
        write('Converting to IP list.'),nl,
        all_ip(L, IPL),!,
        % write(IPL),
        write('Converting to conjunction.'),nl,
        as_conj(IPL, IP),!,
        write('Reduction.'),nl,
        q_rd(IP,IPR),!,
	write(IPR), nl,
        write('Converting to PCF.'),nl,
        q_to_pcf(IPR, PCF, rd),!,
        write('Converted'), nl,
        % write(PCF), nl,
        PCF=q(a,[],_, Bases),
        %write(Bases),
        write('Making Output result.p file.'),nl,
        open('result.p','write', S),
        set_output(S),
        q_pcf_ppb(Bases),
        close(S).


m(PCF):-
        main(PCF),
        nl.

tr:-
        consult('input.pl'),
        m(PCF),
        q_pcf_print(PCF).


:- initialization(tr).
