# ProVerif Computation Function Changes

This directory analyzes modifications made to ProVerif 2.03 for implementing computation functions as described in "Hash Gone Bad" (USENIX Security'23).

## Key Changes Identified

### New Module Added

Both `SRC` (CLI) and `SRCINTERACT` (interactive mode) builds now include:

- `computation_function.mli` - Interface definitions
- `computation_function.ml` - Core implementation

### Build Variables

- **SRC**: Source files for main `proverif` binary (CLI verifier)
- **SRCINTERACT**: Source files for `proverif_interact` binary (step-by-step mode)

### Files with Substantive Changes (>30 lines)

| File           | Lines Changed | Purpose                    |
| -------------- | ------------- | -------------------------- |
| `pitsyntax.ml` | 1469          | Core syntax/semantics      |
| `termsEq.ml`   | 370           | Equational theory handling |
