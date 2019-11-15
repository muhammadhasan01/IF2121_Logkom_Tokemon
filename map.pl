:- dynamic(lebarPeta / 1).
:- dynamic(tinggiPeta / 1).
:- dynamic(land / 3). /* land(X, Y, jenisLand) */
:- include('eksternalUtil.pl').
:- include('player.pl').


initMap :-
    random(10, 20, X),
    random(10, 20, Y),
    assertz(lebarPeta(X)),
    assertz(tinggiPeta(Y)),
    generateLand, !.

listLand(['P', 'X', '-', 'G']).

isBorderAtas(_, Y) :-
    Y =:= 0,
    !.
isBorderKiri(X, _) :-
    X =:= 0,
    !.
isBorderBawah(_, Y) :-
    tinggiPeta(T),
    YMax is T + 1,
    Y =:= YMax,
    !.
isBorderKanan(X, _) :-
    lebarPeta(L),
    XMax is L + 1,
    X =:= XMax,
    !.

generateLand :-
    lebarPeta(L),
    tinggiPeta(T),
    XMin is 1,
    XMax is L,
    YMin is 1,
    YMax is T,
    forall(between(XMin, XMax, I), (
        forall(between(YMin, YMax, J), (
            length(listLand, Len),
            random(0, Len, NoLand),
            ambil(listLand, NoLand, Land),
            assertz(land(I, J, Land))
        ))
    )), !.
