/*
Tubes Logika Komputasional - Tokemon
Kelompok 7 - K3 :
Muhammad Hasan - 13518012
Hafshy Yazid Albisthami - 13518051
Arthur Edgar Yunanto - 13518090
Yan Arie Motinggo - 13518129
*/
:- dynamic(gameState / 1). /* gameState(isGameOn/Off) */
:- dynamic(takeTokemon / 1). /* takeTokemon(isTake) */
:- include('player.pl').

gameState(0).
takeTokemon(0).
turnOnGame :-
    retract(gameState(_)),
    assertz(gameState(1)).

start :-
    gameState(X),
    X == 1,
    write('Kamu sudah memulai game!'), nl, !.

start :-
    turnOnGame,
    write('Tokemon~'), nl,
    write('Tokemon~'), nl,
    write('Dimana Kamu?~'), nl,
    write('Aku ingin menangkapmu~'), nl,
    write('Pada suatu hari, kamu sebagai mahasiswa IF yang tidak ambis, '), nl,
    write('kamu sedang mengerjakan tugas besar. Namun, kamu teringat'), nl,
    write('bahwa kamu belum bermain game kesayanganmu. Hari itu terasa'), nl,
    write('seperti ada yang aneh namun kamu tak memperdulikannya.'), nl,
    write('Saat asyique bermain tiba-tiba cahaya yang sangat terang dari layar menyinarimu!'), nl,
    write('Kamu pun tak sadarkan diri setelah melihatnya.'), nl,
    write('Dan kamu terbangun di dunia TOKEMON sambil dihampiri seorang profesor.'), nl,
    write('Sang Profesor menjelaskan mengenai dunia tersebut dan satu-satunya'), nl,
    write('cara untuk keluar dari dunia tersebut dan melanjutkan tugas besar,'), nl,
    write('adalah dengan menjadi The Very Best Tokemon Trainer Like No One Ever Was!'),

    nl, nl, write(' --- TOKEMON ---'), nl, nl,


    write('Tanpa ragu-ragu lagi, Profesor langsung memberi kamu 3 Tokemon piihan dia'), nl,
    write('Kamu disuruh memilih salah satu!'), nl, nl,
    write('--- Choose Your Starting Tokemon ---'), nl,
    write('#1 goku (Tipe : earth)'), nl,
    write('#2 naruto (Tipe : wind)'), nl,
    write('#3 usopp (Tipe : leaf)'), nl, nl,
    write('Pilih salah satu dengan mengetik pilih(nomor).'), nl,
    write('Contoh : pilih(2). artinya kamu akan memlih naruto'), nl, !.

pilih(X) :-
    gameState(Y),
    Y == 0, X == X,
    write('Kamu belum memulai game :('), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 1, X == X,
    write('Kamu sudah memlih tokemon starter!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X < 1,
    write('Pilihan indeks tidak valid!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X > 3,
    write('Pilihan indeks tidak valid!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X == 1,
    nl, write('Kau memilih goku sebagai Tokemon Startermu!'), nl,
    addTokemon(goku, 350),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X == 2,
    nl, write('Kau memilih naruto sebagai Tokemon Startermu!'), nl,
    addTokemon(naruto, 330),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X == 3,
    nl, write('Kau memilih usopp sebagai Tokemon Startermu!'), nl,
    addTokemon(usopp, 360),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

help :-
    write('Daftar Command : '), nl,
    write('1. start : Untuk Memulai Permainan.'), nl,
    write('2. map : Menampilkan Seluruh Peta Permainan.'), nl,
    write('3. status : Menampilkan Status Tokemonmu di Inventori'), nl,
    write('4. w : Bergerak ke arah Atas (Utara).'), nl,
    write('5. s : Bergerak ke arah Bawah (Selatan).'), nl,
    write('6. a : Bergerak ke arah Kiri (Barat).'), nl,
    write('7. d : Bergerak ke arah Kanan (Timur).'), nl,
    write('8. quit : Keluar dari permainan.'), nl,
    write('Catatan : Semua command di atas diakhiri titik (Misal : "start.")'), nl, !.

quit :-
    retract(inventori(_)),
    retract(gameState(_)).
