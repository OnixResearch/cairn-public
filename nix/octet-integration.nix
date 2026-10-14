# r[verify cairn.octet_integration.canonical] r[verify cairn.octet_integration.evidence]
{
  inputs,
  system,
  root,
  checks,
  devShell,
}:
let
  # inputs.octet retains its historical consumer key, but this is Slotcar,
  # not the newer Octet compiler and not a compatibility alias.
  expectedSource = {
    owner = "OnixResearch";
    repo = "slotcar-public";
    rev = "e0d07898aafd26a307eb4c5579dbd0e7931f991b";
    narHash = "sha256-UOkHaZuLrKHn0XOzwJFqiKfXEIAfsGESK7iHMyoNhro=";
  };
  expectedScope = [ "--workspace" ];
  expectedCargoArgs = [ "--all-targets" ];
  expectedCheckTail = " -- --all-targets --features redb-registry";
  driftRevision = "0000000000000000000000000000000000000000";
  flakeLock = builtins.fromJSON (builtins.readFile "${root}/flake.lock");
  sourceNode = flakeLock.nodes.${flakeLock.nodes.root.inputs.octet};
  workspace = (builtins.fromTOML (builtins.readFile "${root}/Cargo.toml")).workspace;
  lintConfig = builtins.fromTOML (builtins.readFile "${root}/dylint.toml");
  observed = {
    source = {
      inherit (sourceNode.locked) owner repo rev narHash;
    };
    originalRevision = sourceNode.original.rev or null;
    resolvedRevision = inputs.octet.rev;
    resolvedNarHash = inputs.octet.narHash;
    metadataNames = builtins.attrNames workspace.metadata;
    lintConfigNames = builtins.attrNames lintConfig;
    scope = workspace.metadata.slotcar.default_scope or [ ];
    cargoArgs = workspace.metadata.slotcar.cargo_check_args or [ ];
    hasRunner = builtins.elem (toString inputs.octet.packages.${system}.cargo-slotcar) (
      map toString devShell.nativeBuildInputs
    );
    checkCommand = checks.octet.buildCommand;
  };
  contains = text: value: builtins.match ".*${text}.*" value != null;
  valid = value:
    value.source == expectedSource
    && value.originalRevision == expectedSource.rev
    && value.resolvedRevision == expectedSource.rev
    && value.resolvedNarHash == expectedSource.narHash
    && builtins.elem "slotcar" value.metadataNames
    && !(builtins.elem "octet" value.metadataNames)
    && builtins.elem "slotcar" value.lintConfigNames
    && !(builtins.elem "octet" value.lintConfigNames)
    && value.scope == expectedScope
    && value.cargoArgs == expectedCargoArgs
    && value.hasRunner
    && contains "/bin/cargo-slotcar check" value.checkCommand
    && contains expectedCheckTail value.checkCommand;
  negativeCases = {
    changed-repository = observed // { source = observed.source // { repo = "octet-public"; }; };
    source-drift = observed // { source = observed.source // { rev = driftRevision; }; };
    nar-drift = observed // { source = observed.source // { narHash = "changed-source"; }; };
    floating-input = observed // { originalRevision = null; };
    resolved-source-drift = observed // { resolvedRevision = driftRevision; };
    resolved-nar-drift = observed // { resolvedNarHash = "changed-source"; };
    compiler-metadata = observed // { metadataNames = [ "octet" ]; };
    compiler-lint-config = observed // { lintConfigNames = [ "octet" ]; };
    missing-scope = observed // { scope = [ ]; };
    missing-target-scope = observed // { cargoArgs = [ ]; };
    missing-runner = observed // { hasRunner = false; };
    compiler-command = observed // { checkCommand = "/bin/cargo-octet check -- --all-targets --features redb-registry"; };
    missing-check-command = observed // { checkCommand = ""; };
    narrowed-check = observed // { checkCommand = "/bin/cargo-slotcar check -- --lib"; };
  };
  negativeResults = builtins.mapAttrs (_: value: !(valid value)) negativeCases;
  positivePassed = valid observed;
  negativePassed = builtins.all (result: result) (builtins.attrValues negativeResults);
in
{
  valid = positivePassed && negativePassed;
  positive = positivePassed;
  negative = negativeResults;
  source = expectedSource;
  non_claim = "These controls verify the historical producer integration, not Slotcar execution or Rust correctness.";
}
