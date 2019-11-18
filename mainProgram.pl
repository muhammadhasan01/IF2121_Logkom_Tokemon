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
:- include('map.pl').

gameState(0).
takeTokemon(0).
turnOnGame :-
    retract(gameState(_)),
    asserta(gameState(1)).

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
    write('adalah dengan menjadi The Very Best Tokemon Trainer Like No One Ever Was!'), nl,
    write('Namun, untuk menjadi The Best, kamu harus bisa mengalahkan Final Boss!'), nl,
    write('Disebutkan bahwa terdapat Super Legendary Tokemon yang perlu dikalahkan'), nl,
    write('Apakah kamu bisa mengalahkannya ?'), nl,
    nl,
    write(' _____ _____ _   __ ________  ________ _   _ '), nl,
    write('|_   _|  _  | | / /|  ___|  \\/  |  _  | \\ | |'), nl,
    write('  | | | | | | |/ / | |__ |      | | | |  \\| |'), nl,
    write('  | | | | | |    \\ |  __|| |\\/| | | | |     |'), nl,
    write('  | | \\ \\_/ / |\\  \\| |___| |  | \\ \\_/ / |\\  |'), nl,
    write('  \\_/  \\___/\\_| \\_/\\____/\\_|  |_/\\___/\\_| \\_/'), nl,

    nl,

    write('Tanpa ragu-ragu lagi, Profesor langsung memberi kamu 3 Tokemon piihan dia'), nl,
    write('Kamu disuruh memilih salah satu!'), nl, nl,
    write('--- Choose Your Starting Tokemon ---'), nl,
    write('#1. goku \t(Tipe : earth)'), nl,
    write('#2. naruto \t(Tipe : wind)'), nl,
    write('#3. usopp \t(Tipe : leaf)'), nl, nl,
    write('Pilih salah satu dengan mengetik pilih(nomor).'), nl,
    write('Contoh : pilih(2). artinya kamu akan memlih naruto'), nl, nl,
    write('(ketik help. untuk melihat instruksi game)'),
    initMap, nl, nl, !.

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
    retract(takeTokemon(_)),
    asserta(takeTokemon(1)),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X == 2,
    nl, write('Kau memilih naruto sebagai Tokemon Startermu!'), nl,
    addTokemon(naruto, 330),
    retract(takeTokemon(_)),
    asserta(takeTokemon(1)),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

pilih(X) :-
    takeTokemon(Y),
    Y == 0, X == 3,
    nl, write('Kau memilih usopp sebagai Tokemon Startermu!'), nl,
    addTokemon(usopp, 360),
    retract(takeTokemon(_)),
    asserta(takeTokemon(1)),
    write('Ketik status. untuk melihat status tokemonmu di Inventori!'), nl, !.

help :-
    write('---- Daftar Command ----'), nl,
    write('1. start \t: Untuk Memulai Permainan.'), nl,
    write('2. map \t\t: Menampilkan Seluruh Peta Permainan.'), nl,
    write('3. status \t: Menampilkan Status Tokemonmu di Inventori'), nl,
    write('4. remove \t: Membuang salah satu Tokemonmu di Inventori'), nl,
    write('5. w \t\t: Bergerak ke arah Atas (Utara).'), nl,
    write('6. s \t\t: Bergerak ke arah Bawah (Selatan).'), nl,
    write('7. a \t\t: Bergerak ke arah Kiri (Barat).'), nl,
    write('8. d \t\t: Bergerak ke arah Kanan (Timur).'), nl,
    write('9. quit \t: Keluar dari permainan.'), nl, nl,
    write('Catatan : Semua command di atas diakhiri titik (Misal : "start.")'), nl, !.

quit :-

    nl,
    write(' _____   ___  ___  ___ _____   _____  _   _ ___________ '), nl,
    write('|  __ \\ / _ \\ |  \\/  ||  ___| |  _  || | | |  ___| ___  '), nl,
    write('| |  \\// /_\\ \\| .  . || |__   | | | || | | | |__ | |_/ /'), nl,
    write('| | __ |  _  || |\\/| ||  __|  | | | || | | |  __||    / '), nl,
    write('| |_\\ \\| | | || |  | || |___  \\ \\_/ /\\ \\_/ / |___| |\\ \\ '), nl,
    write(' \\____/\\_| |_/\\_|  |_/\\____/   \\___/  \\___/\\____/\\_| \\_|'), nl,


    nl, nl, write('Terimakasih sudah memainkan game kami UwU ~~'), nl, nl,
    retract(inventori(_)),
    asserta(inventori([])),
    retract(takeTokemon(_)),
    asserta(takeTokemon(0)),
    retract(gameState(_)),
    asserta(gameState(0)),
    retract(lebarPeta(_)),
    asserta(lebarPeta(0)),
    retract(tinggiPeta(_)),
    asserta(tinggiPeta(0)),
    retract(lokasiPlayer(_, _)),
    asserta(lokasiPlayer(1, 1)),
    retract(countJalan(_)),
    asserta(countJalan(0)),
    retract(munculLegendary(_)),
    asserta(munculLegendary(0)),
    retract(usedTokeCenter(_, _)),
    retract(winOrLose(_)),
    asserta(winOrLose(0)),
    retract(healthID(_, _)), !.

d :-
    takeTokemon(X),
    (X =:= 0),
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

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isRumput(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Kamu menginjak rumput... '), nl,
    encounterTokemon, !.

d :-
    lokasiPlayer(X, Y),
    XNew is X + 1,
    land(XNew, Y, Land),
    isSuperLegendary(Land),
    updateLokasiPlayer(XNew, Y),
    tambahCount,
    write('Bersiap-siap untuk melawan Final Boss!!!'), nl,
    fightSuperLegendary, !.

a :-
    takeTokemon(X),
    (X =:= 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.

a :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    isBorderKiri(XNew, Y),
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
    write('Kamu berada di tanah kosong.'), nl,
    tambahCount, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isTokCenter(Land),
    updateLokasiPlayer(XNew, Y),
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl,
    tambahCount, !.
a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isLegendary(Land),
    updateLokasiPlayer(XNew, Y),
    write('Kamu bertemu dengan legendary Tokemon!'), nl,
    write('Kamu tidak bisa lari dan terpaksa untuk melawannya, bersiaplah!'), nl,
    tambahCount,
    fightLegendary, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isRumput(Land),
    updateLokasiPlayer(XNew, Y),
    write('Kamu menginjak rumput... '), nl,
    tambahCount,
    encounterTokemon, !.

a :-
    lokasiPlayer(X, Y),
    XNew is X - 1,
    land(XNew, Y, Land),
    isSuperLegendary(Land),
    updateLokasiPlayer(XNew, Y),
    write('Bersiap-siap untuk melawan Final Boss!!!'), nl,
    fightSuperLegendary, !.

w :-
    takeTokemon(X),
    (X =:= 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.


w :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.


w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    isBorderAtas(X, YNew),
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
    write('Kamu berada di tanah kosong.'), nl,
    tambahCount, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isTokCenter(Land),
    updateLokasiPlayer(X, YNew),
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl,
    tambahCount, !.

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

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isRumput(Land),
    updateLokasiPlayer(X, YNew),
    write('Kamu menginjak rumput... '), nl,
    tambahCount,
    encounterTokemon, !.

w :-
    lokasiPlayer(X, Y),
    YNew is Y - 1,
    land(X, YNew, Land),
    isSuperLegendary(Land),
    updateLokasiPlayer(X, YNew),
    write('Bersiap-siap untuk melawan Final Boss!!!'), nl,
    fightSuperLegendary, !.

s :-
    takeTokemon(X),
    (X =:= 0),
    write('Kamu belum memlih Tokemon, kamu tidak bisa dulu bergerak!'), nl, !.

s :-
    sedangLawan(X),
    (X =\= 0),
    write('Kamu sedang melawan Tokemon, kamu tidak bisa bergerak!'), nl, !.


s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    isBorderBawah(X, YNew),
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
    write('Kamu berada di tanah kosong.'), nl,
    tambahCount, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isTokCenter(Land),
    updateLokasiPlayer(X, YNew),
    write('Kamu berada di Tokemon Center, ketik restore. untuk menyembuhkan Tokemonmu!'), nl,
    write('(restore. hanya akan bekerja jika tempat ini belum dilakukan untuk restore sebelumnya)'), nl,
    tambahCount, !.

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

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isRumput(Land),
    updateLokasiPlayer(X, YNew),
    write('Kamu menginjak rumput... '), nl,
    tambahCount,
    encounterTokemon, !.

s :-
    lokasiPlayer(X, Y),
    YNew is Y + 1,
    land(X, YNew, Land),
    isSuperLegendary(Land),
    updateLokasiPlayer(X, YNew),
    write('Bersiap-siap untuk melawan Final Boss!!!'), nl,
    fightSuperLegendary, !.

cekSelesai :-
    winOrLose(X),
    (X =:= 2), nl,
    write('__   _______ _   _   _     _____ _____ _____ '), nl,
    write('\\ \\ / /  _  | | | | | |   |  _  /  ___|  ___|'), nl,
    write(' \\ V /| | | | | | | | |   | | | \\ `--.| |__  '), nl,
    write('  \\ / | | | | | | | | |   | | | |`--. \\  __| '), nl,
    write('  | | \\ \\_/ / |_| | | |___\\ \\_/ /\\__/ / |___ '), nl,
    write('  \\_/  \\___/ \\___/  \\_____/\\___/\\____/\\____/ '), nl, nl,
    quit, !.

cekSelesai :-
    winOrLose(X),
    (X =:= 1), nl,
    write('__   _______ _   _   _    _ _____ _   _ '), nl,
    write('\\ \\ / /  _  | | | | | |  | |_   _| \\ | |'), nl,
    write(' \\ V /| | | | | | | | |  | | | | |  \\| |'), nl,
    write('  \\ / | | | | | | | | |/\\| | | | | . ` |'), nl,
    write('  | | \\ \\_/ / |_| | \\  /\\  /_| |_| |\\  |'), nl,
    write('  \\_/  \\___/ \\___/   \\/  \\/ \\___/\\_| \\_/'), nl, nl,
    quit, !.

cekSelesai :-
    winOrLose(X), X =:= 0, !.
