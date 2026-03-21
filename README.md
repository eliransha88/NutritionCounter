# Nutrition Counter

A focused iOS app for tracking daily macronutrient intake — protein, carbs, and fat — in half-serving increments. Built entirely with SwiftUI, Swift Charts, and modern Swift Concurrency.

---

## Features

### Daily Tracking
- Three counters (Protein, Carbs, Fat) with + / − buttons in 0.5-serving steps
- Value range clamped to 0 – 10 servings per nutrient
- When a nutrient hits its daily goal the counter card **replaces itself with a congratulations state** (animated trophy + green tint) — counters return automatically if you adjust the value back down
- Donut chart summarising today's intake — shows a "No servings logged yet" empty state on a fresh day
- Auto-updating weekday header that rolls over at midnight without requiring an app restart

### Weekly Overview
- Line chart (Swift Charts) plotting all three nutrients across the current week
- Resets automatically at the start of each new ISO week; fills in any missing days on launch

### Settings
- Per-nutrient daily goal, adjustable in 0.5-serving steps (minimum 0.5)
- Goals and logs persist across launches via an App Group `UserDefaults` suite shared with the widget
- Language row that navigates directly to the app's iOS Settings page for system-managed per-app language selection
- App version displayed in the footer for easy support identification

### Home Screen Widget
- **Small** — compact progress rows with colour-coded capsule bars; shows "✓ Done" badge when a goal is reached
- **Medium** — rows with nutrient name, progress bar, and interactive + button; replaces the button with a trophy "Congrats!" label on completion
- **Large** — full cards per nutrient with − and + AppIntent buttons; congratulations banner replaces the controls when a goal is met
- Tapping widget buttons runs `IncrementNutrientIntent` / `DecrementNutrientIntent` via `AppIntents` — no app launch needed
- Widget reloads its timeline automatically when the main app saves data

### Localisation
- Full **English and Hebrew** support via `Localizable.xcstrings` and `InfoPlist.xcstrings` in both the app and widget targets
- App display name localised: **"Nutrition Counter"** (English) / **"מונה תזונה"** (Hebrew)
- All UI strings, nutrient names, and widget labels are translatable through the Strings Catalog
- Nutrient abbreviations are derived dynamically from the first character of the localised name (no hardcoded letters)
- Switching language is handled at the system level via **Settings → Nutrition Counter → Language**

---

## Architecture

```
NutritionCounter (app target)          NutritionWidgetExtension (widget target)
├── Models/                            ├── WidgetSharedModels.swift
│   ├── NutritionStore.swift           │     WidgetDailyLog / WidgetDailyGoals
│   │   @MainActor @Observable         │     NutrientTypeAppEnum (AppEnum)
│   ├── DailyLog.swift                 ├── WidgetDataStore.swift  (read)
│   ├── DailyGoals.swift               │     WidgetMutationActor  (write)
│   └── NutrientType.swift             ├── NutritionWidgetIntents.swift
├── Views/                             │     IncrementNutrientIntent
│   ├── DailyTrackerView.swift         │     DecrementNutrientIntent
│   └── SettingsView.swift             ├── NutritionWidgetProvider.swift
├── Components/                        └── NutritionWidgetEntryView.swift
│   ├── NutrientCounterView.swift            Small / Medium / Large
│   ├── PieChartView.swift
│   ├── WeeklyChartView.swift
│   └── DayHeaderView.swift (TimelineView)
├── Shared/
│   └── AppGroup.swift
│        App Group: group.com.eliransharabi.NutritionCounter
├── Localizable.xcstrings              (English + Hebrew UI strings)
└── InfoPlist.xcstrings                (Localised app display name)
```

**Key patterns**

| Concern | Solution |
|---|---|
| Observable store | `@MainActor @Observable final class NutritionStore` |
| Widget–app data sharing | App Group `UserDefaults` suite |
| Concurrent widget writes | `actor WidgetMutationActor` serialises `adjustNutrient` |
| Error logging | `os.Logger` (zero-cost in release) |
| Stale date header | `TimelineView(.periodic)` rolls over at midnight |
| Concurrency safety | `SWIFT_STRICT_CONCURRENCY = targeted` on both targets |
| Localisation | `Localizable.xcstrings` + `InfoPlist.xcstrings` (en / he) |
| Language switching | System-managed via iOS Settings (per-app language) |

---

## Requirements

| Requirement | Version |
|---|---|
| iOS | 26.0+ |
| Xcode | 16+ |
| Swift | 5.10 |

---

## Getting Started

```bash
git clone https://github.com/eliransharabi/NutritionCounter.git
cd NutritionCounter
open NutritionCounter.xcodeproj
```

Before building, ensure the **App Group** `group.com.eliransharabi.NutritionCounter` is registered in your Apple Developer account and linked in Signing & Capabilities for both the `NutritionCounter` and `NutritionWidgetExtension` targets.

---

## Project Structure

```
NutritionCounter/
├── NutritionCounter/          Main app target
│   ├── Models/
│   ├── Views/
│   ├── Components/
│   ├── Shared/
│   ├── Localizable.xcstrings
│   └── InfoPlist.xcstrings
├── NutritionWidget/           Widget extension target
│   └── Localizable.xcstrings
└── NutritionCounter.xcodeproj
```

---

## Localisation

The app ships with English and Hebrew translations. To add a new language:

1. Open `NutritionCounter/Localizable.xcstrings` and `NutritionWidget/Localizable.xcstrings` in Xcode.
2. Click **+** next to the language column and select the new locale.
3. Fill in translations for each key — Xcode highlights untranslated strings automatically.
4. Open `NutritionCounter/InfoPlist.xcstrings` and translate `CFBundleDisplayName` / `CFBundleName` for the new locale.
5. Add the locale to the project's *Info → Localizations* list in the project editor.

---

## Privacy

This app stores all data **locally on-device only** using `UserDefaults`. No data is sent to any server, and no tracking or analytics are collected. A `PrivacyInfo.xcprivacy` manifest is included in both targets declaring `UserDefaults` access under reason `CA92.1`.

---

## License

MIT
