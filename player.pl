:- dynamic(inventori / 1). /* inventori(listTokemon) */
:- dynamic(healthID / 2). /* healthID(Id, healthPoint) */
:- include('utils.pl').
:- include('tokemon.pl').


inventori([]).
healthID(1, -1).
healthID(2, -1).
healthID(3, -1).
healthID(4, -1).
healthID(5, -1).
healthID(6, -1).

recovery([], _) :- !.
recovery([A | Tail], Id) :-
    retract(healthID(Id, _)),
    health(A, HealthPoint),
    assertz(Id, HealthPoint),
    NewId is Id + 1,
    recovery(Tail, NewId), !.

getLength(X) :-
    inventori(Tokemons),
    length(Tokemons, X), !.

printStatusTokemon(A, Id) :-
    write('Tokemon\t: '), write(A), nl,
    healthID(Id, Darah),
    write('Health \t: '), write(Darah), nl,
    type(A, Tipe),
    write('Tipe \t: '), write(Tipe), nl, nl.

printStatus([], _) :- !.
printStatus([A | Tail], Nomor) :-
    write('--- Tokemon #'), write(Nomor), write(' ----'), nl,
    printStatusTokemon(A, Nomor),
    NomorBaru is Nomor + 1,
    printStatus(Tail, NomorBaru), !.

status :-
    getLength(Len),
    Len == 0,
    write('Kau belum mempunyai tokemon!'), nl, !.

status :-
    inventori(X),
    nl, write('Status Tokemon-Tokemon mu adalah :'), nl, nl,
    printStatus(X, 1).

assignTokemons(X) :-
    retract(inventori(_)),
    assertz(inventori(X)).

addTokemon(Tokemon, Health) :-
    getLength(Len),
    Len =:= 6 ->
    (
        write('Tidak bisa menambah Tokemon '), write(Tokemon), nl,
        write('Tokemon di Inventorimu sudah terlalu banyak!'), nl,
        write('Coba remove salah satu tokemonmu dulu.'), nl
    );
    (
        inventori(Tokemons),
        append(Tokemons, [Tokemon], NewTokemons),
        getLength(Len),
        Idx is Len + 1,
        retract(healthID(Idx, _)),
        assertz(healthID(Idx, Health)),
        assignTokemons(NewTokemons),
        write('Tokemon '),
        write(Tokemon),
        write(' berhasil dimasukkan ke Inventori!'), nl
    ), !.

printTokemons([], _) :- !.
printTokemons([A | Tail], Nomor) :-
    write('#'), write(Nomor), write('. '), write(A), write('.'), nl,
    NomorBaru is Nomor + 1,
    printTokemons(Tail, NomorBaru).

updateHealth(X, Y) :-
    (X == Y), !.

updateHealth(X, Y) :-
    X1 is X + 1,
    healthID(X1, Health),
    retract(healthID(X, _)),
    assertz(healthID(X, Health)),
    updateHealth(X1, Y).

drop(X) :-
    X < 1,
    write('Indeks tidak valid, silahkan coba lagi.'), !.

drop(X) :-
    getLength(Len),
    X > Len,
    write('Indeks tidak valid, silahkan coba lagi.'), !.

drop(X) :-
    getLength(Len),
    Len == 1, X == 1,
    write('Tidak dapat remove Tokemon'), nl,
    write('Kau hanya mempunyai 1 Tokemon!'), nl, !.

drop(X) :-
    getLength(Len),
    X > 0,
    X < Len + 1,
    inventori(Tokemons),
    Idx is X - 1,
    ambil(Tokemons, Idx, Tokemon),
    write('Tokemon '), write(Tokemon), write(' berhasil diremove!'), nl,
    hapus(Tokemons, HasilBuang, Idx),
    updateHealth(X, Len),
    assignTokemons(HasilBuang), !.



remove :-
    getLength(Len),
    Len == 1,
    write('Tidak dapat remove Tokemon'), nl,
    write('Kau hanya mempunyai 1 Tokemon!'), nl, !.

remove :-
    getLength(Len),
    Len > 1,
    write('Tokemon-tokenmu adalah :'), nl,
    inventori(Tokemons),
    printTokemons(Tokemons, 1), nl,
    write('Pilih nomor tokemon yang ingin diremove dengan menggunakan drop(nomor).'), nl,
    write('Contoh : drop(1).'), nl,
    write('Maka tokemon nomor 1 akan diremove.'), !.
