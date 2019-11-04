Deliverable I Tugas Besar Logika Komputasional
Kelompok 7 - K3 :
Muhammad Hasan - 13518012
Hafshy Yazid Albisthami - 13518051
Arthur Edgar Yunanto - 13518090
Yan Arie Motinggo - 13518129
/* Deklarasi Fakta Dasar */

/* effective(X, Y) = Tipe X efektif terhadap tipe Y */
effective(fire, leaves).
effective(leaves, water).
effective(water, fire).

/* not_effective(X, Y) = Tipe X tidak efektif terhadap tipe Y */
not_effective(fire, fire).
not_effective(leaves, leaves).
not_effective(water, water).
not_effective(leaves, fire).
not_effective(water, leaves).
not_effective(fire, water).

/* fainted(X, hp) = Tokemon X pingsan ketika berada di health = hp */
fainted(Tokemon, 0).

/* pagar(X, Y) = koordinat (X, Y) merupakan koordinat pagar pada game di map */
pagar(X, Y).

/* gym(X, Y) = koordinat (X, Y) merupakan koordinat gym pada game di map */
gym(X, Y).

/* normal(X) = Tokemon X adalah Normal Tokemon */
normal(nama_normal_tokemon).

/* legendary(X) = Tokemon X adalah legendary Tokemon */
legendary(nama_legendary_tokemon).

/* Tipe-tipe Tokemon */
fire(nama_tokemon_fire).
leaves(nama_tokemon_leaves).
water(nama_tokemon_water).

/* HP Maks Tokemon */
HP_max(normal/legendary_tokemon, hp_maks).

/* Damage tokemon */
normal_damage(nama_tokemon, jumlah_damage).
special_damage(nama_tokemon, jumlah_damage).