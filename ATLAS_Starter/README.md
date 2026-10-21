# ORUN ATLAS Starter Package

Small starter for the Avalonia quiet-board shell and the local SQLite data contract.

## Contents

- `ATLAS.App/` — Avalonia (C# / AXAML) Windows desktop project
  - Quiet board by default
  - Large exception type (KEEP-SEPARATE COLLISION demo)
  - SENTINEL post status only
  - ORUN logo placeholder (replace with actual ORUNLogo asset)
- `ATLAS.Data/`
  - `schema.sql` — encrypted SQLite starter schema (roster, keep-separates, observation ticks, append-only EventLog)
  - `IAtlasDataStore.cs` — data contract stub with sync hooks for later Azure SQL

## Constraints honored

- Exception-first / quiet board
- SENTINEL as post status only
- No auto-actions
- Append-only immutable log
- Offline-first ready

## Next

1. Open `ATLAS.App` in Visual Studio or `dotnet` CLI and restore packages.
2. Replace the logo placeholder with the real ORUNLogo.
3. Bind the ViewModel to a real `IAtlasDataStore` implementation.
4. Add the gRPC stub for SENTINEL status.

Internal • ORUN Project • 12 October 2026
