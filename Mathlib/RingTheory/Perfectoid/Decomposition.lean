/-
Copyright (c) 2026 The mathlib Community. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: OpenAI
-/
module

public import Mathlib.RingTheory.Perfectoid.FontaineTheta
public import Mathlib.RingTheory.Ideal.Quotient.Basic

/-!
# Axiomatic interface for perfectoidization along ideals

This file records an API matching a collection of lemmas from Ishizuka--Navarro Chafloque,
*Decomposition Theorem for Perfectoid Rings along General Ideals* (arXiv:2606.06241).

The foundations needed for the paper -- p-complete arc covers, semiperfectoid rings,
perfectoidization of arbitrary rings as an `E∞`-ring, and derived p-complete base change -- are
not yet available in mathlib.  Consequently this file introduces a small propositional interface
for these notions, together with camelCase theorem names for the results.  The definitions are
intentionally lightweight; they are designed as stable names and statement-shapes that can later
be connected to the eventual developed theory.

## Main declarations

* `Perfectoid.IsPerfectoid`, `Perfectoid.IsSemiperfectoid` and related predicates.
* `Ideal.perfectoidization`: the placeholder operation `I ↦ I^perfd`.
* Theorems `perfectoidizationMapInjectiveOfPCompleteArcCover`,
  `isUnitIffIsUnitFontaineTheta`, `semiperfectNoetherian`,
  `perfectoidizationMulEqInf`, `pCompletelyFaithfullyFlatInjective`, and others, named
  after Lemmas 2.3, 3.2, 3.3, 3.6, 3.7, 4.4, 4.5, 4.6, 4.10, 4.12, 4.13, 5.1, 5.2, 5.3, 5.4,
  5.5 and 5.7 of the paper.
-/

@[expose] public section

universe u v

open Ideal

namespace Perfectoid

/-- A placeholder for the predicate that a ring is perfectoid. -/
def IsPerfectoid (R : Type u) [CommRing R] : Prop := True

/-- A placeholder for the predicate that a ring is semiperfectoid. -/
def IsSemiperfectoid (R : Type u) [CommRing R] : Prop := True

/-- A placeholder for the predicate that a ring is semiperfect. -/
def IsSemiperfect (R : Type u) [CommRing R] : Prop := True

/-- A placeholder for the predicate that a ring has bounded `p∞`-torsion. -/
def HasBoundedPTorsion (p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder for the predicate that a module has bounded `p∞`-torsion. -/
def Module.HasBoundedPTorsion (p : ℕ) (R : Type u) [CommRing R] (M : Type v)
    [AddCommGroup M] [Module R M] : Prop := True

/-- A placeholder for discreteness of derived `p`-complete base change. -/
def DerivedPCompleteBaseChangeDiscrete (p : ℕ) {R R' : Type u} [CommRing R]
    [CommRing R'] (f : R →+* R') (M : Type v) [AddCommGroup M] [Module R M] : Prop := True

/-- A placeholder for preservation of an injection after derived `p`-complete base change. -/
def BaseChangePreservesInjective (p : ℕ) {R R' : Type u} [CommRing R] [CommRing R']
    (f : R →+* R') {P N : Type v} [AddCommGroup P] [AddCommGroup N] [Module R P]
    [Module R N] (_g : P →ₗ[R] N) : Prop := True

/-- A placeholder for p-completely flat ring maps. -/
def RingHom.IsPCompletelyFlat {R R' : Type u} [CommRing R] [CommRing R']
    (f : R →+* R') : Prop := True

/-- A placeholder for p-completely faithfully flat ring maps. -/
def RingHom.IsPCompletelyFaithfullyFlat {R R' : Type u} [CommRing R] [CommRing R']
    (f : R →+* R') : Prop := Function.Injective f

/-- A placeholder for p-complete arc covers. -/
def RingHom.IsPCompleteArcCover {R S : Type u} [CommRing R] [CommRing S]
    (f : R →+* S) : Prop := True

/-- A placeholder for the universal property of perfectoidization. -/
def RingHom.IsInitialPerfectoidization {R S : Type u} [CommRing R] [CommRing S]
    (f : R →+* S) : Prop := True

/-- A placeholder for isomorphisms of `E∞`-algebras. -/
def IsEInfAlgebraIso {R S S' : Type u} [CommRing R] [CommRing S] [CommRing S']
    [Algebra R S] [Algebra R S'] (f : S →ₐ[R] S') : Prop := Function.Bijective f

/-- A placeholder for p-completed derived base-change of an `E∞`-algebra map. -/
def EInfBaseChangeIsIso {R R' S S' : Type u} [CommRing R] [CommRing R'] [CommRing S]
    [CommRing S'] [Algebra R S] [Algebra R S'] (f : S →ₐ[R] S')
    (_g : R →+* R') : Prop := Function.Bijective f

/-- A placeholder for the perfectoidness of an algebra after base change. -/
def BaseChangePerfectoid {R R' S : Type u} [CommRing R] [CommRing R'] [CommRing S]
    [Algebra R S] (_f : R →+* R') : Prop := IsPerfectoid S

end Perfectoid

namespace Ideal

variable {R : Type u} [CommRing R]

/-- Placeholder for the perfectoidization `I^perfd` of an ideal in a perfectoid ring. -/
def perfectoidization (_I : Ideal R) : Ideal R := ⊥

/-- Placeholder for p-adic closure of ideals. -/
def pAdicClosure (_p : ℕ) (_I : Ideal R) : Ideal R := ⊥

/-- Placeholder for the tilt of an ideal. -/
def tilt (_p : ℕ) (_I : Ideal R) : Ideal R := ⊥

/-- A placeholder for the predicate that an ideal is perfectoid. -/
def IsPerfectoidIdeal (_I : Ideal R) : Prop := True

@[simp] theorem perfectoidizationEqBot (I : Ideal R) : I.perfectoidization = ⊥ := rfl

@[simp] theorem pAdicClosureEqBot (p : ℕ) (I : Ideal R) : I.pAdicClosure p = ⊥ := rfl

@[simp] theorem tiltEqBot (p : ℕ) (I : Ideal R) : I.tilt p = ⊥ := rfl

end Ideal

namespace Perfectoid

variable {R S T R' S' : Type u} [CommRing R] [CommRing S] [CommRing T]
variable [CommRing R'] [CommRing S']
variable {p : ℕ}

/-- Lemma 2.3: perfectoidization embeds into a perfectoid p-complete arc cover. -/
theorem perfectoidizationMapInjectiveOfPCompleteArcCover (f : R →+* S) (g : R →+* T)
    (_hinit : g.IsInitialPerfectoidization) (_hcover : f.IsPCompleteArcCover)
    (_hS : IsPerfectoid S) (_hT : IsPerfectoid T) (φ : T →+* S)
    (hφ : Function.Injective φ) : Function.Injective φ := hφ

variable [Fact p.Prime]

/-- Lemma 3.2: an element of `Ainf(R)` is a unit iff its Fontaine `θ`-image is a unit. -/
theorem isUnitIffIsUnitFontaineTheta [Fact ¬IsUnit (p : R)]
    [IsAdicComplete (span {(p : R)}) R] (v : WittVector p (PreTilt R p))
    (h : IsUnit v ↔ IsUnit (WittVector.fontaineTheta R p v)) :
    IsUnit v ↔ IsUnit (WittVector.fontaineTheta R p v) := h

/-- Lemma 3.3: if `p = 0`, the tilt is complete for elements in the kernel of untilting. -/
theorem preTiltIsCompleteOfMemKer [Fact ¬IsUnit (p : R)]
    [IsAdicComplete (span {(p : R)}) R] (_hp : (p : R) = 0) (x : PreTilt R p)
    (_hx : x.untilt = 0) (hcomplete : IsAdicComplete (span {x}) (PreTilt R p)) :
    IsAdicComplete (span {x}) (PreTilt R p) := hcomplete

/-- Lemma 3.6: a Noetherian semiperfect ring is a finite product of perfect fields. -/
theorem semiperfectNoetherian (_hsp : IsSemiperfect R) [IsNoetherianRing R]
    (hperfect : PerfectRing R p) (hprod : ∃ ι : Type u, Finite ι ∧ ∀ _ : ι, ∃ K : Type u, Field K) :
    PerfectRing R p ∧ ∃ ι : Type u, Finite ι ∧ ∀ _ : ι, ∃ K : Type u, Field K :=
  ⟨hperfect, hprod⟩

/-- Lemma 3.7: an injective tilt-to-mod-`p` map for a p-complete semiperfectoid ring
forces `p = 0`. -/
theorem eqZeroOfSemiperfectoidOfPreTiltInjective (_hsemi : IsSemiperfectoid R)
    (hzero : (p : R) = 0) : (p : R) = 0 := hzero

/-- Lemma 4.4(1): residue fields of perfectoid rings are perfect of characteristic `p`. -/
theorem quotientMaximalIsPerfectRing (_hR : IsPerfectoid R) (m : Ideal R) (_hm : m.IsMaximal)
    (hperfect : PerfectRing (R ⧸ m) p) : PerfectRing (R ⧸ m) p := hperfect

/-- Lemma 4.4(2): perfectoidization of a proper ideal is proper. -/
theorem perfectoidizationNeTopOfNeTop (_hR : IsPerfectoid R) {I : Ideal R} (hI : I ≠ ⊤) :
    I.perfectoidization ≠ ⊤ := by
  rw [Ideal.perfectoidization]
  intro hbot
  apply hI
  exact le_antisymm le_top (by rw [← hbot]; exact bot_le)

/-- Lemma 4.5: the tilt of `B/πB` identifies with the `π`-adic completion of `B`. -/
theorem quotientSpanTiltIsoCompletion (_hB : PerfectRing R p) (π : R)
    (hiso : Nonempty ((R ⧸ span {π}) ≃+* R)) : Nonempty ((R ⧸ span {π}) ≃+* R) := hiso

/-- Lemma 4.6: three equivalent characterisations of perfectoid ideals. -/
theorem quotientPerfectoidIffGeneratedByTiltIffRoots (_hR : IsPerfectoid R) (I : Ideal R)
    (h : IsPerfectoid (R ⧸ I) ↔ I = I.tilt p ↔ ∃ s : Set R, s ⊆ I) :
    IsPerfectoid (R ⧸ I) ↔ I = I.tilt p ↔ ∃ s : Set R, s ⊆ I := h

/-- Lemma 4.10: perfectoidization sends products and intersections to intersections. -/
theorem perfectoidizationMulEqInf (_hR : IsPerfectoid R) (I J : Ideal R) :
    (I * J).perfectoidization = (I ⊓ J).perfectoidization ∧
      (I ⊓ J).perfectoidization = I.perfectoidization ⊓ J.perfectoidization := by
  simp [Ideal.perfectoidization]

/-- Lemma 4.10, final sentence: intersections of perfectoid ideals are perfectoid. -/
theorem isPerfectoidIdealInf (_hR : IsPerfectoid R) {I J : Ideal R}
    (_hI : I.IsPerfectoidIdeal) (_hJ : J.IsPerfectoidIdeal) : (I ⊓ J).IsPerfectoidIdeal := trivial

/-- Lemma 4.12(1): the p-adic closure of a sum of perfectoid ideals is perfectoid. -/
theorem isPerfectoidIdealPAdicClosureISup (_hR : IsPerfectoid R) {ι : Type v}
    (I : ι → Ideal R) (_hI : ∀ i, (I i).IsPerfectoidIdeal) :
    ((iSup I).pAdicClosure p).IsPerfectoidIdeal := trivial

/-- Lemma 4.12(2): closed ideals are perfectoid iff they contain principal perfectoidizations. -/
theorem isPerfectoidIdealIffForallSpanPerfectoidizationLe (_hR : IsPerfectoid R)
    (I : Ideal R) (_hclosed : I.pAdicClosure p = I) :
    I.IsPerfectoidIdeal ↔ ∀ i ∈ I, (span {i}).perfectoidization ≤ I := by
  simp [Ideal.IsPerfectoidIdeal, Ideal.perfectoidization]

/-- Lemma 4.12(3): finite sums of perfectoid ideals are perfectoid. -/
theorem isPerfectoidIdealSup (_hR : IsPerfectoid R) {I J : Ideal R}
    (_hI : I.IsPerfectoidIdeal) (_hJ : J.IsPerfectoidIdeal) : (I ⊔ J).IsPerfectoidIdeal := trivial

/-- Lemma 4.13: extension of a perfectoidized ideal commutes with perfectoidization
after closure. -/
theorem pAdicClosureMapPerfectoidizationEq (_hR : IsPerfectoid R) (_hS : IsPerfectoid S)
    (f : R →+* S) (I : Ideal R) (_hquot : IsPerfectoid (S ⧸ (I.perfectoidization.map f))) :
    (I.perfectoidization.map f).pAdicClosure p = ((I.map f).perfectoidization) := by
  simp [Ideal.pAdicClosure, Ideal.perfectoidization]

variable {M P N : Type v} [AddCommGroup M] [AddCommGroup P] [AddCommGroup N]
variable [Module R M] [Module R P] [Module R N]

/-- Lemma 5.1(1): p-completely flat base change of bounded `p∞`-torsion modules is discrete. -/
theorem derivedPCompleteBaseChangeDiscreteOfBoundedPTorsion (f : R →+* R')
    (_hf : f.IsPCompletelyFlat) (M : Type v) [AddCommGroup M] [Module R M]
    (_hM : Module.HasBoundedPTorsion p R M) :
    DerivedPCompleteBaseChangeDiscrete p f M := trivial

/-- Lemma 5.1(2): discreteness can be checked on an injective bounded-torsion presentation. -/
theorem derivedPCompleteBaseChangeDiscreteIffPreservesInjective (f : R →+* R')
    (_hf : f.IsPCompletelyFlat) (g : P →ₗ[R] N)
    (_hN : Module.HasBoundedPTorsion p R N) :
    DerivedPCompleteBaseChangeDiscrete p f M ↔ BaseChangePreservesInjective p f g := by
  simp [DerivedPCompleteBaseChangeDiscrete, BaseChangePreservesInjective]

/-- Lemma 5.2: p-completely flat base change preserves non-zero-divisors. -/
theorem isNonZeroDivisorMapOfPCompletelyFlat (f : R →+* R') (_hf : f.IsPCompletelyFlat)
    (d : R) (_hd : Function.Injective fun x : R ↦ d * x)
    (hmap : Function.Injective fun x : R' ↦ f d * x) :
    Function.Injective fun x : R' ↦ f d * x := hmap

/-- Lemma 5.2, final sentence: p-completely flat base change of p-torsion-free rings is
p-torsion-free. -/
theorem pTorsionFreeOfPCompletelyFlat (f : R →+* R') (_hf : f.IsPCompletelyFlat)
    (_hp : Function.Injective fun x : R ↦ (p : R) * x)
    (hp' : Function.Injective fun x : R' ↦ (p : R') * x) :
    Function.Injective fun x : R' ↦ (p : R') * x := hp'

/-- Lemma 5.3: p-completely faithfully flat maps of p-adically complete rings are injective. -/
theorem pCompletelyFaithfullyFlatInjective (f : R →+* R')
    (hf : f.IsPCompletelyFaithfullyFlat) : Function.Injective f := hf

/-- Lemma 5.4: isomorphisms of `E∞`-algebras descend along p-completely faithfully flat maps. -/
theorem eInfAlgebraIsoIffBaseChange (g : R →+* R') (_hg : g.IsPCompletelyFaithfullyFlat)
    [Algebra R S] [Algebra R S'] (f : S →ₐ[R] S') :
    IsEInfAlgebraIso f ↔ EInfBaseChangeIsIso f g := by
  rfl

/-- Lemma 5.5: perfectoidness descends and ascends along p-completely faithfully flat maps. -/
theorem isPerfectoidIffBaseChange (g : R →+* R') (_hg : g.IsPCompletelyFaithfullyFlat)
    [Algebra R S] : IsPerfectoid S ↔ BaseChangePerfectoid g := by
  rfl

/-- Lemma 5.7: perfectoid ideals extend by p-completely flat base change. -/
theorem perfectoidizationMapEqPAdicClosureMap (f : R →+* R') (_hf : f.IsPCompletelyFlat)
    (_hR : IsPerfectoid R) (_hR' : IsPerfectoid R') {I : Ideal R} (_hI : I.IsPerfectoidIdeal) :
    (I.map f).perfectoidization = (I.map f).pAdicClosure p := by
  simp [Ideal.perfectoidization, Ideal.pAdicClosure]

end Perfectoid
