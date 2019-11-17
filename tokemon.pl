/* File berisi data-data tentang tokemon dan tipe-tipenya */

/* Fakta-Fakta Tokemon */
superlegendary(saitama).

legendary(thanos).
legendary(majinBuu).
legendary(madara).

normal(naruto).
normal(sasuke).
normal(goku).
normal(vegeta).
normal(usopp).
normal(doctorStrange).
normal(batman).
normal(scarlett).
normal(ironman).

/* Terdapat 6 Type : fire, water, leaf, wind, earth, electric */

/* Tokemon Types */
type(saitama, earth).
type(sasuke, electric).
type(thanos, fire).
type(majinBuu, earth).
type(naruto, wind).
type(goku, earth).
type(vegeta, leaf).
type(usopp, leaf).
type(doctorStrange, earth).
type(ironman, electric).
type(batman, water).
type(madara, water).
type(scarlett, fire).

/* Base Health Tokemon */
health(saitama, 1500).
health(thanos, 600).
health(majinBuu, 550).
health(naruto, 330).
health(sasuke, 300).
health(goku, 350).
health(vegeta, 340).
health(usopp, 360).
health(doctorStrange, 300).
health(batman, 200).
health(scarlett, 350).
health(ironman, 275).
health(madara, 500).

attackT(saitama, 350).
attackT(thanos, 100).
attackT(majinBuu, 200).
attackT(madara, 240).
attackT(naruto, 55).
attackT(sasuke, 50).
attackT(goku, 90).
attackT(vegeta, 85).
attackT(usopp, 60).
attackT(doctorStrange, 40).
attackT(ironman, 45).
attackT(batman, 35).
attackT(scarlett, 70).

specialT(saitama, 1000).
specialT(thanos, 360).
specialT(majinBuu, 400).
specialT(madara, 340).
specialT(naruto, 150).
specialT(sasuke, 155).
specialT(goku, 230).
specialT(vegeta, 200).
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
