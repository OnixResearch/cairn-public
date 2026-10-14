# Public Historical Producer Integration

## MODIFIED Requirements

### Requirement: Canonical pinned consumer integration
r[cairn.octet_integration.canonical] Cairn MUST retain the historical `octet` input/check key while selecting the reviewed independent `OnixResearch/slotcar-public` producer, its actual `cargo-slotcar` package and Slotcar configuration tables. Cairn MUST preserve workspace, all-target and existing feature scope and MUST NOT silently select the newer Octet compiler or add fallback aliases.

#### Scenario: Canonical integration resolves
r[cairn.octet_integration.canonical.valid]
- GIVEN the reviewed independent historical producer and current Cairn config
- WHEN Nix evaluates the integration
- THEN the immutable source, actual package and configuration tables resolve
- AND the full consumer scope remains intact

#### Scenario: Changed producer cannot become canonical
r[cairn.octet_integration.canonical.legacy]
- GIVEN a mutation that substitutes a compiler source, package, config table or narrowed scope
- WHEN the integration admission controls run
- THEN the controls reject the mutation

### Requirement: Canonical operator guidance
r[cairn.octet_integration.guidance] Cairn MUST distinguish its historical Slotcar producer from the newer Octet compiler in maintained guidance and MUST retain the `checks.x86_64-linux.octet` protocol command in release-readiness reports. The command list MUST retain other required repository checks and MUST NOT claim that listing a command executes it.

#### Scenario: Operator receives the current command
r[cairn.octet_integration.guidance.valid]
- GIVEN a valid release-readiness request
- WHEN Cairn emits its repository gate summary
- THEN the required command list includes the retained producer check key
- AND the other required repository checks remain present

#### Scenario: Alias command is not substituted
r[cairn.octet_integration.guidance.legacy]
- GIVEN a newly generated release-readiness report
- WHEN the required command list is inspected
- THEN no alternate Slotcar or Tiger Style check key replaces the protocol command

### Requirement: Preserve producer identity and historical evidence
r[cairn.octet_integration.evidence] Public source cutover MUST bind the exact independently published producer revision and observed NAR identity without changing producer semantics, frozen receipts or license-grant anchors. Only Nix MUST generate changes to `flake.lock`. Cairn MUST distinguish source/integration observations from successful execution, lifecycle completion and release admission.

#### Scenario: Independent source identity is explicit
r[cairn.octet_integration.evidence.valid]
- GIVEN an independently reviewed public producer export and observed immutable revision/NAR identity
- WHEN Nix generates the public source lock
- THEN source admission binds those exact public identities
- AND historical receipt bytes and cited original source identities remain unchanged

#### Scenario: Toolchain failure remains a blocker
r[cairn.octet_integration.evidence.blocked]
- GIVEN a producer build that fails before consumer analysis
- WHEN maintainers record verification results
- THEN they record the build as blocked
- AND they do not claim a passing producer check or release admission
