osoba(jan).
osoba(pawel).
osoba(adrian).
osoba(darek).
osoba(tomek).
osoba(olek).
osoba(maria).
osoba(anna).
osoba(magda).
osoba(ilona).
osoba(patrycja).
osoba(marek).

mezczyzna(jan).
mezczyzna(pawel).
mezczyzna(adrian).
mezczyzna(darek).
mezczyzna(tomek).
mezczyzna(olek).
mezczyzna(marek).

rodzic(darek,maria).
rodzic(darek,jan).
rodzic(ilona,maria).
rodzic(ilona,jan).
rodzic(tomek,olek).
rodzic(maria,olek).
rodzic(jan,pawel).
rodzic(anna,pawel).


rodzic(adrian,magda).
rodzic(patrycja,magda).
rodzic(patrycja, marek).
rodzic(olek, marek).

kobieta(X) :-
    osoba(X),
    \+mezczyzna(X).

ojciec(X,Y) :-
    rodzic(X,Y),
    mezczyzna(X).

matka(X,Y) :-
    rodzic(X,Y),
    kobieta(X).

corka(X,Y) :-
    kobieta(X),
    rodzic(Y,X).

brat_rodzony(X,Y) :-
    mezczyzna(X),
    X \= Y ,
    (   matka(M,X), matka(M,Y) 	),
    (   ojciec(O,X), ojciec(O,Y) 	).
    
brat_przyrodni(X,Y) :-
    mezczyzna(X),
    X \= Y,
    (
    	(   (   matka(M,X), \+matka(M,Y)),	(   ojciec(O,X), ojciec(O,Y)	)	);
    	(   (   matka(M,X), matka(M,Y)	),	(   ojciec(O,X), \+ojciec(O,Y)	)	)
    ).
    
% kuzyn(X,Y) :- ????

dziadek_od_strony_ojca(X,Y) :-
    mezczyzna(X),
    ojciec(O,Y),
    ojciec(X,O).

dziadek_od_strony_matki(X,Y) :-
    mezczyzna(X),
    matka(M,Y),
    ojciec(X,M).

dziadek(X,Y) :-
    mezczyzna(X),
    rodzic(R,Y),
    ojciec(X,R).

babcia(X,Y) :-
    kobieta(X),
    rodzic(R,Y),
    matka(X,R).

wnuczka(X,Y) :-
    kobieta(X),
    (   babcia(Y,X); dziadek(Y,X)	).

przodek_do2pokolenia_wstecz(X,Y) :-
    rodzic(X,Y); dziadek(X,Y); babcia(X,Y).

przodek_do3pokolenia_wstecz(X,Y) :-	
    rodzic(X,Y); ( rodzic(R,Y), przodek_do2pokolenia_wstecz(X,R)). 
