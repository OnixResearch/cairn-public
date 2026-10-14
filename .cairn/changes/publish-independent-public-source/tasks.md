# Tasks

- [x] [serial] [task:sources] Bind Cargo/Nix and exact source validators to the independently published public sources, preserving historical profiles and authentication implementation hashes. r[cairn.octet_integration.evidence]
- [x] [serial] [task:producer] [after:sources] Select the actual historical Slotcar package/config API with full consumer scope and no compatibility alias or compiler upgrade. r[cairn.octet_integration.canonical]
- [x] [serial] [task:guidance] [after:producer] Refresh maintained source guidance and generate the public Nix lock with Nickel-export root-self follows. r[cairn.octet_integration.guidance]
- [x] [serial] [task:acquisition] [after:guidance] Observe anonymous exact-source acquisition and Cargo lock resolution without builds, linters, formatters or tests. r[cairn.octet_integration.evidence]
- [ ] [serial] [task:verification] [after:acquisition] Run the real packaged assembly CLI and signed synthetic fixture replay, source/profile checks, policy freshness, repository checks, and native proposal/design/tasks gates; record actual results and remaining external blockers without historical relabelling. r[cairn.octet_integration.evidence]
- [ ] [serial] [task:completion] [after:verification] Use the real CLI to sync the reviewed specification delta and archive only after fresh completion gates pass; push verified branch before non-force fast-forward integration and verify origin/main. r[cairn.octet_integration.canonical]

## Current-source observations — 2026-10-14

Verification and completion above remain pending. This is source-only publication,
not release admission or a completed native archive. The immutable consumer
source remains `e25e782f8dafac98b906b48b9d15c965996e18f9`.

The real CLI used below is
`/nix/store/znlflncm35h6vk8qscs3v709l6fx5n5w-cairn-0.1.0/bin/cairn`,
packaged from that public source. The parent separately observed successful
package construction, `policy export --check`, and both signed synthetic Octet
replays with this exact CLI and reviewed Nickel 1.17.0. The pilot exercised
import/update/checkout/reload and an expected rejection; the conflict replay
observed 18 receipts, 5 commits and one empty synthetic root. These are bounded
parent observations, not new replay runs or release qualification.

The lifecycle worker fixed six missing task concurrency markers and the source
validator's mistaken equality between the four-member Artifact source workspace
and its unchanged three-package historical release profile. Its consumer remains
the exact two authentication packages. No actor code, frozen receipts, identity,
license grant, compiler cohort or profile admission changed.

Commands below ran from this dedicated worktree. Every Nix invocation used
`--extra-experimental-features 'nix-command flakes' --option min-free 0
--option max-free 0 --option access-tokens ''` and a cache under `/tmp`.

- `cairn validate --root /tmp/cairn-public-assembly`: exit 0 after the marker fix;
  the parent's pre-fix failure is retained as a real failing-before observation.
- `cairn gate proposal publish-independent-public-source --root /tmp/cairn-public-assembly`,
  `cairn gate design publish-independent-public-source --root /tmp/cairn-public-assembly`,
  and `cairn gate tasks publish-independent-public-source --root /tmp/cairn-public-assembly`:
  each exit 0. Task structure acceptance does not mean all tasks are complete.
- `nix build path:/tmp/cairn-public-assembly#checks.x86_64-linux.artifact-auth-source-pin
  path:/tmp/cairn-public-assembly#checks.x86_64-linux.check-producer-source-pins
  path:/tmp/cairn-public-assembly#checks.x86_64-linux.octet-integration
  path:/tmp/cairn-public-assembly#checks.x86_64-linux.authenticated-policy-profiles-fresh
  --no-link -L`: exit 0 after the exact workspace-set correction; source drift,
  graph/license/profile rejection controls and authentication implementation
  hashes remain enforced. The pre-correction source-workspace failure was real.
- `nix build path:/tmp/cairn-public-assembly#checks.x86_64-linux.octet --no-link -L`:
  the ambient remote builder failed importing a pinned Rust documentation NAR.
  Retrying the same source/check locally with `--option builders '' --option
  substituters https://cache.nixos.org` exited 0 and actually analyzed the full
  workspace/all-targets/redb-registry consumer. Its output reports **4,830
  findings and 4,830 warnings**. Exit success is not a clean catalog or deny-all
  acceptance; no lint policy or source pin was relaxed.
- `cairn traceability coverage --root /tmp/cairn-public-assembly --json`: exit 1,
  no dangling IDs, 2,332/2,337 referenced. Missing IDs are
  `cairn.octet_integration.canonical`, `.canonical.legacy`, `.canonical.valid`,
  `.evidence.blocked`, and `.evidence.valid` (the latter four share the
  `cairn.octet_integration` prefix). The actual Nix controls are not scanned by
  the frozen Rust/Nickel evidence-source profile. No copied/source-text test or
  unearned marker was added to manufacture coverage.
- `nix flake check path:/tmp/cairn-public-assembly -L --keep-going`: exit 1.
  Rust formatting, Clippy, strict native validation and other reachable checks
  built, but `tracey-coverage`, the initial remote `octet` attempt, and
  `rust-tests` failed. The Rust failure is
  `check_evidence_local::real_developer_loop_profile_receipt_passes_the_original_validator`:
  its real `cairn-local` profile includes the failing traceability command;
  the produced receipt correctly withheld `valid: true`. The later local
  consumer run resolves only the remote consumer-execution failure, not these
  traceability/test blockers or the catalog findings.
- `cairn doctor --root /tmp/cairn-public-assembly/fixtures/basic` and
  `cairn status --root /tmp/cairn-public-assembly/fixtures/basic`: each exit 0.
  Doctor retained the fixture's mixed-layout/missing-archive warnings.

Native sync/archive preview and execution were not attempted because required
completion gates are not all satisfied. The source-only descendant is published
on `public-source-assembly-2026-10-14`; public `main` is not fast-forwarded as a
completed lifecycle. A redacted machine observation with exact argv, exit codes
and bounded evidence is retained in the persistent operator archive as
`cairn-public-final-gates-observation.json`.
