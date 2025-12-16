# BasicBusiness

BasicBusiness is a modular, SwiftUI iOS application built from real small‑business workflows. It is not a SaaS product or a generic “business app” template — it’s an opinionated, local‑first toolkit focused on maintainable code, clear source‑of‑truth architecture, and feature‑based modularity.

This README documents the app’s design, what is implemented today, and what is planned. Sections marked "Planned / In Development" call out features or work that are intentionally deferred or in progress.

<!-- TOC -->
- [About](#about)
- [Features](#features)
  - [BusinessStats](#businessstats)
  - [Customers](#customers)
  - [Documents (Quotes & Invoices)](#documents-quotes--invoices)
  - [Materials](#materials)
  - [Inventory](#inventory)
  - [PricingMethod](#pricingmethod)
  - [Shared](#shared)
  - [User](#user)
- [App elements (key files)](#app-elements-key-files)
- [Architecture & Philosophy](#architecture--philosophy)
- [Data & Persistence](#data--persistence)
- [Tech & Requirements](#tech--requirements)
- [Getting started](#getting-started)
  - [Clone](#clone)
  - [Open in Xcode](#open-in-xcode)
  - [Build & Run](#build--run)
- [Project structure](#project-structure)
- [Code style & formatting](#code-style--formatting)
- [Testing](#testing)
- [Contributing](#contributing)
- [Planned work / Roadmap](#planned-work--roadmap)
- [Troubleshooting & Notes](#troubleshooting--notes)
- [License](#license)
- [Contact](#contact)

## About

BasicBusiness is a local‑first iOS app built with SwiftUI and MVVM patterns. Its primary goals are:

- Support real‑world business workflows (invoicing, quoting, expense logging, customer history).
- Maintain a single, explicit source of truth for domain data.
- Keep Views dumb and place logic in ViewModels and container functions.
- Provide clean, testable, and modular Swift code that can be extended over time.

This project is intended as a long‑term open‑source / portfolio project — practical, honest, and focused on correctness rather than marketing.

## Features

Each feature below shows "Implemented" (what you can expect today) and "Planned / In Development" where relevant.

### BusinessStats
Implemented
- Navigation and insight hub for the app — not a standalone analytics engine.
- “Stat bubbles” (summary metrics) that are tappable and link directly into underlying entities (customers, invoices, expenses).
- Journal view that organizes recent activity by month (paid invoices, unpaid rollovers, quotes, expenses). The Journal is designed to be navigable to the corresponding document or customer.

Planned / In Development
- Exportable monthly reports (PDF/CSV).
- Additional drill‑down filters and scheduled report generation.

### Customers
Implemented
- Customers are the core entity. Documents (quotes & invoices) belong to customers.
- Create, edit, and search customer records.
- Basic activity view that surfaces related documents and journal entries.

Planned / In Development
- CSV import/export for customer lists.
- iCloud/remote sync option (designed as optional).

### Documents (Quotes & Invoices)
Implemented
- Documents are strongly tied to Customers.
- Supports Quotes and Invoices.
- Quotes can be converted into Invoices.
- Conversion flow can optionally log used Materials as Expenses.

Planned / In Development
- Template customization, numbering, and document status lifecycle (draft, sent, paid).
- Payment integrations (future-facing, optional).

### Materials
Implemented
- Reusable catalog of materials/components intended to simplify pricing and costing.
- Materials provide cost and unit information to support pricing calculations and quotes.

Important clarification
- Materials do NOT track inventory quantity. They are a pricing/catalog convenience, not a stock ledger.

Planned / In Development
- Better linking between Materials and Document line items (bulk actions, presets).

### Inventory
Implemented
- Inventory quantity tracking is intentionally optional and currently deferred.
- The app exposes structures and domain models to support inventory later, but product quantity decrementing is not a required part of the core local workflows today.

Planned / In Development
- Optional inventory quantity tracking as a separate feature.
- A dedicated rental inventory system (planned separately to preserve a clean domain model).

### PricingMethod
Implemented
- Real‑world pricing logic is supported: fixed prices, markup, margin, cost‑plus styles, and explicit cost fields.
- PricingMethod is designed to be applied per product or per document line item and to produce reproducible price breakdowns.

Planned / In Development
- Multiple pricing rules, customer‑specific pricing, and advanced formula composition.

### Shared
Implemented
- Shared UI components, formatters, and utilities live in a Shared module (colors, typography, buttons, networking helpers).
- The app theme and style primitives are centralized in `AppTheme.swift`.

Planned / In Development
- Expanded component documentation and accessibility checks.

### User
Implemented
- Local‑first user/settings model: preferences, app settings, and local authentication (passcode/biometrics) are supported.
- No remote user authentication is required for the core app experience.

Planned / In Development
- Optional account sync for multi‑device setups (iCloud or optional backend).

---

If a feature description above appears incorrect, please point me to the source file or describe the desired change and I will update the README.

## App elements (key files)

- BasicBusinessApp.swift — SwiftUI App entry point and bootstrap orchestration.
- MainTabView.swift — primary tab navigation for core features.
- AppTheme.swift — app colors, fonts, and UI primitives.
- Features/* — each feature is implemented as a feature folder (BusinessStats, Customers, Documents, Domain, Expenses, Inventory, Materials, PricingMethod, Shared, User).
- BasicBusiness-iOS/Testing — test helpers and test targets.

These files define lifecycle, navigation, theming, and per‑feature composition.

## Architecture & Philosophy

- SwiftUI + MVVM-style structure. Views are intentionally simple; business logic lives in ViewModels and domain services.
- Domain models are central and reused across features. Models are explicit: they own their own persistence responsibilities and validation.
- The app avoids SwiftData by design. Persistence is implemented with Codable models and file‑based JSON.
- Persistence and load flows use async/await. The app includes a bootstrap phase which restores domain models from disk before normal app usage.
- Source‑of‑truth consistency is prioritized over convenience abstractions; explicit save/load flows and versioning are preferred to hidden side effects.

Design goals
- Predictable, testable data flows.
- Minimal implicit global state.
- Explicit ownership: each major model manages its save/load lifecycle.

## Data & Persistence

How data is stored
- Local, file‑based JSON persisted to the app sandbox (Documents/Application Support).
- Models conform to Codable and expose async save/load APIs; each major model is responsible for its own file(s).

App bootstrap
- On launch the app runs a central bootstrap/loader which sequentially restores models from disk using async/await.
- The bootstrap phase reconstructs the app’s source of truth before Views begin normal interactions.

Backups & export
- Manual backup/export is exposed in app settings (planned and partially implemented). The model files can be exported as JSON for manual backups.
- Cloud sync is optional and future‑facing — the current design keeps data local by default. Any cloud sync will be an opt‑in extension.

Migrations
- The project favors explicit model versioning and migration code. Migration helpers are planned to evolve JSON formats safely.

Important notes
- Avoid assuming server or automatic sync. The app is designed to be fully usable offline.
- Because each model takes responsibility for persistence, testing save/load logic is straightforward and isolated.

## Tech & Requirements

- Language: Swift (SwiftUI)
- Patterns: MVVM-style ViewModels with domain services
- Persistence: Codable + file‑based JSON (no SwiftData)
- Async: async/await used for IO and background tasks
- Formatter: SwiftFormat (`.swiftformat` present)
- Recommended: a recent Xcode stable release compatible with the Swift toolchain used in the project

## Getting started

Prerequisites
- Xcode installed (compatible with the project’s Swift toolchain).
- A Mac that supports Xcode and iOS simulators.

Clone
```bash
git clone https://github.com/PocketMaru/BasicBusiness.git
cd BasicBusiness
```

Open in Xcode
- Double-click `BasicBusiness.xcodeproj` or:
```bash
open BasicBusiness.xcodeproj
```

Build & Run
1. Choose a scheme and simulator/device.
2. Build (Cmd+B) and Run (Cmd+R).

Notes
- If you add package dependencies, Xcode will prompt to resolve them.
- If a Podfile is added in the future, use `pod install` and open the generated workspace.

## Project structure

High level
- .swiftformat — code formatting rules
- BasicBusiness.xcodeproj — Xcode project
- BasicBusiness-iOS/ — app source and feature modules

Inside BasicBusiness-iOS
- BasicBusinessApp.swift
- AppTheme.swift
- MainTabView.swift
- Features/
  - BusinessStats/
  - Customers/
  - Documents/
  - Domain/
  - Expenses/
  - Inventory/
  - Materials/
  - PricingMethod/
  - Shared/
  - User/
- Testing/ — test helpers and test targets

Feature modules are intentionally scoped: UI, ViewModel, and domain models live close together, and persistence is colocated with the authoritative model.

## Code style & formatting

- SwiftFormat is configured in `.swiftformat`. Run locally:
```bash
brew install swiftformat
swiftformat .
```
- Keep Views thin; prefer putting logic into ViewModels or domain services.
- Write small, testable domain types and expose save/load as async functions.

## Testing

- Unit and integration tests live under `BasicBusiness-iOS/Testing` (see the folder for helpers).
- Focus tests on domain models, pricing calculations, and persistence (save/load/migration).
- Run tests in Xcode: Product → Test (Cmd+U).

## Contributing

This project welcomes contributions that align with the codebase philosophy (modular, local‑first, clear source‑of‑truth).

Suggested workflow
1. Fork the repo.
2. Create a descriptive branch: `git checkout -b feat/<short-description>`.
3. Implement and format code; include or update tests for domain logic and persistence.
4. Open a pull request with a clear summary of changes, rationale, and any migration steps.

When contributing
- Add or update tests for domain behavior.
- Keep Views declarative and move side effects into ViewModels/services.
- Document persistence schema changes and provide migration code where appropriate.

If you want, I can prepare PR templates or a CONTRIBUTING.md with checklists and testing expectations.

## Planned work / Roadmap

Short term
- Exportable PDF/CSV reports from BusinessStats.
- Improved Quote → Invoice lifecycle (numbering, statuses).
- Backup/restore UX for JSON model files.

Medium term
- Optional cloud sync (opt‑in, user controlled).
- Inventory quantity tracking as an optional module.
- More robust migrations and versioning for JSON formats.

Long term
- Integrations (payments, accounting exports) as optional adapters.
- Team/role support and server-backed sync as a clearly separated opt‑in feature.

## Troubleshooting & Notes

- Build issues: check your Xcode version and Swift toolchain. Clean build folder (Shift+Cmd+K) if necessary.
- Persistence debugging: JSON files live in the app sandbox — you can inspect them via the simulator’s file system or the device backup.
- If you change domain schemas, add a migration path and tests to ensure old JSON files can be loaded safely.

## License

Choose and add an explicit license file (e.g., MIT, Apache‑2.0). I can add a LICENSE file for you if you tell me which license to use.

## Contact

Maintainer: PocketMaru — https://github.com/PocketMaru
