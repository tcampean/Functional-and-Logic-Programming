%removeAll(x,a1a2..an)
%if x = a1 removeAll(x,a2a3...an)
%if x != a1 a1 U removeAll(x,a2a3..an)
%
%removeAll(X-element,P - list, L - list)
%flow(i,i,0)

removeAll(_, [], []).
removeAll(X, [X|T], L):- removeAll(X, T, L),!.
removeAll(X, [H|T], [H|L]):- removeAll(X, T, L).


%count(x,a1a2...an)
% 0 if n=0
% 1+ count(x,a2a3...an), if a1 == x
% count(x,a2a3...an) otherwise

%flow(i,i,o) (i,i,i)

count(_, [], 0).
count(X, [H | T], N) :-
  H=X,
  count(X,T,N1),
  N is N1 + 1.
count(X, [H | T], N) :-
  H\=X,
  count(X, T, N).



add(X,[],[X]).
add(X,[H|T],[H|Rez]):-
    add(X,T,Rez).


%nrOccurences(a1a2...an,a1a2...an)
%[], if n = 0
%nrOccurences(a2a3...an,a1a2...an) add([a1,count(a1,a1a2...an)],[]), otherwise
%flow(i,i,o)

nrOccurences([],_,[]).
nrOccurences([H|T],Copy,R):-
    nrOccurences(T,Copy,Rez),
    add([H,C],Rez,R),
    count(H,Copy,C).

%remove_duplicates(a1a2...an)
% 0 if n = 0
%removeDuplicates(a2a3..an) if head C tail
% a1 U removeDuplicates(a2a3...an) if head !C tail
% flow(i,o)



removeDuplicates([],[]).
removeDuplicates([H|T], R) :-
    member(H, T), !,
    removeDuplicates(T, R).

removeDuplicates([H|T], [H|R]) :-
    removeDuplicates(T, R).


remove_duplicates([],[]).
remove_duplicates([H|T], [H|R]) :- 
    member(H,T),!,
    removeAll(H,T,R1),
    remove_duplicates(R1,R).

remove_duplicates([H|T],[H|R]):-
    remove_duplicates(T,R).



mainOcr(L,S):-
    nrOccurences(L,L,R),
    removeDuplicates(R,S).


mainOcr([1,2,4,1,5,2,3,8,3],L)