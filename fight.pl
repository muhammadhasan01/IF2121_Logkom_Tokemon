:- include('tokemon.pl').
:- dynamic(chosenTokemon / 1).
:- dynamic(enemyTokemon / 1).
:- dynamic(sedangLawan / 1).
:- dynamic(battleMode / 1).
:- dynamic(specialTok / 1).
:- dynamic(enemySpecial / 1).
:- dynamic(winOrLose / 1).
:- dynamic(cekSelesai / 0).

/* Kondisi Awal */
chosenTokemon(0).
enemyTokemon(0).
sedangLawan(0).
battleMode(0).
specialTok(0).
enemySpecial(0).
winOrLose(0).

/* Mekanisme Fight */

generateFight(X) :-
    X < 31, X > 0, !.

generateFight(X) :-
    X > 30, X < 101,
    nl, write('Seekor Tokemon muncul!!'), nl, fightNormal, !.

generateFight(X) :-
    X > 99, X < 101,
    nl, write('Seekor Legendary Tokemon muncul!!!!'), nl,
    fightLegendary, !.

encounterTokemon :-
    random(1, 100, X),
    generateFight(X), !.

fightNormal :-
    retract(sedangLawan(_)),
    asserta(sedangLawan(1)),
    findall(Tokemon, normal(Tokemon), ListTokemon),
    length(ListTokemon, Len),
    random(0, Len, Idx),
    ambil(ListTokemon, Idx, GetTokemon),
    write('Tokemon '), write(GetTokemon), write(' liar telah muncul!'), nl,
    retract(enemyTokemon(_)),
    asserta(enemyTokemon(GetTokemon)),
    health(GetTokemon, EnemyHealth),
    retract(healthID(7, _)),
    asserta(healthID(7, EnemyHealth)),
    retract(specialTok(_)),
    asserta(specialTok(0)),
    retract(enemySpecial(_)),
    asserta(enemySpecial(0)),
    write('Bersiap-siaplah untuk bertarung!'), nl, nl, fight, !.

fightLegendary :-
    retract(sedangLawan(_)),
    asserta(sedangLawan(2)),
    findall(Tokemon, legendary(Tokemon), ListTokemon),
    length(ListTokemon, Len),
    random(0, Len, Idx),
    ambil(ListTokemon, Idx, GetTokemon),
    write('Legendary Tokemon '), write(GetTokemon), write(' liar telah muncul!'), nl,
    retract(enemyTokemon(_)),
    asserta(enemyTokemon(GetTokemon)),
    health(GetTokemon, EnemyHealth),
    retract(healthID(7, _)),
    asserta(healthID(7, EnemyHealth)),
    retract(specialTok(_)),
    asserta(specialTok(0)),
    retract(enemySpecial(_)),
    asserta(enemySpecial(0)),
    write('Bersiaplah untuk bertarung!'), nl, nl, fight, !.

fightSuperLegendary :-
    retract(sedangLawan(_)),
    asserta(sedangLawan(3)),
    findall(Tokemon, superlegendary(Tokemon), ListTokemon),
    length(ListTokemon, Len),
    random(0, Len, Idx),
    ambil(ListTokemon, Idx, GetTokemon),
    write('The Super Legendary Tokemon '), write(GetTokemon), write(' liar telah muncul!'), nl,
    retract(enemyTokemon(_)),
    asserta(enemyTokemon(GetTokemon)),
    health(GetTokemon, EnemyHealth),
    retract(healthID(7, _)),
    asserta(healthID(7, EnemyHealth)),
    retract(specialTok(_)),
    asserta(specialTok(0)),
    retract(enemySpecial(_)),
    asserta(enemySpecial(0)),
    write('Bersiaplah untuk bertarung!!!'), nl, nl, fight, !.

battleOver :-
    retract(chosenTokemon(_)),
    asserta(chosenTokemon(0)),
    retract(sedangLawan(_)),
    asserta(sedangLawan(0)),
    retract(battleMode(_)),
    asserta(battleMode(0)),
    retract(enemyTokemon(_)),
    asserta(enemyTokemon(0)),
    retract(specialTok(_)),
    asserta(specialTok(0)),
    retract(enemySpecial(_)),
    asserta(enemySpecial(0)), !.

generateCatch(X) :-
    X < 51,
    enemyTokemon(Musuh),
    write('Catch failed! it seems Foe '), write(Musuh),
    write(' is hard to catch'), nl, nl,
    enemyAttack, !.

generateCatch(X) :-
    X > 50,
    enemyTokemon(Musuh),
    write('You successfully catched Foe '), write(Musuh), write('!'), nl, nl,
    healthID(7, HealthMusuh),
    addTokemon(Musuh, HealthMusuh),
    battleOver, !.

catchRate(X, Y) :-
    sedangLawan(Z),
    (Z == 3), (X == X),
    Y == 0, !.

catchRate(X, Y) :-
    sedangLawan(Z),
    (Z == 2),
    enemyTokemon(Musuh),
    health(Musuh, HealthAwal),
    healthID(7, HealthSekarang),
    Dif is HealthAwal - HealthSekarang,
    divide(Dif, HealthAwal, Kali),
    Y is X * Kali * (0.7), !.

catchRate(X, Y) :-
    sedangLawan(Z),
    (Z == 1),
    enemyTokemon(Musuh),
    health(Musuh, HealthAwal),
    healthID(7, HealthSekarang),
    Dif is HealthAwal - HealthSekarang + 2,
    divide(Dif, HealthAwal, Kali),
    Y is X * Kali, !.

catch :-
    inventori(Tokemon),
    length(Tokemon, Len),
    (Len == 6), write('Catch gagal, kau sudah mempunyai 6 tokemon!'), nl, nl,
    enemyAttack, !.

catch :-
    sedangLawan(X),
    (X == 0),
    write('Catch gagal, kamu sedang tidak lawan siapa-siapa!'), nl, nl, !.

catch :-
    random(1, 300, X),
    catchRate(X, Y),
    generateCatch(Y), !.

kabur(X) :-
    X > 0, X < 71,
    write('Kamu berhasil kabur!'), nl,
    battleOver,
    !.

kabur(X) :-
    X > 70, X < 101,
    write('Kamu gagal untuk kabur!'), nl, enemyAttack, !.

run :-
    sedangLawan(3),
    enemyTokemon(Musuh),
    write('Kabur gagal!'), nl,
    write('Sepertinya tidak mungkin untuk kabur dari Super Legendary '), write(Musuh), write('!'), nl,
    enemyAttack,
    !.

run :-
    sedangLawan(2),
    enemyTokemon(Musuh),
    write('Kabur gagal!'), nl,
    write('Sepertinya terlalu susah untuk kabur dari Legendary '), write(Musuh), write('!'), nl,
    enemyAttack,
    !.

run :-
    battleMode(X),
    X =:= 0,
    write('Kabur gagal!'), nl,
    write('Kamu tidak sedang melawan siapa-siapa.'), nl, !.

run :-
    random(1, 100, X),
    kabur(X).

fight :-
    sedangLawan(X),
    X =:= 0,
    write('Fight gagal!'), nl,
    write('Kamu tidak sedang melawan siapa-siapa.'), nl, !.

fight :-
    write('Pilih Tokemonmu!'), nl,
    inventori(Tokemons),
    printTokemons(Tokemons, 1), nl,
    write('ketik choose(nomor). untuk memilih tokemon!'), nl,
    write('Contoh : choose(1). untuk memilih tokemon pertama di Inventori.'), nl, !.

choose(X) :-
    chosenTokemon(K),
    K =\= 0, X == X,
    write('kau sudah memilih tokemon!'), nl, !.

choose(X) :-
    X < 1,
    write('Indeks tidak valid, silahkan coba lagi.'), nl, !.

choose(X) :-
    getLength(Len),
    X > Len,
    write('Indeks tidak valid, silahkan coba lagi.'), nl, !.

choose(X) :-
    getLength(Len),
    X > 0,
    X < Len + 1,

    healthID(X, HealthTokemon),
    HealthTokemon =:= 0 -> (
        inventori(Tokemons),
        Idx is X - 1,
        ambil(Tokemons, Idx, Tokemon),
        write('Tokemon #'), write(X), write(' '), write(Tokemon), write(' telah pingsan!'), nl,
        write('Coba pilih tokemon lain!'), nl, nl
    );(
        getTokemonId(X, Tokemon),
        write('Kau memilih Tokemon #'),
        write(X), write(' '),
        write(Tokemon), write(', siap-siap bertarung!'), nl, nl,
        retract(battleMode(_)),
        asserta(battleMode(1)),
        retract(chosenTokemon(_)),
        asserta(chosenTokemon(X)),
        battle
    ), !.

cekListNol(X, Y) :-
    (X == Y),
    healthID(X, Health),
    (Health == 0), !.
cekListNol(X, Y) :-
    healthID(X, Health),
    (Health == 0),
    XNew is X + 1,
    cekListNol(XNew, Y),
    !.

cekOver :-
    inventori(X),
    length(X, Len),
    cekListNol(1, Len),
    nl, write('Tokemonmu telah mati semua :('), nl, nl,
    retract(winOrLose(_)),
    asserta(winOrLose(2)),
    cekSelesai,
    !.

cekOver :-
    inventori(Tokemons),
    retract(chosenTokemon(_)),
    asserta(chosenTokemon(0)),
    retract(specialTok(_)),
    asserta(specialTok(0)),
    nl, write('--- Choose another tokemon ---'), nl,
    printTokemons(Tokemons, 1), nl,
    write('ketik choose(nomor). untuk memilih tokemon!'), nl,
    write('Contoh : choose(1). untuk memilih tokemon pertama di Inventori.'), nl,
    write('atau kau bisa coba kabur dengan mengetik run.'), nl, !.

getTokemonId(Id, Tokemon) :-
    inventori(Tokemons),
    Idx is Id - 1,
    ambil(Tokemons, Idx, Tokemon), !.


battle :-
    chosenTokemon(Id),
    enemyTokemon(Musuh),
    write('Your Tokemon :'), nl,
    getTokemonId(Id, MyTokemon),
    printStatusTokemon(MyTokemon, Id), nl,
    write('Your Enemy :'), nl,
    printStatusTokemon(Musuh, 7),
    write('Choose your move :'), nl,
    write('1. attack. (lakukan normal attack)'), nl,
    write('2. specialAttack. (lakukan special attack - hanya bisa sekali)'), nl,
    write('3. catch. (capture tokemon)'), nl,
    write('4. run. (lari dari tokemon)'),
    nl, nl,
    !.

cekMenang :-
    sedangLawan(X), (X == 0), !.

cekMenang :-
    sedangLawan(X), (X == 1), !.

cekMenang :-
    sedangLawan(X), (X == 2), !.

cekMenang :-
    sedangLawan(X), (X == 3),
    retract(winOrLose(_)),
    asserta(winOrLose(1)), cekSelesai, !.

cekMusuh(JML) :-
    healthID(7, HealthMusuh),
    HealthMusuh > JML -> (
        HealthBaru is HealthMusuh - JML,
        retract(healthID(7, _)),
        asserta(healthID(7, HealthBaru)),
        enemyAttack
    );(
        HealthBaru is 0,
        retract(healthID(7, _)),
        asserta(healthID(7, HealthBaru)),
        enemyTokemon(NamaMusuh),
        write('Tokemon '), write(NamaMusuh), write(' Has been defeated!'), nl,
        cekMenang, battleOver
    ), !.


cekSaya(JML) :-
    chosenTokemon(Id),
    healthID(Id, HealthSaya),
    HealthSaya > JML -> (
        chosenTokemon(ID),
        HealthBaru is HealthSaya - JML,
        retract(healthID(ID, _)),
        asserta(healthID(ID, HealthBaru)),
        battle
    );(
        chosenTokemon(ID),
        HealthBaru is 0,
        retract(healthID(ID, _)),
        asserta(healthID(ID, HealthBaru)),
        write('Your Tokemon has fainted!'), nl,
        cekOver
    ), !.

attacks(ID1, ID2, JML, T1, T2) :-
    ID1 =\= 7,
    ID2 =:= 7,
    effective(T1, T2),
    JMLB is (JML * 1.5),
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s super effective!'), nl, nl,
    cekMusuh(JMLB), !.

attacks(ID1, ID2, JML, T1, T2) :-
    ID1 =\= 7,
    ID2 =:= 7,
    not_effective(T1, T2),
    JMLB is (JML * 0.5),
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s not very effective...'), nl, nl,
    cekMusuh(JMLB), !.

attacks(ID1, ID2, JML, T1, T2) :-
    ID1 =\= 7,
    ID2 =:= 7,
    (T1 == T1), (T2 == T2),
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' Deals '),
    write(JML), write(' damages!'), nl, nl,
    cekMusuh(JML), !.

attacks(ID1, ID2, JML, T1, T2) :-
    (ID1 == 7),
    effective(T1, T2),
    JMLB is (JML * 1.5),
    getTokemonId(ID2, Saya),
    write('Your Tokemon '), write(Saya), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s super effective!'), nl, nl,
    cekSaya(JMLB), !.

attacks(ID1, ID2, JML, T1, T2) :-
    (ID1 == 7),
    not_effective(T1, T2),
    JMLB is (JML * 0.5),
    getTokemonId(ID2, Saya),
    write('Your Tokemon '), write(Saya), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s not very effective...'), nl, nl,
    cekSaya(JMLB), !.

attacks(ID1, ID2, JML, T1, T2) :-
    (ID1 == 7),
    getTokemonId(ID2, Saya), (T1 == T1), (T2 == T2),
    write('Your Tokemon '), write(Saya), write(' Deals '),
    write(JML), write(' damages!'), nl, nl,
    cekSaya(JML), !.

attack :-
    sedangLawan(X),
    (X == 0),
    write('Kamu sedang tidak melawan siapa-siapa.'), nl, !.


attack :-
    chosenTokemon(Id),
    getTokemonId(Id, MyTokemon),
    write('Your '), write(MyTokemon), write(' uses his Normal Attack'), nl,
    enemyTokemon(Musuh),
    attackT(MyTokemon, JumlahAttack),
    type(MyTokemon, TipeAku),
    type(Musuh, TipeMusuh),
    attacks(Id, 7, JumlahAttack, TipeAku, TipeMusuh), !.

specialAttackEnemy :-
    enemySpecial(X),
    (X == 1),
    enemyTokemon(Tokemon),
    write('Foe '), write(Tokemon), write(' fails to use special attack..'), nl, battle, !.

specialAttackEnemy :-
    retract(enemySpecial(_)),
    asserta(enemySpecial(1)),
    chosenTokemon(Id),
    getTokemonId(Id, MyTokemon),
    enemyTokemon(Musuh),
    specialT(Musuh, JumlahAttack),
    type(MyTokemon, TipeAku),
    type(Musuh, TipeMusuh),
    attacks(7, Id, JumlahAttack, TipeMusuh, TipeAku), !.

attackEnemy :-
    chosenTokemon(Id),
    getTokemonId(Id, MyTokemon),
    enemyTokemon(Musuh),
    attackT(Musuh, JumlahAttack),
    type(MyTokemon, TipeAku),
    type(Musuh, TipeMusuh),
    attacks(7, Id, JumlahAttack, TipeMusuh, TipeAku), !.

specialAttack :-
    sedangLawan(X),
    (X == 0),
    write('Kamu sedang tidak melawan siapa-siapa.'), nl, !.

specialAttack :-
    specialTok(X),
    (X == 1),
    write('Special attack failed, you can only do once!'), nl, nl,
    enemyAttack, !.

specialAttack :-
    retract(specialTok(_)),
    asserta(specialTok(1)),
    chosenTokemon(Id),
    getTokemonId(Id, MyTokemon),
    write('Your '), write(MyTokemon), write(' uses his Special Attack'), nl,
    enemyTokemon(Musuh),
    specialT(MyTokemon, JumlahAttack),
    type(MyTokemon, TipeAku),
    type(Musuh, TipeMusuh),
    attacks(Id, 7, JumlahAttack, TipeAku, TipeMusuh), !.

genEnemyAttack(X) :-
    X > 0, X < 86,
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' uses his Normal attack!'), nl,
    attackEnemy, !.

genEnemyAttack(X) :-
    X > 85, X < 101,
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' uses his Special Attack!'), nl,
    specialAttackEnemy, !.

enemyAttack :-
    random(1, 100, X),
    genEnemyAttack(X), !.


divide(X, Y, Z) :-
    Z is (X / Y), !.
