:- dynamic(lebarPeta / 1).
:- dynamic(tinggiPeta / 1).
:- dynamic(land / 3). /* land(X, Y, jenisLand) */
:- dynamic(lokasiPlayer / 2). /* lokasiPlayer(X, Y) */
:- dynamic(countJalan / 1).
:- dynamic(munculLegendary / 1).
:- dynamic(usedTokeCenter / 2). /* usedTokeCenter(X, Y) */
:- include('eksternalUtil.pl').
:- include('player.pl').

munculLegendary(0).
countJalan(0).
lebarPeta(0).
tinggiPeta(0).
lokasiPlayer(0, 0).
land(0, 0, border).
usedTokeCenter(0, 0).

initMap :-
    random(13, 20, X),
    random(13, 20, Y),
    retract(lebarPeta(_)),
    asserta(lebarPeta(X)),
    retract(tinggiPeta(_)),
    asserta(tinggiPeta(Y)),
    retract(lokasiPlayer(_, _)),
    asserta(lokasiPlayer(1, 1)),
    generateLand.

generateLand :-
    lebarPeta(L),
    tinggiPeta(T),
    XMin is 1,
    XMax is L,
    YMin is 1,
    YMax is T,
    XMins is 2,
    XMaxs is L - 1,
    YMins is 2,
    YMaxs is T - 1,
    forall(between(XMin, XMax, I), (
        forall(between(YMin, YMax, J), (
            asserta(land(I, J, tanah))
        ))
    )),
    forall(between(XMins, XMaxs, I), (
        forall(between(YMins, YMaxs, J), (
            random(1, 100, Idx),
            genLand(Idx, Land),
            retract(land(I, J, _)),
            asserta(land(I, J, Land))
        ))
    )),
    retract(land(XMax, YMax, _)),
    asserta(land(XMax, YMax, superLegendary)),
    !.


printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isSuperLegendary(NamaLand), !,
    write('F').

printKoordinat(X, Y) :-
    lokasiPlayer(X1, Y1),
    (X == X1), (Y == Y1), !,
    write('P').

printKoordinat(X, Y) :-
    isBorderAtas(X, Y), !,
    write('X').

printKoordinat(X, Y) :-
    isBorderBawah(X, Y), !,
    write('X').

printKoordinat(X, Y) :-
    isBorderKiri(X, Y), !,
    write('X').

printKoordinat(X, Y) :-
    isBorderKanan(X, Y), !,
    write('X').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isBorder(NamaLand),
    !, write('x').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isTanah(NamaLand),
    !, write('-').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isTokCenter(NamaLand),
    !, write('T').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isTokCenter(NamaLand),
    !, write('T').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isLegendary(NamaLand),
    !, write('L').

printKoordinat(X, Y) :-
    land(X, Y, NamaLand),
    isRumput(NamaLand),
    !, write('R').

randomLegend(L, T) :-
    random(1, L, X),
    random(1, T, Y),
    land(X, Y, NamaLand),
    isSuperLegendary(NamaLand),
    randomLegend(L, T).

randomLegend(L, T) :-
    lokasiPlayer(X1, Y1),
    random(1, L, X),
    random(1, T, Y),
    X1 == X, Y1 == Y,
    randomLegend(L, T).

randomLegend(L, T) :-
    random(1, L, X),
    random(1, T, Y),
    retract(land(X, Y, _)),
    asserta(land(X, Y, legendPlace)), !.

generateLegend :-
    tinggiPeta(T),
    lebarPeta(L),
    randomLegend(L, T).

cekCount(X) :-
    X =\= 20, !.

cekCount(X) :-
    X =:= 20,
    nl, nl,
    write('--------------'), nl,
    write('...Grrr.....'), nl,
    write('.....Grrr...'), nl,
    write('GRUWAHHHH.....'), nl,
    write('--------------'), nl,
    nl,
    generateLegend,
    write('Sepertinya ada suara aneh muncul sebaiknya anda cek map.'), nl,
    retract(munculLegendary(_)),
    asserta(munculLegendary(1)),
    !.

tambahCount :-
    countJalan(X),
    XNew is X + 1,
    retract(countJalan(_)),
    asserta(countJalan(XNew)),
    cekCount(X), !.

map :-
    asserta(land(1, 1, player)),
    tinggiPeta(T),
    lebarPeta(L),
    XMin is 0,
    XMax is L,
    YMin is 1,
    YMax is T,
    forall(between(XMin, XMax, I),(
        printKoordinat(I, 0), write('X')
    )), write('X'), nl,
    forall(between(YMin, YMax, J), (
        forall(between(XMin, XMax, I), (
            printKoordinat(I, J), write(' ')
        )),
        write('X'), nl
    )),
    forall(between(XMin, XMax, I),(
        printKoordinat(I, 0), write('X')
    )), write('X'), nl, nl,
    writeKeterangan, !.

writeKeterangan :-
    munculLegendary(X),
    (X == 1),
    write('Keterangan :'), nl,
    write('P : Player'), nl,
    write('X : Pagar'), nl,
    write('T : Tokemon Center'), nl,
    write('- : Tanah Kosong'), nl,
    write('R : Rumput'), nl,
    write('F : Final Battle'), nl,
    write('L : ?????'), nl, !.

writeKeterangan :-
    write('Keterangan :'), nl,
    write('P : Player'), nl,
    write('X : Pagar'), nl,
    write('T : Tokemon Center'), nl,
    write('- : Tanah Kosong'), nl,
    write('R : Rumput'), nl,
    write('F : Final Battle'), nl,
    !.

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

/* namaLand(nama) */
namaLand(border).
namaLand(tanah).
namaLand(tokCenter).
namaLand(rumput).
namaLand(superLegendary).

/* isNamaLand(namaLand) */
isBorder(border).
isTanah(tanah).
isTokCenter(tokCenter).
isLegendary(legendPlace).
isRumput(rumput).
isSuperLegendary(superLegendary).

updateLokasiPlayer(X, Y) :-
    retract(lokasiPlayer(_, _)),
    asserta(lokasiPlayer(X, Y)).

assignLokasi(X, Y, Land) :-
    retract(land(X, Y, _)),
    asserta(land(X, Y, Land)).

restore :-
    lokasiPlayer(X, Y),
    land(X, Y, Land),
    \+isTokCenter(Land),
    write('Kamu tidak berada di TokeCenter'), !.

restore :-
    lokasiPlayer(X, Y),
    land(X, Y, Land),
    isTokCenter(Land),
    usedTokeCenter(X, Y),
    write('Tokemon Center ini sudah pernah dipakai!'), nl, !.

restore :-
    lokasiPlayer(X, Y),
    land(X, Y, Land),
    isTokCenter(Land),
    \+usedTokeCenter(X, Y),
    asserta(usedTokeCenter(X, Y)),
    restoreTokemon,
    write('Tokemon anda berhasil direstore!'), nl, !.

genLand(X, Y) :-
    X > 0,
    X < 26,
    isRumput(Y), !.

genLand(X, Y) :-
    X > 26,
    X < 76,
    isTanah(Y), !.

genLand(X, Y) :-
    X > 75,
    X < 81,
    isTokCenter(Y), !.

genLand(X, Y) :-
    X > 80,
    X < 101,
    isBorder(Y), !.
