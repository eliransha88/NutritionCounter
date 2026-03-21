# Nutrition Tracker - Project Structure

## 📁 **Organized Folder Structure**

The project has been reorganized into a clean, modular structure for better maintainability and code organization.

### **🏗️ Root Structure**
```
NutritionCounter/
├── NutritionCounter/
│   ├── Models/           # Data models and business logic
│   ├── Views/            # Main view controllers
│   ├── Components/       # Reusable UI components
│   ├── ContentView.swift # Main app entry point
│   └── NutritionCounterApp.swift
├── NutritionCounter.xcodeproj/
└── README.md
```

### **📊 Models Folder** (`/Models`)
**Purpose**: Data models, business logic, and state management

- **`Models.swift`** - Contains:
  - `NutrientType` enum (Protein, Carbs, Fat)
  - `DailyGoals` struct for user targets
  - `DailyLog` struct for tracking consumption
  - `NutritionStore` class for state management

### **🖥️ Views Folder** (`/Views`)
**Purpose**: Main view controllers and screen layouts

- **`DailyTrackerView.swift`** - Main nutrition tracking screen
- **`SettingsView.swift`** - Daily goals configuration screen

### **🧩 Components Folder** (`/Components`)
**Purpose**: Reusable UI components and widgets

- **`NutrientCounterView.swift`** - Individual nutrient counter with + and - buttons
- **`PieChartView.swift`** - Animated pie chart for daily summary
- **`WeeklyChartView.swift`** - Line chart for weekly consumption trends
- **`NutrientGoalRow.swift`** - Settings row for adjusting daily goals

## 🔄 **Benefits of This Structure**

### **1. Separation of Concerns**
- **Models**: Pure data and business logic
- **Views**: Screen layouts and navigation
- **Components**: Reusable UI elements

### **2. Maintainability**
- Easy to find specific functionality
- Clear responsibility boundaries
- Simplified debugging and testing

### **3. Reusability**
- Components can be used across different views
- Easy to modify individual components
- Consistent UI patterns

### **4. Scalability**
- Easy to add new features
- Simple to extend existing functionality
- Clear structure for team collaboration

## 📱 **File Dependencies**

```
ContentView.swift
└── DailyTrackerView.swift
    ├── NutrientCounterView (from Components)
    ├── PieChartView (from Components)
    └── WeeklyChartView (from Components)
    └── SettingsView.swift
        └── NutrientGoalRow (from Components)
```

## 🎯 **Import Structure**

Each file imports only what it needs:
- **Views**: Import SwiftUI and use Components
- **Components**: Import SwiftUI and use Models
- **Models**: Import Foundation only

## 🚀 **Adding New Features**

### **New Component**
1. Create file in `/Components` folder
2. Follow naming convention: `ComponentNameView.swift`
3. Add preview for testing

### **New View**
1. Create file in `/Views` folder
2. Follow naming convention: `ScreenNameView.swift`
3. Import necessary Components

### **New Model**
1. Create file in `/Models` folder or add to existing `Models.swift`
2. Follow Swift naming conventions
3. Make it `Codable` if it needs persistence

## 📋 **File Naming Conventions**

- **Views**: `ScreenNameView.swift` (e.g., `DailyTrackerView.swift`)
- **Components**: `ComponentNameView.swift` (e.g., `NutrientCounterView.swift`)
- **Models**: `ModelName.swift` or grouped in `Models.swift`

## 🔧 **Build Configuration**

The project maintains the same build configuration:
- **Target**: iOS 18.1+
- **Framework**: SwiftUI
- **Charts**: Swift Charts framework
- **Architecture**: MVVM with ObservableObject

---

**This structure makes the codebase more professional, maintainable, and easier to work with for both individual developers and teams.**
