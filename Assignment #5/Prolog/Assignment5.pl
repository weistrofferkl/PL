% Kendall Weistroffer Assignment 5 

% Problem 1 

isMember(X, [X|_]).
isMember(X, [_|Tail]) :- isMember(X, Tail).

% Problem 2

isUnion([],[],[]).
isUnion(X, [], X).
isUnion([], Y, Y).
isUnion([X|Xs], [Y|Ys], [X,Y|Z]) :- isUnion(Xs,Ys,Z).

%Problem 3
isIntersection([],[],[]).
isIntersection(X,[],[]).
isIntersection([],Y,[]).
isIntersection([X|Xs],Y,Z):- isMember(X,Y), Z = [X|Zs], isIntersection(Xs,Y,Zs).
isIntersection([_|Xs],Y,Z):- isIntersection(Xs, Y, Z).


%Problem 4

%Checks if X is a subset of Y
helper([],_).
helper([X|Xs],Y):- isMember(X,Y), helper(Xs,Y). 

isEqual([],[]).
isEqual(X,Y):- helper(X,Y), helper(Y,X).

%Problem 5
helper2([],[],[]).
helper2([X|Xs],[],[X|Xs]).
helper2([],[Y|Ys],[]).
helper2([X|Xs],Y,Z) :- isMember(X,Y), helper2(Xs,Y,Z).
helper2([X|Xs],Y,[X|Z]) :- not(isMember(X,Y)), helper2(Xs,Y,Z).

isDifference([],[],[]).
isDifference(X,[],Z) :- isEqual(X,Z).
isDifference(X,Y,Z) :- helper2(X,Y,A), isEqual(A,Z).
isDifference([],[Y|Ys],[]).
isDifference([X|Xs],Y,Z) :- isMember(X,Y), isDifference(Xs,Y,Z).
isDifference([X|Xs],Y,[X|Z]) :- not(isMember(X,Y)), isDifference(Xs,Y,Z).



