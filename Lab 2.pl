%modify(x,y,a1a2a3...an)
%if x = a1 , y U modify(x,y,a2a3..an)
%if x != a1 , a1 U modify(x,y,a2a3..an)
%modify(X - element , Y - element, P - list, L - list)
%flow(i,i,i,0)

modify(_,_, [], []).
modify(X,Y, [X|T], [Y|L]):- modify(X,Y, T, L),!.
modify(X,Y, [H|T], [H|L]):- modify(X,Y, T, L).


% max(A - number, B- number, R-number)
% max(a, b)
% if a >= b, a
% if a < b, b
% flow(i, i, o)

max(A, B, A) :- A >= B.
max(A, B, B) :- A < B.

% maxList(L - list, R - number)
% maxList(a1...an) =
% if n = 1, a1
% if a1 is number, then max(a1, maxList(a2...an)
% otherwise, maxList(a2...an), otherwise
% flow(i, o)

maxList([H], H).
maxList([H|T], R) :- number(H), !,
    maxList(T, RM),
    max(H, RM, R).
maxList([_|T], R) :- 
    maxList(T, R).

% heterList(L - list, R - list)
% if n = 0 , []
% if a1 is a list then modify(a1, m, maxList(a1)) U heterList(a2...an, m)
% otherwise a1 U heterList(a2...an, m)
% flow(i, o)

heterList([], _, []).
heterList([H|T], M, [HR|R]) :- is_list(H), !,
    maxList(H, LM),
    modify(M, LM, H, HR),
    heterList(T, M, R).
heterList([H|T], M, [H|R]) :-
    heterList(T, M, R).

% mainHeter(L - list, R - list)
%flow(i,o)


mainHeter(L, R) :- 
    maxList(L, LM),
    heterList(L, LM, R).
    

mainHeter([1, [2, 5, 7], 4, 5, [1, 4], 3, [1, 3, 5, 8, 5, 4], 5, [5, 9, 1], 2],L).