/* --- LIST --- */

/* kosong(List) */
kosong([]).

/* cari(List,CharDicari,Indexnya) */
cari([], _, -1): -!.
cari([C | _], C, 0): -!.
cari([_ | Tail], C, IndexBaru): -cari(Tail, C, Index), Index\ = -1, IndexBaru is Index + 1, !.
cari(_, _, -1): -!.

/* change(LLama,LBaru,C,Indeks). */
change([_ | Tail], [C | Tail], C, 0): -!.
change([A | Tail], [A | LBaru], C, Indeks): -IndeksBaru is Indeks - 1, change(Tail, LBaru, C, IndeksBaru).

/* ambil(L,Pos,C) */
ambil([], 0, ''): -!.
ambil([C | _], 0, C): -!.
ambil([_ | LTail], Pos, C): -PosBaru is(Pos - 1), ambil(LTail, PosBaru, C), !.

/* hapus(LLama, LBaru, Indeks). */
hapus([], [], _): -!.
hapus([_ | Tail], Tail, 0): -!.
hapus([Head | Tail], [Head | Hasil], Indeks): -IndeksBaru is Indeks - 1, hapus(Tail, Hasil, IndeksBaru), !.

/* printList(List). */
printList([]): -!.
printList([A | Tail]): -
    write(A), printList(Tail), !.

printList2D([]): -!.
printList2D([A | Tail]): -
    printList(A), nl, printList2D(Tail), !.

/* ambilN(L,N,LN) */
ambilN(_, 0, []): -!.
ambilN([Head | Tail], N, [Head | Hasil]): -NBaru is N - 1, ambilN(Tail, NBaru, Hasil), !.

/* buangN(L,N,LN) */
buangN(L, 0, L): -!.
buangN([_ | Tail], N, Hasil): -NBaru is N - 1, buangN(Tail, NBaru, Hasil), !.

/* splitList(L,C,LBaru) */
splitList([], _, []): -!.
splitList(L, C, [Temp | Hasil]): -
    cari(L, C, Idx),
    Idx\ = -1,
    ambilN(L, Idx, Temp),
    IdxBaru is Idx + 1,
    buangN(L, IdxBaru, LBaru),
    splitList(LBaru, C, Hasil), !.
splitList(L, C, [L]): -
    cari(L, C, Idx),
    Idx =: = -1, !.

listToStr([], ''): -!.
listToStr([C | Tail], S): -
    listToStr(Tail, S2),
    atom_concat(C, S2, S), !.

/* appendList(L,X,LHasil) */
appendList(L, X, [X | L]).

/* concatList(L1,L2,L3) */
concatList([], L, L): -!.
concatList([Head | Tail], L, Hasil): -
    concatList(Tail, L, Temp),
    appendList(Temp, Head, Hasil), !.
/* 	assertaList(ListFakta)
	meng-asserta semua fakta dalam ListFakta  */
assertaList([]): -!.

assertaList([X | L]): -
    asserta(X),
    assertaList(L), !.

/* --- PAIR --- */
make_pair(First, Second, [First, Second]).
first([First | _], First).
second([_, Second], Second).
