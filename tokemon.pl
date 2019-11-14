/* File berisi data-data tentang tokemon dan tipe-tipenya */
:- dynamic(health / 2). /* health(tokemon, healthPoint) */


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

type(thanos, fire).
type(saitama, earth).
type(naruto, wind).
type(goku, earth).
type(usopp, leaf).
type(doctorStrange, earth).
type(ironman, electric).
type(batman, water).
type(scarlett, fire).

health(thanos, 600).
health(saitama, 550).
health(naruto, 330).
health(goku, 350).
health(usopp, 360).
health(doctorStrange, 300).
health(batman, 200).
health(scarlett, 350).
health(ironman, 275).

attack(thanos, 100).
attack(saitama, 200).
attack(naruto, 55).
attack(goku, 90).
attack(usopp, 60).
attack(doctorStrange, 40).
attack(ironman, 45).
attack(batman, 35).
attack(scarlett, 70).

special(thanos, 150).
special(saitama, 300).
special(naruto, 150).
special(goku, 200).
special(usopp, 150).
special(doctorStrange, 100).
special(ironman, 120).
special(batman, 70).
special(scarlett, 150).

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

/* changeHealth */
changeHealth(X, H) :-
    retract(health(X, _)),
    assertz(health(X, H)).
