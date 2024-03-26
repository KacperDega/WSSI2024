lubi(jan,pawel).
lubi(pawel,jan).
lubi(pawel,krzysztof).
lubi(jan,bartek).
lubi(bartek,jan).
lubi(adrian,darek).
lubi(darek,adrian).
lubi(ania,darek).
lubi(darek,ania).

kobieta(ania).
mezczyzna(darek).
mezczyzna(adrian).
mezczyzna(pawel).

przyjazn(X,Y) :-
    lubi(X,Y),
    lubi(Y,X).

nieprzyjazn(X,Y) :-
    \+lubi(X,Y),
    \+lubi(Y,X).
    
niby_przyjazn(X,Y) :-
	lubi(X,Y);
    lubi(Y,X).
    
loves(X, Y) :-
    przyjazn(X, Y),
    \+ (przyjazn(X, Z), Y \= Z).
    
true_love(X,Y) :-
    loves(X,Y),
    (mezczyzna(X), kobieta(Y));
    (kobieta(X), mezczyzna(Y)).
