%firsTwo(L - list, A - Elem, B - Elem)
%firsTwo([a1a2...an], A, B) = 
%	A = a1
%	B = a2
%flow(i,o,o)

firsTwo([H1, H2| _], H1,H2).

%subtract(A - Number, B - Number, R - Number)
%subtract(A, B) =
% 	if A > B, then A - B
% 	otherwise, B - A
%flow(i, i, o)

subtract(A, B, R) :-
    A > B,
    R is A - B, !.
subtract(A, B, R) :-
    B >= A,
    R is B - A.

%createSequences(S - Number, N - Number, R - List)
%createSequences(S,N) =
% 	[], if S = N + 1
% 	S U createSequences(S+1,N), if S <= N
% 	createSequences(S+1,N), if S <= N
%flow(i,i,o)

createSequences(S, N, []) :- S =:= N + 1, !.
createSequences(S, N, [S|R]) :-
    S =< N,
    NS is S + 1,
    createSequences(NS, N, R).
createSequences(S, N, R) :-
    S =< N,
    NS is S + 1,
    createSequences(NS, N, R).


%biggerThanM(L - List , M - Number)
%biggerThanM(L,M) =
%	True, if n = 2 and subtract(a1,a2) >= M
%	biggerThanM(a2a3..an), subtract(a1,a2) >= M
% 	False, otherwise
%flow(i,i)


biggerThanM([H,H1],M):-
    subtract(H,H1,R),
    R >= M, !.
biggerThanM([H|T], M) :-
    firsTwo([H|T],A,B),
    subtract(A, B, R),
    R >= M,
    biggerThanM(T, M).

%oneSolution(N - Number, M - Number,R - List)
%oneSolution(N,M) =
%	createSequences(1,N) and biggerThanM(createSequences(1,N),M)
%flow(i,i,o)

oneSolution(N, M, R) :-
    createSequences(1,N, R),
    biggerThanM(R, M).

%allSolutions(N - Number, M - Number, R - List)
%flow(i,i,o)

allSolutions(N, M, R) :-
    findall(RPartial, oneSolution(N, M, RPartial), R).