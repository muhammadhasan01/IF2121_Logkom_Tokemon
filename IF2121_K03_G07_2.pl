# Deliverable II Tugas Besar Logika Komputasional
# Kelompok 7 - K3 :
# Muhammad Hasan - 13518012
# Hafshy Yazid Albisthami - 13518051
# Arthur Edgar Yunanto - 13518090
# Yan Arie Motinggo - 13518129

/* Fakta-Fakta Tipe Tokemon */
/* Terdapat 6 Tipe : fire, water, leaf, wind, earth, electric */

/* effective(X, Y) = Tipe X efektif terhadap tipe Y */
effective(fire, leaf).
effective(fire, wind).
effective(leaf, water).
effective(leaf, earth).
effective(water, fire).
effective(water, earth).
effective(wind, leaf).
effective(earth, electric).
effective(earth, fire).
effective(electric, water).

/* not_effective(X, Y) = Tipe X tidak efektif terhadap tipe Y */
not_effective(fire, fire).
not_effective(fire, water).
not_effective(fire, earth).
not_effective(fire, wind).
not_effective(water, water).
not_effective(water, leaf).
not_effective(water, electric).
not_effective(leaf, leaf).
not_effective(leaf, fire).
not_effective(leaf, wind).
not_effective(wind, wind).
not_effective(wind, fire).
not_effective(earth, earth).
not_effective(earth, water).
not_effective(electric, electric).
not_effective(electric, earth).

/* Fakta-Fakta Tokemon */
isFire(thanos).
legendary(thanos).
health(thanos, 600).
attack(thanos, 100).
special(thanos, 150).

isEarth(saitama).
legendary(saitama).
health(saitama, 550).
attack(saitama, 200).
special(saitama, 300).

isWind(naruto).
normal(naruto).
health(naruto, 330).
attack(naruto, 55).
special(naruto, 150).

isEarth(goku).
normal(goku).
health(goku, 350).
attack(goku, 90).
special(goku, 200).

isLeaf(usopp).
normal(usopp).
health(usopp, 360).
attack(usopp, 60).
special(usopp, 150).

isEarth(strange).
normal(strange).
health(strange, 300).
attack(strange, 40).
special(strange, 100).

isElectric(ironman).
normal(ironman).
health(ironman, 275).
attack(ironman, 45).
special(ironman, 120).

isWater(batman).
normal(batman).
health(batman, 200).
attack(batman, 35).
special(batman, 70).

isFire(scarlett).
normal(scarlett).
health(scarlett, 350).
attack(scarlett, 70).
special(scarlett, 150).

/* Fakta-Fakta Peta */
/* Peta berukuran 20 x 20 */
/* Peta berbentuk kotak */
panjangPeta(20).
lebarPeta(20).
isPlayer(P).
isBorder(X).
isGym(G).
isBorderAtas(_, Y) :-
    Y =:= 0,
    !.
isBorderKiri(X, _) :-
    X =:= 0,
    !.
isBorderBawah(_, Y) :-
    Y =:= 20,
    !.
isBorderKanan(X, _) :-
    X =:= 20,
    !.

/* initMap :- */



/* Fakta-Fakta Pemain */
/* listTokemon :- */


/* Implementasi Rule Dasar */

/* Rule Start */

start :-
    write('Tokemon~'), nl,
    write('Tokemon~'), nl,
    write('Dimana Kamu?~'), nl,
    write('Aku ingin menangkapmu~'), nl,
    help, nl, nl,
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
    nl,
!.

start :-
    gameMain(_),
write('Kamu tidak bisa memulai game ketika game sudah dimulai.'), nl, !.


/* Rule Help */
help :-
    write('Daftar Command : '), nl,
    write('1. start : Untuk Memulai Permainan.'), nl,
    write('2. map : Menampilkan Seluruh Peta Permainan.'), nl,
    write('3. look : Menampilkan mini map yang lebih detail.'), nl,
    write('4. w : Bergerak ke arah Atas (Utara).'), nl,
    write('5. s : Bergerak ke arah Bawah (Selatan).'), nl,
    write('6. a : Bergerak ke arah Kiri (Barat).'), nl,
    write('7. d : Bergerak ke arah Kanan (Timur).'), nl,
    write('8. quit : Keluar dari permainan.'), nl,
    write('9. attack : Menyerang enemy dalam petak yang sama.'),nl,
    write('10. status : Melihat status pemain.'),nl
    write('11. save(filename) : Menyimpan permainan pemain.'),nl,
    write('12. load(filename) : Membuka permainan yang telah disimpan sebelumnya.'),nl,
    write('13. help : Menampilkan Menu bantuan permainan.'),nl,
    write('Catatan : Semua command di atas diakhiri titik (Misal : "start.")'), nl, !.

/* Rule Quit */
quit :-
    \+start_Game(_),
    write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
write('Gunakan command "start." untuk memulai game.'), nl,
!.

quit :-
    write('Game Telah Selesai'), nl,
    write('Terima Kasih telah bermain'), nl,
    write('See You Again!!!'), !.

/* Rule Look */
look :-
    \+start_Game(_),
    write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
write('Gunakan command "start." untuk memulai game.'), nl, !.

look :-
    write('Keterangan simbol-simbol    : '), nl,
    write('P : Player.'), nl,
    write('G : Gym.'), nl,
    write('X : Border'), nl,
    write('- : Tanah Kosong'), nl,
    write('R : Rumput'), nl,
    !.
