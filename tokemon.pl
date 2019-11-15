/* File berisi data-data tentang tokemon dan tipe-tipenya */
:- dynamic(chosenTokemon / 1).
:- dynamic(enemyTokemon / 1).
:- dynamic(sedangLawan / 1).
:- dynamic(battleMode / 1).
:- dynamic(specialAttack / 1).

/* Kondisi Awal */
chosenTokemon(0).
enemyTokemon(0).
sedangLawan(0).
battleMode(0).

/* Fakta-Fakta Tokemon */
legendary(thanos).
legendary(saitama).

normal(naruto).
normal(goku).
normal(usopp).
normal(doctorStrange).
normal(batman).
normal(scarlett).
normal(ironman).

/* Terdapat 6 Type : fire, water, leaf, wind, earth, electric */

/* Tokemon Types */
type(thanos, fire).
type(saitama, earth).
type(naruto, wind).
type(goku, earth).
type(usopp, leaf).
type(doctorStrange, earth).
type(ironman, electric).
type(batman, water).
type(scarlett, fire).

/* Base Health Tokemon */
health(thanos, 600).
health(saitama, 550).
health(naruto, 330).
health(goku, 350).
health(usopp, 360).
health(doctorStrange, 300).
health(batman, 200).
health(scarlett, 350).
health(ironman, 275).

attackT(thanos, 100).
attackT(saitama, 200).
attackT(naruto, 55).
attackT(goku, 90).
attackT(usopp, 60).
attackT(doctorStrange, 40).
attackT(ironman, 45).
attackT(batman, 35).
attackT(scarlett, 70).

specialT(thanos, 150).
specialT(saitama, 300).
specialT(naruto, 150).
specialT(goku, 200).
specialT(usopp, 150).
specialT(doctorStrange, 100).
specialT(ironman, 120).
specialT(batman, 70).
specialT(scarlett, 150).

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

/* Mekanisme Fight */

/*generateFight(X) :-
    X < 30, X > 0, !.
*/
generateFight(X) :-
    X > 0, X < 96,
    write('Seekor Tokemon muncul!!'), nl,
    fightNormal, !.

generateFight(X) :-
    X > 95, X < 101,
    write('Seekor Legendary Tokemon muncul!!!!'), nl,
    fightLegendary, !.

encounterTokemon :-
    random(1, 100, X),
    generateFight(X), !.

fightNormal :-
    retract(sedangLawan(_)),
    assertz(sedangLawan(1)),
    findall(Tokemon, normal(Tokemon), ListTokemon),
    length(ListTokemon, Len),
    random(0, Len, Idx),
    ambil(ListTokemon, Idx, GetTokemon),
    write('Tokemon '), write(GetTokemon), write(' liar telah muncul!'), nl,
    retract(enemyTokemon(_)),
    assertz(enemyTokemon(GetTokemon)),
    health(GetTokemon, EnemyHealth),
    retract(healthID(7, _)),
    assertz(healthID(7, EnemyHealth)),
    write('lawan atau kabur saja ?'), nl,
    write('(ketik fight. untuk melawan dan run. untuk kabur)'), nl, !.

fightLegendary :-
    retract(sedangLawan(_)),
    assertz(sedangLawan(2)),
    !.

kabur(X) :-
    X > 0, X < 61,
    write('Kamu berhasil kabur!'), nl,
    retract(sedangLawan(_)),
    assertz(sedangLawan(0)),
    retract(enemyTokemon(_)),
    assertz(enemyTokemon(0)),
    retract(healthID(7, _)),
    assertz(healthID(7, -1)),
    !.


kabur(X) :-
    X > 60, X < 101,
    write('Kamu gagal untuk kabur!'), nl, !.

run :-
    sedangLawan(X),
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
    inventori(Tokemons),
    Idx is X - 1,
    ambil(Tokemons, Idx, Tokemon),
    write('Kau memilih Tokemon #'),
    write(X), write(' '),
    write(Tokemon), write(', siap-siap bertarung!'), nl, nl,
    retract(battleMode(_)),
    assertz(battleMode(1)),
    retract(chosenTokemon(_)),
    assertz(chosenTokemon(X)),
    battle.

getTokemonId(Id, Tokemon) :-
    inventori(Tokemons),
    ambil(Tokemons, Id, Tokemon), !.


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
    !.

cekMusuh(JML) :-
    enemyTokemon(Musuh),
    healthID(7, HealthMusuh),
    HealthMusuh > JML -> (
        HealthBaru is HealthMusuh - JML,
        retract(healthID(7, _)),
        assertz(healthID(7, HealthBaru))
    );(
        HealthBaru is 0,
        retract(healthID(7, _)),
        assertz(healthID(7, HealthBaru)),
        write('Tokemon '), write(Musuh), write(' Has been defeated!'), nl,
        retract(battleMode(_)),
        assertz(battleMode(0)),
        retract(sedangLawan(_)),
        assertz(sedangLawan(0))
    ), !.

attacks(ID1, ID2, JML, T1, T2) :-
    ID1 =\= 7,
    ID2 =:= 7,
    effective(T1, T2),
    JMLB is (JML * 1.5),
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s super effective!'), nl,
    cekMusuh(JMLB), !.

attacks(ID1, ID2, JML, T1, T2) :-
    ID1 =\= 7,
    ID2 =:= 7,
    not_effective(T1, T2),
    JMLB is (JML * 0.5),
    enemyTokemon(Musuh),
    write('Foe '), write(Musuh), write(' Deals '),
    write(JMLB), write(' damages!'), nl,
    write('It\'s not very effective...'), nl,
    cekMusuh(JMLB), !.

attack :-
    sedangLawan(X),
    (X == 0),
    write('Kamu sedang tidak melawan siapa-siapa.'), nl, !.

attack :-
    chosenTokemon(Id),
    getTokemonId(Id, MyTokemon),
    enemyTokemon(Musuh),
    attack(MyTokemon, JumlahAttack),
    type(MyTokemon, TipeAku),
    type(Musuh, TipeMusuh),
    attacks(Id, 7, JumlahAttack, TipeAku, TipeMusuh), !.
