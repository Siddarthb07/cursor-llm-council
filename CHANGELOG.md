# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2026-07-07

### Fixed

- Replaced `YOUR_USERNAME` with real GitHub URLs
- Chair must `Read` and paste full `honesty-charter.md` (documented failure mode)
- Uninstall backs up `council.config.yaml` before removal
- Install `--force` lists overwritten skill files; preserves user config
- Persona files require extra review in CONTRIBUTING
- Added `docs/test-prompts.md` and live session transcript
- Documented council-* name collision with Cursor built-in subagents

## [0.2.0] - 2026-07-07

### Added

- `config.example.yaml` and `config.schema.json` for customizable models and weights
- `failure-recovery.md` for retry and partial-council handling
- `council-product.md` persona for deep mode
- `docs/architecture.md`, `docs/customization.md`, `docs/deliberation-modes.md`
- `CONTRIBUTING.md`, GitHub issue/PR templates
- `uninstall.sh` and `uninstall.ps1`

## [0.1.0] - 2026-07-07

### Added

- Initial `llm-council` skill with honesty charter and chair checklist
- Mandatory DevilsAdvocate in standard/deep modes
- Phase -1 pre-flight with token cost disclosure
- Budget / standard / premium model tiers
- Quality gate and Red Team escalation
- Supervisor synthesis with scoring matrix
- Five council personas + supervisor
- Install scripts for Windows and Unix
- Sample REJECT transcript
- MIT license
