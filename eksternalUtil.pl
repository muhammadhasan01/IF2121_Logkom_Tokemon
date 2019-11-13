/* Read dari file Eksternal */
readData(S, []) :-
    at_end_of_stream(S), !.

readData(S, [H | T]) :-
    get_char(H),
    readData(S, T).

bacaFile(NamaFile, Isi) :-
    open(NamaFile, read, S),
    repeat,
    readData(S, Isi),
    close(S), !.

/* Membaca file mengubahnya menjadi list of lines */
readFileLines(S, []) :-
    at_end_of_stream(S).

readFileLines(S, []) :-
    \+ at_end_of_stream(S),
    read(S, X),
    readFileLines(S, L).

/* Menulis ke file eksternal */
writeData(_, []) :- !.
writeData(S, [H | T]) :-
    write(S, H),
    writeData(S, T).

writeList(NamaFile, L) :-
    open(NamaFile, write, S),
    repeat,
    writeData(S, L),
    close(S).
