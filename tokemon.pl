/* File berisi data-data tentang tokemon dan tipe-tipenya */

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
