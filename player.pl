:- dynamic(inventori / 1). /* inventori(listTokemon) */
:- include('utils.pl').
:- include('tokemon.pl').

inventori([goku, naruto, thanos]).

getLength(X) :-
    inventori(Tokemons),
    length(Tokemons, X), !.

printStatusTokemon(A) :-
    write('Tokemon\t: '), write(A), nl,
    health(A, Darah),
    write('Health \t: '), write(Darah), nl,
    type(A, Tipe),
    write('Tipe \t: '), write(Tipe), nl, nl.

printStatus([], _) :- !.
printStatus([A | Tail], Nomor) :-
    write('--- Tokemon #'), write(Nomor), write(' ----'), nl,
    printStatusTokemon(A),
    NomorBaru is Nomor + 1,
    printStatus(Tail, NomorBaru), !.

status :-
    inventori(X),
    write('Status Tokemon-Tokemon mu adalah :'), nl,
    printStatus(X, 1).

assignTokemons(X) :-
    retract(inventori(_)),
    assertz(inventori(X)).

addTokemon(Tokemon) :-
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
        assignTokemons(NewTokemons),
        write('Tokemon bernama '),
        write(Tokemon),
        write(' berhasil dimasukkan ke Inventori!'), nl
    ), !.

printTokemons([], _) :- !.
printTokemons([A | Tail], Nomor) :-
    write('#'), write(Nomor), write('. '), write(A), write('.'), nl,
    NomorBaru is Nomor + 1,
    printTokemons(Tail, NomorBaru).

drop(X) :-
    X < 1,
    write('Indeks tidak valid, silahkan coba lagi.'), !.

drop(X) :-
    getLength(Len),
    X > Len,
    write('Indeks tidak valid, silahkan coba lagi.'), !.

drop(X) :-
    getLength(Len),
    X > 0,
    X < Len + 1,
    inventori(Tokemons),
    Idx is X - 1,
    ambil(Tokemons, Idx, Tokemon),
    write('Tokemon '), write(Tokemon), write(' berhasil diremove!'), nl,
    hapus(Tokemons, HasilBuang, Idx),
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
    write('Pilih nomor tokemon yang ingin diremove dengan menggunakan drop(nomor)!'), nl,
    write('Contoh : drop(1).'), nl,
    write('Maka tokemon nomor 1 akan diremove.'), !.
