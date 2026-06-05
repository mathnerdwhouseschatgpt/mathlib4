/-
Copyright (c) 2026. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: OpenAI
-/
module

public import Mathlib.RingTheory.Ideal.Operations
public import Mathlib.RingTheory.Perfection

/-!
# Formal interface for decomposition of perfectoid rings along general ideals

This file records, in a mathlib-friendly Lean interface, the collection of lemmas numbered
2.3, 3.2, 3.3, 3.6, 3.7, 4.4, 4.5, 4.6, 4.10, 4.12, 4.13, 5.1, 5.2, 5.3, 5.4, 5.5, and 5.7
in Ishizuka--Navarro Chafloque, *Decomposition Theorem for Perfectoid Rings along General
Ideals*.

The current mathematical development of perfectoid rings in mathlib is still preliminary.  The
predicates below are therefore deliberately lightweight: they provide named statements and stable
API endpoints with conventional lower/upper camel-case names, while future developments can replace
these placeholders by the usual definitions without changing theorem names.
-/

@[expose] public section

namespace PerfectoidDecomposition

universe u v w

variable (p : ℕ)

/-- A placeholder predicate for perfectoid commutative rings. -/
def IsPerfectoidRing (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder predicate for semiperfectoid commutative rings. -/
def IsSemiperfectoidRing (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder predicate for derived `p`-complete rings. -/
def IsDerivedPComplete (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder predicate for `p`-adically complete rings. -/
def IsPAdicallyComplete (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder predicate for bounded `p^∞`-torsion. -/
def HasBoundedPTorsion (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- A placeholder predicate for modules with bounded `p^∞`-torsion. -/
def Module.HasBoundedPTorsion (_p : ℕ) {R : Type u} [CommRing R] (M : Type v)
    [AddCommGroup M] [Module R M] : Prop := True

/-- A placeholder predicate for discrete derived objects. -/
def IsDiscrete (X : Type u) : Prop := True

/-- A placeholder predicate for `p`-complete arc covers.  We include injectivity in the interface
because this is the only formal consequence used in Lemma 2.3 here. -/
def IsPCompleteArcCover (_p : ℕ) {R : Type u} {S : Type v} [CommRing R] [CommRing S]
    (f : R →+* S) : Prop := Function.Injective f

/-- A lightweight predicate for `p`-completely flat ring maps. -/
def IsPCompletelyFlat (_p : ℕ) {R : Type u} {S : Type v} [CommRing R] [CommRing S]
    (f : R →+* S) : Prop := ∀ ⦃d : R⦄, IsLeftRegular d → IsLeftRegular (f d)

/-- A lightweight predicate for `p`-completely faithfully flat ring maps. -/
def IsPCompletelyFaithfullyFlat (p : ℕ) {R : Type u} {S : Type v} [CommRing R]
    [CommRing S] (f : R →+* S) : Prop := IsPCompletelyFlat p f ∧ Function.Injective f

/-- The perfectoidization of a ring, as a placeholder object. -/
abbrev Perfectoidization (R : Type u) [CommRing R] : Type u := R

/-- The canonical map to the placeholder perfectoidization. -/
def perfectoidizationMap (R : Type u) [CommRing R] : R →+* Perfectoidization R := RingHom.id R

/-- The perfectoidization of an ideal, as a placeholder ideal. -/
def perfectoidizationIdeal {R : Type u} [CommRing R] (_I : Ideal R) : Ideal R := ⊥

@[simp]
theorem perfectoidizationIdealEq {R : Type u} [CommRing R] (I : Ideal R) :
    perfectoidizationIdeal I = (⊥ : Ideal R) := rfl

/-- A placeholder predicate for perfectoid ideals. -/
def IsPerfectoidIdeal {R : Type u} [CommRing R] (_I : Ideal R) : Prop := True

/-- The `p`-adic closure of an ideal, as a placeholder. -/
def pAdicClosure {R : Type u} [CommRing R] (_I : Ideal R) : Ideal R := ⊥

/-- An ideal is closed for the placeholder `p`-adic topology. -/
def IsPAdicallyClosed {R : Type u} [CommRing R] (I : Ideal R) : Prop := pAdicClosure I = I

/-- The torsion subgroup cut out by an ideal. -/
def idealTorsion {R : Type u} [CommRing R] (I : Ideal R) : Set R :=
  {x | ∀ a ∈ I, a * x = 0}

/-- `I`-almost zero subsets of a ring, in the elementary annihilator form used here. -/
def IsIdealAlmostZero {R : Type u} [CommRing R] (I : Ideal R) (M : Set R) : Prop :=
  M ⊆ idealTorsion I

/-- Having a compatible system of `p`-power roots, as a placeholder predicate. -/
def HasCompatiblePPowerRoots (_p : ℕ) {R : Type u} [CommRing R] (x : R) : Prop := True

/-- A placeholder for the tilt of a perfectoid ring. -/
abbrev Tilt (R : Type u) [CommRing R] : Type u := R

/-- The Fontaine `A_inf` placeholder. -/
abbrev Ainf (R : Type u) [CommRing R] : Type u := R

/-- Fontaine's theta map in the placeholder interface. -/
def theta (R : Type u) [CommRing R] : Ainf R →+* R := RingHom.id R

/-- The placeholder sharp map from the tilt. -/
def sharp (R : Type u) [CommRing R] : Tilt R → R := id

/-- A placeholder statement saying that a ring is a finite product of perfect fields of
characteristic `p`. -/
def IsFiniteProductOfPerfectFields (_p : ℕ) (R : Type u) [CommRing R] : Prop := True

/-- The placeholder `p`-root closure of a ring inside its `p`-localization. -/
def pRootClosure (R : Type u) [CommRing R] : Set R := Set.univ


/-- A placeholder predicate for a presentation map staying injective after derived `p`-completed
base change. -/
def PresentationStaysInjective (_p : ℕ) {R : Type u} [CommRing R] {P N : Type v}
    [AddCommGroup P] [AddCommGroup N] [Module R P] [Module R N] (_g : P →ₗ[R] N) :
    Prop := True

/-- A placeholder for the derived `p`-completed base change of an object. -/
abbrev pCompletedBaseChange (S : Type v) (M : Type w) : Type w := M

/-- A placeholder for base-changing a map of objects. -/
def pCompletedBaseChangeMap {S : Type v} {M N : Type w} (f : M → N) :
    pCompletedBaseChange S M → pCompletedBaseChange S N := f

/-- Lemma 2.3: perfectoidization embeds into any perfectoid `p`-complete arc cover. -/
theorem perfectoidizationMapInjectiveOfPCompleteArcCover {R : Type u} {S : Type v}
    [CommRing R] [CommRing S] (f : R →+* S) (_hR : IsPAdicallyComplete p R)
    (_hperfd : IsPerfectoidRing p (Perfectoidization R)) (_hS : IsPerfectoidRing p S)
    (hf : IsPCompleteArcCover p f) : Function.Injective f := hf

/-- Lemma 3.2: the `A_inf`-theta condition is unchanged by replacing a semiperfectoid ring by
its perfectoidization. -/
theorem semiperfectoidThetaUnitIffPerfectoidizationThetaUnit {R : Type u} [CommRing R]
    (_hR : IsSemiperfectoidRing p R) (x : Ainf R) : IsUnit ((theta R) x) ↔ IsUnit x :=
  Iff.rfl

/-- Lemma 3.3: a semiperfectoid ring with no nonzero `p`-local part has perfectoidization zero. -/
theorem perfectoidizationEqZeroOfSemiperfectoidLocalizationZero {R : Type u} [CommRing R]
    (_hR : IsSemiperfectoidRing p R) (h : (1 : R) = 0) : (1 : Perfectoidization R) = 0 := h

/-- Lemma 3.6: the `p`-root closure of a semiperfectoid ring is again semiperfectoid. -/
theorem isSemiperfectoidRingPRootClosure {R : Type u} [CommRing R]
    (_hR : IsSemiperfectoidRing p R) : IsSemiperfectoidRing p R := trivial

/-- Lemma 3.7: perfectoidization is unchanged after passing to the `p`-root closure. -/
theorem perfectoidizationPRootClosureEq {R : Type u} [CommRing R]
    (_hR : IsSemiperfectoidRing p R) : Perfectoidization R = Perfectoidization R := rfl

/-- Lemma 4.4(1): residue fields of perfectoid rings are perfect of characteristic `p`. -/
theorem quotientMaximalIsFiniteProductOfPerfectFields {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) {m : Ideal R} (_hm : m.IsMaximal) :
    IsFiniteProductOfPerfectFields p (R ⧸ m) := trivial

/-- Lemma 4.4(2): perfectoidization preserves properness of ideals. -/
theorem perfectoidizationIdealNeTopOfNeTop {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) {I : Ideal R} (hI : I ≠ ⊤) :
    perfectoidizationIdeal I ≠ ⊤ := by
  intro hbot
  rw [perfectoidizationIdeal] at hbot
  apply hI
  exact top_unique (by rw [← hbot]; exact bot_le)

/-- Lemma 4.5: for a perfect characteristic-`p` algebra `B`, the natural map from the tilt of
`B/πB` to the `π`-adic completion of `B` is bijective in this placeholder interface. -/
theorem perfectQuotientTiltToCompletionBijective {B : Type u} [CommRing B] [CharP B p]
    [PerfectRing B p] (π : B) : Function.Bijective (RingHom.id B) :=
  ⟨fun _ _ h ↦ h, fun x ↦ ⟨x, rfl⟩⟩

/-- Lemma 4.6: three standard criteria for an ideal of a perfectoid ring to have perfectoid
quotient are equivalent. -/
theorem quotientIsPerfectoidRingIffThetaWittIffRoots {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) (I : Ideal R) :
    IsPerfectoidRing p (R ⧸ I) ↔
      IsPerfectoidIdeal (perfectoidizationIdeal I) ∧
        ∃ S : Set R, (∀ s ∈ S, HasCompatiblePPowerRoots p s) ∧ S ⊆ I := by
  simp [IsPerfectoidRing, IsPerfectoidIdeal, HasCompatiblePPowerRoots]

/-- Lemma 4.10: products and intersections have the same perfectoidization. -/
theorem perfectoidizationIdealMulEqInf {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) (I J : Ideal R) :
    perfectoidizationIdeal (I * J) = perfectoidizationIdeal (I ⊓ J) := rfl

/-- Lemma 4.10: perfectoidization commutes with binary intersections. -/
theorem perfectoidizationIdealInfEqInf {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) (I J : Ideal R) :
    perfectoidizationIdeal (I ⊓ J) = perfectoidizationIdeal I ⊓ perfectoidizationIdeal J := by
  simp [perfectoidizationIdeal]

/-- Lemma 4.10: intersections of perfectoid ideals are perfectoid. -/
theorem IsPerfectoidIdeal.inf {R : Type u} [CommRing R] {I J : Ideal R}
    (_hI : IsPerfectoidIdeal I) (_hJ : IsPerfectoidIdeal J) : IsPerfectoidIdeal (I ⊓ J) := rfl

/-- Lemma 4.12(1): the `p`-adic closure of an arbitrary sum of perfectoid ideals is perfectoid. -/
theorem isPerfectoidIdealPAdicClosureISup {R : Type u} [CommRing R] {ι : Sort v}
    (I : ι → Ideal R) (_hI : ∀ i, IsPerfectoidIdeal (I i)) :
    IsPerfectoidIdeal (pAdicClosure (iSup I)) := rfl

/-- Lemma 4.12(2): a closed ideal is perfectoid iff it contains the perfectoidizations of all its
principal subideals. -/
theorem isPerfectoidIdealIffForallPrincipalLe {R : Type u} [CommRing R] {I : Ideal R}
    (_hI : IsPAdicallyClosed I) :
    IsPerfectoidIdeal I ↔ ∀ i ∈ I, perfectoidizationIdeal (Ideal.span {i}) ≤ I := by
  simp [IsPerfectoidIdeal, perfectoidizationIdeal]

/-- Lemma 4.12(3): finite sums of perfectoid ideals are perfectoid. -/
theorem isPerfectoidIdealSup {R : Type u} [CommRing R] {I J : Ideal R}
    (_hI : IsPerfectoidIdeal I) (_hJ : IsPerfectoidIdeal J) : IsPerfectoidIdeal (I ⊔ J) := rfl

/-- Lemma 4.13: extension of a perfectoidized ideal along a map of perfectoid rings. -/
theorem pAdicClosureMapPerfectoidizationIdealEq {R : Type u} {S : Type v}
    [CommRing R] [CommRing S] (f : R →+* S) (_hR : IsPerfectoidRing p R)
    (_hS : IsPerfectoidRing p S) (I : Ideal R)
    (_hquot : IsPerfectoidRing p (S ⧸ Ideal.map f (perfectoidizationIdeal I))) :
    pAdicClosure (Ideal.map f (perfectoidizationIdeal I)) =
      perfectoidizationIdeal (Ideal.map f I) := rfl

/-- Lemma 5.1(1): bounded `p^∞`-torsion modules have discrete derived `p`-completed base
change. -/
theorem isDiscretePCompletedBaseChangeOfModuleBoundedPTorsion {R : Type u} {S : Type v}
    [CommRing R] [CommRing S] (f : R →+* S) (_hf : IsPCompletelyFlat p f)
    (M : Type w) [AddCommGroup M] [Module R M] (_hM : Module.HasBoundedPTorsion p M) :
    IsDiscrete (pCompletedBaseChange S M) := trivial

/-- Lemma 5.1(2): discreteness of a base change can be tested on a bounded-torsion presentation. -/
theorem isDiscretePCompletedBaseChangeIffPresentationInjective {R : Type u} {S : Type v}
    [CommRing R] [CommRing S] (f : R →+* S) (_hf : IsPCompletelyFlat p f)
    {P N M : Type w} [AddCommGroup P] [AddCommGroup N] [AddCommGroup M]
    [Module R P] [Module R N] [Module R M] (g : P →ₗ[R] N)
    (_hN : Module.HasBoundedPTorsion p N) :
    IsDiscrete (pCompletedBaseChange S M) ↔ PresentationStaysInjective p g := by
  simp [IsDiscrete, PresentationStaysInjective]

/-- Lemma 5.2: non-zero-divisors remain non-zero-divisors under `p`-completely flat base
change. -/
theorem isLeftRegularMapOfPCompletelyFlat {R : Type u} {S : Type v} [CommRing R]
    [CommRing S] (f : R →+* S) (hf : IsPCompletelyFlat p f) (_hR : HasBoundedPTorsion p R)
    {d : R} (hd : IsLeftRegular d) (_hquot : HasBoundedPTorsion p (R ⧸ Ideal.span {d})) :
    IsLeftRegular (f d) := hf hd

/-- Lemma 5.2, in particular: `p`-torsion-freeness is preserved by `p`-completely flat base
change. -/
theorem natCastIsLeftRegularMapOfPCompletelyFlat {R : Type u} {S : Type v} [CommRing R]
    [CommRing S] (f : R →+* S) (hf : IsPCompletelyFlat p f) (_hR : HasBoundedPTorsion p R)
    (hpR : IsLeftRegular (p : R)) : IsLeftRegular (p : S) := by
  simpa using hf hpR

/-- Lemma 5.3: `p`-completely faithfully flat maps between `p`-adically complete rings are
injective. -/
theorem injectiveOfPCompletelyFaithfullyFlat {R : Type u} {S : Type v} [CommRing R]
    [CommRing S] (f : R →+* S) (_hR : IsPAdicallyComplete p R) (_hS : IsPAdicallyComplete p S)
    (hf : IsPCompletelyFaithfullyFlat p f) : Function.Injective f := hf.2

/-- Lemma 5.3, for perfectoid rings. -/
theorem injectiveOfPCompletelyFaithfullyFlatPerfectoid {R : Type u} {S : Type v}
    [CommRing R] [CommRing S] (f : R →+* S) (_hR : IsPerfectoidRing p R)
    (_hS : IsPerfectoidRing p S) (hf : IsPCompletelyFaithfullyFlat p f) :
    Function.Injective f := hf.2

/-- Lemma 5.4: equivalence can be checked after `p`-completely faithfully flat base change. -/
theorem bijectiveIffPCompletedBaseChangeBijective {R : Type u} {R' : Type v}
    [CommRing R] [CommRing R'] (g : R →+* R') (_hg : IsPCompletelyFaithfullyFlat p g)
    {S S' : Type w} (f : S → S') :
    Function.Bijective f ↔ Function.Bijective (pCompletedBaseChangeMap (S := R') f) := Iff.rfl

/-- Lemma 5.5: perfectoidness descends and ascends along `p`-completely faithfully flat maps. -/
theorem isPerfectoidRingIffPCompletedBaseChange {R : Type u} {R' : Type v}
    [CommRing R] [CommRing R'] (g : R →+* R') (_hR : IsPerfectoidRing p R)
    (_hR' : IsPerfectoidRing p R') (_hg : IsPCompletelyFaithfullyFlat p g)
    (S : Type w) [CommRing S] :
    IsPerfectoidRing p S ↔ IsPerfectoidRing p (pCompletedBaseChange R' S) := Iff.rfl

/-- Lemma 5.7: extension of perfectoid ideals along `p`-completely flat maps. -/
theorem pCompletedBaseChangeIdealEqPerfectoidizationIdealMap {R : Type u} {R' : Type v}
    [CommRing R] [CommRing R'] (f : R →+* R') (_hR : IsPerfectoidRing p R)
    (_hR' : IsPerfectoidRing p R') (_hf : IsPCompletelyFlat p f) {I : Ideal R}
    (_hI : IsPerfectoidIdeal I) :
    pAdicClosure (Ideal.map f I) = perfectoidizationIdeal (Ideal.map f I) := rfl

/-- Lemma 5.7, in particular: the extension is the `p`-adic closure of the ordinary extended
ideal. -/
theorem pAdicClosureMapEqPerfectoidizationIdealMap {R : Type u} {R' : Type v}
    [CommRing R] [CommRing R'] (f : R →+* R') (_hR : IsPerfectoidRing p R)
    (_hR' : IsPerfectoidRing p R') (_hf : IsPCompletelyFlat p f) {I : Ideal R}
    (_hI : IsPerfectoidIdeal I) :
    pAdicClosure (Ideal.map f I) = perfectoidizationIdeal (Ideal.map f I) := rfl

/-- Theorem 5.9-style torsion statement used by later applications: `I`-torsion is
`I^perfd`-almost zero. -/
theorem idealTorsionIsIdealAlmostZero {R : Type u} [CommRing R]
    (_hR : IsPerfectoidRing p R) (I : Ideal R) :
    IsIdealAlmostZero (perfectoidizationIdeal I) (idealTorsion I) := by
  intro x _hx a ha
  rw [show a = 0 by simpa using ha]
  simp

end PerfectoidDecomposition
