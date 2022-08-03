% knowledge base
flight(istanbul, izmir, 2).
flight(izmir, istanbul, 2).
flight(istanbul, ankara, 1).
flight(ankara,istanbul, 1).
flight(istanbul, rize, 4).
flight(rize, istanbul, 4).
flight(ankara, rize, 5).
flight(rize,ankara, 5).
flight(ankara, van, 5).
flight(van, ankara, 5).
flight(ankara, izmir, 6).
flight(izmir,ankara, 6).
flight(ankara, diyarbakir, 8).
flight(diyarbakir,ankara,  8).
flight(antalya, izmir, 2).
flight(izmir,antalya, 2).
flight(van, gaziantep, 3).
flight(gaziantep, van, 3).
flight(antalya, diyarbakir, 4).
flight(diyarbakir,antalya, 4).
flight(antalya, erzincan, 3).
flight(erzincan,antalya, 3).
flight(canakkale, erzincan, 6).
flight(erzincan,canakkale, 6).

% rules
route(X,Y,C):-
    route_all(X,Y,C,[]) ; flight(X,Y,C).
    
route_all(X,Y,C,LIST) :-
    flight(X,Y,C);
route_all(X,Y,C,LIST) :-
    flight(X,Y,C);
    \+ member(X , LIST), flight(X , Z , C1), route_all(Z , Y , C2 , [X|LIST]), X\=Y, C is C1+ C2.