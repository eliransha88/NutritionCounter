# Widget Setup Instructions

The widget source files are ready in `NutritionWidget/`. Because a widget extension is a separate Xcode target, you need to complete the setup in Xcode. Follow the steps below exactly.

---

## Step 1 — Add the Widget Extension target

1. Open `NutritionCounter.xcodeproj` in Xcode.
2. Menu: **File → New → Target…**
3. Select **Widget Extension** under the iOS section, click **Next**.
4. Fill in the fields:
   - **Product Name:** `NutritionWidget`
   - **Team:** `27NF894P9T` (auto-fills)
   - **Bundle Identifier:** `com.salesforce.fieldservice.NutritionWidget`
   - **Include Configuration App Intent:** **uncheck** (we supply our own intents)
5. Click **Finish**. When asked to activate the scheme, click **Activate**.

Xcode will generate a stub `NutritionWidget.swift` with a sample widget — **delete it**; you will use the files from this repository instead.

---

## Step 2 — Add the NutritionWidget/ files to the new target

1. In the Project Navigator, select the `NutritionWidget` group Xcode just created.
2. Drag-and-drop (or **File → Add Files to "NutritionCounter"**) all files from the `NutritionWidget/` folder in this repo:
   - `NutritionWidgetBundle.swift`
   - `NutritionWidgetEntryView.swift`
   - `NutritionWidgetEntry.swift`
   - `NutritionWidgetProvider.swift`
   - `NutritionWidgetIntents.swift`
   - `WidgetSharedModels.swift`
   - `WidgetDataStore.swift`
3. In the **Add to targets** sheet, make sure **only `NutritionWidget`** is checked (not the main app).

---

## Step 3 — Enable App Groups on both targets

The widget and the main app share data through an App Group.

### Main app target
1. Select the `NutritionCounter` target → **Signing & Capabilities**.
2. Click **+ Capability** → **App Groups**.
3. Add `group.com.salesforce.fieldservice.NutritionCounter`.

### Widget target
1. Select the `NutritionWidget` target → **Signing & Capabilities**.
2. Click **+ Capability** → **App Groups**.
3. Add the same group: `group.com.salesforce.fieldservice.NutritionCounter`.

The entitlements files (`NutritionCounter.entitlements` and `NutritionWidget/NutritionWidget.entitlements`) are already updated in this repo.

Set the widget target's entitlements file:
1. `NutritionWidget` target → **Build Settings** → search `CODE_SIGN_ENTITLEMENTS`.
2. Set the value to `NutritionWidget/NutritionWidget.entitlements`.

---

## Step 4 — Set the widget's Deployment Target

1. `NutritionWidget` target → **Build Settings** → `IPHONEOS_DEPLOYMENT_TARGET`.
2. Set it to `18.1` (or match the main app's target).

---

## Step 5 — Build and run

Select the **NutritionWidget** scheme and run on a simulator or device. To preview the widget:
- Press ⌘+R with the widget scheme selected and the simulator running.
- Long-press the home screen → tap **+** → search "Nutrition".
- Add the Small, Medium, or Large widget.

---

## Architecture notes

| Component | Location | Role |
|---|---|---|
| `AppGroup.swift` | Main app | Shared constant for suite name and keys |
| `NutritionStore` | Main app | Reads/writes to App Group UserDefaults; calls `WidgetCenter.reloadTimelines` on save |
| `WidgetDataStore` | Widget | Reads/writes same App Group UserDefaults |
| `IncrementNutrientIntent` / `DecrementNutrientIntent` | Widget | `AppIntent` actions triggered by widget buttons; mutate shared store and reload timeline |
| `NutritionWidgetProvider` | Widget | `TimelineProvider`; supplies a `NutritionEntry` snapshot refreshed every hour |
| `NutritionWidgetEntryView` | Widget | SwiftUI views for `.systemSmall`, `.systemMedium`, `.systemLarge` |

### Data flow

```
Home screen tap [+] button
        │
        ▼
IncrementNutrientIntent.perform()
        │  writes to App Group UserDefaults
        │  calls WidgetCenter.reloadTimelines
        ▼
NutritionWidgetProvider.getTimeline()
        │  reads App Group UserDefaults
        ▼
NutritionWidgetEntryView renders updated values
```

When the user opens the main app and changes values there, `NutritionStore.saveData()` also calls `WidgetCenter.reloadTimelines`, keeping the widget in sync.
