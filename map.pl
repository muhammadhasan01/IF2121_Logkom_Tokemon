:- dynamic(lebarPeta / 1).
:- dynamic(tinggiPeta / 1).
:- dynamic(land / 3). /* land(X, Y, jenisLand) */
:- dynamic(lokasiPlayer / 2). /* lokasiPlayer(X, Y) */
:- dynamic(countJalan / 1).
:- dynamic(munculLegendary / 1).
:- dynamic(usedTokeCenter / 2). /* usedTokeCenter(X, Y) */
:- include('eksternalUtil.pl').
:- include('player.pl').


initMap :-
    random(10, 20, X),
    random(10, 20, Y),
    assertz(sedangLawan(0)),
    assertz(munculLegendary(0)),
    assertz(countJalan(0)),
    assertz(lebarPeta(X)),
    assertz(tinggiPeta(Y)),
    assertz(lokasiPlayer(1, 1)),
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
            assertz(land(I, J, tanah))
        ))
    )),
    forall(between(XMins, XMaxs, I), (
        forall(between(YMins, YMaxs, J), (
            random(1, 100, Idx),
            genLand(Idx, Land),
            retract(land(I, J, _)),
            assertz(land(I, J, Land))
        ))
    )).


debugz :-
    lebarPeta(X),
    tinggiPeta(Y),
    write('lebarnya adalah '), write(X), nl,
    write('tingginya adalah '), write(Y), nl,
    nl, !.

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
    lokasiPlayer(X1, Y1),
    random(1, L, X),
    random(1, T, Y),
    X1 == X, Y1 == Y,
    randomLegend(L, T).

randomLegend(L, T) :-
    random(1, L, X),
    random(1, T, Y),
    retract(land(X, Y, _)),
    assertz(land(X, Y, legendPlace)), !.

generateLegend :-
    tinggiPeta(T),
    lebarPeta(L),
    randomLegend(L, T).

cekCount(X) :-
    X =\= 20, !.

cekCount(X) :-
    X =:= 20,
    write('.....Grrr....'), nl,
    write('...Grrr...'), nl,
    write('GRUWAHHHH.....'), nl,
    generateLegend,
    write('Sepertinya ada suara aneh muncul sebaiknya anda cek map.'), nl,
    retract(munculLegendary(_)),
    assertz(munculLegendary(1)),
    !.

tambahCount :-
    countJalan(X),
    XNew is X + 1,
    retract(countJalan(_)),
    assertz(countJalan(XNew)),
    cekCount(X), !.

map :-
    assertz(land(1, 1, player)),
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
    write('L : ?????'), nl, !.

writeKeterangan :-
    write('Keterangan :'), nl,
    write('P : Player'), nl,
    write('X : Pagar'), nl,
    write('T : Tokemon Center'), nl,
    write('- : Tanah Kosong'), nl,
    write('R : Rumput'), nl,
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

/* isNamaLand(namaLand) */
isBorder(border).
isTanah(tanah).
isTokCenter(tokCenter).
isLegendary(legendPlace).
isRumput(rumput).

updateLokasiPlayer(X, Y) :-
    retract(lokasiPlayer(_, _)),
    assertz(lokasiPlayer(X, Y)).

assignLokasi(X, Y, Land) :-
    retract(land(X, Y, _)),
    assertz(land(X, Y, Land)).

d :-
    takeTokemon(X),
    (X == 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.

d :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    isBorderKanan(XNew, Y),
    write('Tidak bisa bergerak kanan, ada pagar yang menghalangi!'), nl, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isBorder(Land),
    write('Tidak bisa bergerak kanan, ada pagar yang menghalangi!'), nl, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isTanah(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu berada di tanah kosong.'), nl, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isTokCenter(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isRumput(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu menginjak rumput!'),
    encounterTokemon, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isLegendary(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu bertemu dengan legendary Tokemon!'), nl,
    write('Kamu tidak bisa lari dan terpaksa untuk melawannya, bersiaplah!'), nl,
    fightLegendary, !.

a :-
    takeTokemon(X),
    (X == 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.

a :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    isBorderKanan(XNew, Y),
    write('Tidak bisa bergerak kiri, ada pagar yang menghalangi!'), nl, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isBorder(Land),
    write('Tidak bisa bergerak kiri, ada pagar yang menghalangi!'), nl, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isTanah(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu berada di tanah kosong.'), nl, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isTokCenter(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl, !.
a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isLegendary(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu bertemu dengan legendary Tokemon!'), nl,
    write('Kamu tidak bisa lari dan terpaksa untuk melawannya, bersiaplah!'), nl,
    fightLegendary, !.

w :-
    takeTokemon(X),
    (X == 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.


w :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.


w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    isBorderKanan(X, YNew),
    write('Tidak bisa bergerak atas, ada pagar yang menghalangi!'), nl, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isBorder(Land),
    write('Tidak bisa bergerak atas, ada pagar yang menghalangi!'), nl, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isTanah(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu berada di tanah kosong.'), nl, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isTokCenter(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isLegendary(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu bertemu dengan legendary Tokemon!'), nl,
    write('Kamu tidak bisa lari dan terpaksa untuk melawannya, bersiaplah!'), nl,
    fightLegendary, !.

s :-
    takeTokemon(X),
    (X == 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.


s :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.


s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    isBorderKanan(X, YNew),
    write('Tidak bisa bergerak ke bawah, ada pagar yang menghalangi!'), nl, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isBorder(Land),
    write('Tidak bisa bergerak ke bawah, ada pagar yang menghalangi!'), nl, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isTanah(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu berada di tanah kosong.'), nl, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isTokCenter(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isLegendary(Land),
    updateLokasiPlayer(X, YNew),
    tambahCount,
    write('Kamu bertemu dengan legendary Tokemon!'), nl,
    write('Kamu tidak bisa lari dan terpaksa untuk melawannya, bersiaplah!'), nl,
    fightLegendary, !.

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
    assertz(usedTokeCenter(X, Y)),
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
