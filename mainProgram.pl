/*
Tubes Logika Komputasional - Tokemon
Kelompok 7 - K3 :
Muhammad Hasan - 13518012
Hafshy Yazid Albisthami - 13518051
Arthur Edgar Yunanto - 13518090
Yan Arie Motinggo - 13518129
*/

include('utils.pl').

start :-
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
    nl, nl,
    help, nl, nl, quit, !.

help :-
    write('Daftar Command : '), nl,
    write('1. start : Untuk Memulai Permainan.'), nl,
    write('2. map : Menampilkan Seluruh Peta Permainan.'), nl,
    write('3. w : Bergerak ke arah Atas (Utara).'), nl,
    write('4. s : Bergerak ke arah Bawah (Selatan).'), nl,
    write('5. a : Bergerak ke arah Kiri (Barat).'), nl,
    write('6. d : Bergerak ke arah Kanan (Timur).'), nl,
    write('7. quit : Keluar dari permainan.'), nl,
    write('Catatan : Semua command di atas diakhiri titik (Misal : "start.")'), nl, !.
