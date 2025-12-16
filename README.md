# BasicBusiness

A modular iOS app for small business management, written in Swift using SwiftUI. This README expands on the project’s features and app elements and gives a feature-by-feature view of what each module offers and what is currently in development.

<!-- TOC -->
- [About](#about)
- [Features](#features)
  - [BusinessStats](#businessstats)
  - [Customers](#customers)
  - [Documents](#documents)
  - [Domain](#domain)
  - [Expenses](#expenses)
  - [Inventory](#inventory)
  - [Materials](#materials)
  - [PricingMethod](#pricingmethod)
  - [Shared](#shared)
  - [User](#user)
- [App elements (key files)](#app-elements-key-files)
- [Tech & Requirements](#tech--requirements)
- [Getting started](#getting-started)
  - [Clone](#clone)
  - [Open in Xcode](#open-in-xcode)
  - [Build & Run](#build--run)
- [Project structure](#project-structure)
- [Code style & formatting](#code-style--formatting)
- [Testing](#testing)
- [Contributing](#contributing)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Contact](#contact)

## About

BasicBusiness is an iOS-first business management app broken into feature modules. The app aims to provide essential small-business functionality — customer records, inventory/materials management, expense tracking, document generation (invoices/quotes), pricing methods, and basic business analytics — in a lightweight, modular SwiftUI codebase.

This README documents each feature with current capabilities and items that are actively being developed or planned. Please review and update any status lines to reflect the true implementation details if they differ.

## Features

Each feature below has a short summary of what it offers and what is being worked on.

### BusinessStats
What it offers
- Dashboards and KPIs for common small-business metrics (revenue, profit, top customers, best-selling items, cashflow overview).
- Time-range filters (daily/weekly/monthly/quarterly).
- Simple visualizations (charts and summary cards).

Currently developing / planned
- Exportable reports (PDF/CSV).
- More granular filter and drilldown (per-customer, per-item).
- Scheduled report generation (background processing).

### Customers
What it offers
- Create, view, edit, and search customer records.
- Store contact details, notes, and simple transaction history.
- Basic list and detail views with sorting and filtering.

Currently developing / planned
- Import/export customers (CSV).
- Syncing support (iCloud or optional backend).
- Communication shortcuts (email/call) and improved customer activity timeline.

### Documents
What it offers
- Create and preview invoices and quotes inside the app.
- Basic document templates with company and customer details.
- Export and share documents as PDF.

Currently developing / planned
- Template customization and saved templates.
- Automated invoice numbering and statuses (draft, sent, paid).
- Integration with payments or export to popular accounting tools.

### Domain
What it offers
- Core domain models and business logic shared by features (e.g., Business, Product, Transaction, Document models).
- Validation and central domain types used across modules.

Currently developing / planned
- Versioned migrations for domain model changes.
- More comprehensive domain-level tests and sample data fixtures.

### Expenses
What it offers
- Track and categorize business expenses.
- Attach photos/receipts (device camera or gallery).
- Basic expense reporting and totals by category.

Currently developing / planned
- Bill payment tracking and recurring expense support.
- OCR for receipt parsing.
- Export expenses for accounting.

### Inventory
What it offers
- Track stock levels for products or SKUs.
- View item details, current quantity, and low-stock indicators.
- Basic adjustments and manual stock operations.

Currently developing / planned
- Reorder thresholds and low-stock alerts.
- Batch operations (bulk edits, imports).
- Integrations for barcode scanning and supplier purchase orders.

### Materials
What it offers
- Track raw materials or components used to build items (BOM-style).
- Link materials to inventory items and track material usage.

Currently developing / planned
- Build/consume workflows (consume materials when creating product shipments).
- Material-level costing and waste/loss reporting.

### PricingMethod
What it offers
- Define how product prices are calculated (fixed price, markup, margin, cost-plus).
- View price breakdowns and suggested retail price calculations.

Currently developing / planned
- Multiple pricing rules per product (volume discounts, customer-specific pricing).
- Scripting or formula editor for advanced pricing strategies.

### Shared
What it offers
- Reusable UI components, utilities, and global services used across features (formatters, buttons, colors, networking helpers).
- Theme and design primitives used by the app (see AppTheme.swift).

Currently developing / planned
- Expand shared components library and documentation.
- Accessibility and localization improvements to shared components.

### User
What it offers
- Basic user account model, preferences, and app settings.
- Local authentication support (device passcode/biometrics).

Currently developing / planned
- Account sync across devices (iCloud or remote auth).
- Role/permission model for multi-user or team scenarios.

(If any of the feature descriptions above are inaccurate or you want different wording, tell me which feature to update and provide the details you'd like included.)

## App elements (key files)

- BasicBusinessApp.swift — App entry point (SwiftUI App).
- MainTabView.swift — Main tab-based navigation and the entry UI for core features.
- AppTheme.swift — Theming primitives: colors, fonts and global style helpers.
- Features/… — Modules for each feature area (see Features section).

These files form the core app lifecycle, primary navigation, and shared design system.

## Tech & Requirements

- Language: Swift (SwiftUI)
- Primary platform: iOS (use the deployment target set in the Xcode project)
- Xcode: Open the project with a compatible Xcode version
- Formatter: SwiftFormat (configured via `.swiftformat`)

If the project uses Swift Package Manager, CocoaPods, or other dependencies, open the Xcode project to resolve packages automatically or check for a `Podfile`/`Package.swift`.

## Getting started

Prerequisites
- Xcode (recommended recent stable release)
- macOS capable of running Xcode and iOS simulators

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
1. Select a scheme (app target) and device/simulator.
2. Build (Cmd+B) and Run (Cmd+R).

If you use SPM packages, Xcode will resolve them when opening the project. If you use CocoaPods, run `pod install` in the iOS directory (if a Podfile exists) and open the `.xcworkspace`.

## Project structure

Top-level
- .swiftformat — code formatter configuration
- BasicBusiness-xcodeproj/ — Xcode project
- BasicBusiness-iOS/ — app source and resources

Inside BasicBusiness-iOS (high level)
- BasicBusinessApp.swift — App entry
- MainTabView.swift — Tab navigation
- AppTheme.swift — App-wide theming
- Features/ — feature modules (BusinessStats, Customers, Documents, Domain, Expenses, Inventory, Materials, PricingMethod, Shared, User)
- Testing/ — test utilities and test targets (if present)

## Code style & formatting

This repository includes a `.swiftformat` file to enforce formatting. To format the code locally:
```bash
brew install swiftformat
swiftformat .
```
Consider adding SwiftLint or pre-commit hooks if you want to enforce linting rules.

## Testing

Run unit/UI tests in Xcode:
- Product -> Test (Cmd+U)

Check the `BasicBusiness-iOS/Testing` folder for test helpers and test targets. Add or extend tests especially around domain logic and pricing calculations.

## Contributing

Thank you for contributing! Suggested workflow:
1. Fork the repo.
2. Create a feature branch: `git checkout -b feat/short-description`
3. Make changes, run formatting and tests locally.
4. Open a pull request with a clear description of what changed and why.

When opening PRs, include:
- What was changed and motivation
- Screenshots or sample data for UI changes
- Any migration or setup steps

If you'd like, I can add a CONTRIBUTING.md with PR templates and issue templates.

## Troubleshooting

- Build errors: ensure Xcode version and Swift toolchain match the project settings. Clean the build folder (Shift+Cmd+K) if needed.
- Missing dependencies: Check Package.swift or Podfile and run appropriate package manager commands.
- Formatting: run `swiftformat .` to apply formatting.

Share specific build logs and I’ll help debug.

## License

Add a LICENSE file to declare the project license (MIT, Apache-2.0, etc.). I can create this for you if you choose a license.

## Contact

Maintainer: PocketMaru — https://github.com/PocketMaru
