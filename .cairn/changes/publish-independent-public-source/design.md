# Design

## Source ownership and cycle break

Cairn's dedicated `public-source-assembly-2026-10-14` worktree starts at public independent base `2dea0840b5b6403a5ebce2608bc53dc4e6cae445`. Its parent `6b7e19531554714b6760e8cacc2a980e576d36af` retains the previously exercised native actor fix and remains publicly reachable. No native actor implementation changes are part of this assembly.

Artifact is non-flake public base `f379f2583b5d152cfd6d58919738652861793c90` with observed NAR `sha256-dTexT+CcfyYZLtA1c8K41Z1rjJh/sewlNuDSQssKNm8=`. Its historical profile repository is deliberately preserved and validated separately from the public Git transport. Authentication source hashes, two-package consumer graph, licenses, publish restrictions, profile and drift rejection remain enforced.

Bounded Exec selects `ff4af395b2c415fddd1ed51f4829aeba2d4259a5` from `bounded-exec-public`, NAR `sha256-n9UZx4GlhDLShotMNBSVisIJpTrkqLYs2LtW2dcipCQ=`. The local executor source binding changes with Cargo/Nix selection; execution semantics do not.

The historical `octet` input originally selected producer `2f8213a88781d9d38bb81319d06a50805d48ccd3`, not the newer Octet compiler. Its independent Slotcar export is `e0d07898aafd26a307eb4c5579dbd0e7931f991b`, NAR `sha256-UOkHaZuLrKHn0XOzwJFqiKfXEIAfsGESK7iHMyoNhro=`. The real package is `cargo-slotcar`; maintained config uses Slotcar tables with unchanged workspace/all-targets/redb-registry scope. No alias is added. Historical receipts and active unrelated work remain untouched.

Nickel-export remains at `257fafc1c746f1faf156207043a4c826bfb16d49`; `inputs.cairn.follows = ""` selects this assembly for its validation-only lifecycle tooling. Nix generated a lock without the historical private Cairn/Slotcar subgraph. This follows does not bypass Nickel-export lifecycle checks or grant release authority. Nickel 1.17.0 remains pinned to upstream `1320a983e6c3d1e2fb53dd2464b084b4903b1426`.

## Verification ownership

The assembly worker performs lock generation and anonymous source-fetch observations only. The parent owns the one actual packaged CLI build, signed-fixture replay, policy freshness, source/profile checks, strict repository checks and lifecycle proposal/design/tasks gates. Only after fresh evidence can the change sync/archive and integrate through the repository's non-force-push lifecycle. Historical catalog failures are not greened by publication.
