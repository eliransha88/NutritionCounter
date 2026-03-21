# Nutrition Tracker

A simple iOS app built with SwiftUI that helps users track their daily consumption of protein, carbohydrates, and fats in half-serving increments.

## Features

### Main Screen (Daily Tracker)
- **Current Day Display**: Shows the current day of the week
- **Daily Counters**: Three counters for Protein, Carbs, and Fat
  - Increment/decrement in 0.5 serving increments
  - Range: 0-10 servings per nutrient
  - Large, easy-to-tap buttons
- **Daily Summary Pie Chart**: Visual representation of daily consumption vs. goals
  - Color-coded: Blue (Protein), Orange (Carbs), Green (Fat)
  - Shows total servings consumed
- **Weekly Graph**: Line chart showing daily consumption across the current week
  - Auto-updates based on logged data
  - Resets at the start of each new week

### Settings Screen
- **Daily Goals Configuration**: Set personal targets for each macronutrient
- **0.5 Serving Increments**: All values can be adjusted in half-serving steps
- **Persistent Storage**: Goals are saved and persist between app launches

## Technical Details

- **Framework**: SwiftUI with iOS 18.1+ target
- **Charts**: Uses Swift Charts framework for data visualization
- **Data Persistence**: UserDefaults for storing goals and weekly logs
- **State Management**: ObservableObject pattern with @Published properties
- **Architecture**: MVVM with clean separation of concerns

## Data Model

- **NutrientType**: Enum for Protein, Carbs, and Fat
- **DailyGoals**: Struct for storing user-defined targets
- **DailyLog**: Struct for tracking daily consumption
- **NutritionStore**: ObservableObject managing app state and persistence

## Usage

1. **Set Daily Goals**: Tap the gear icon to access settings and configure your daily targets
2. **Log Consumption**: Use the + and - buttons to track your daily intake
3. **Monitor Progress**: View the pie chart for daily summary and weekly graph for trends
4. **Data Persistence**: All data is automatically saved and persists between app sessions

## Requirements

- iOS 18.1 or later
- Xcode 16.1 or later
- Swift 6.0

## Installation

1. Clone the repository
2. Open `NutritionCounter.xcodeproj` in Xcode
3. Build and run on a device or simulator

## Design Principles

- **Minimal and Clean**: Simple interface focused on quick logging
- **Visual Feedback**: Color-coded charts and clear progress indicators
- **Accessibility**: Large touch targets and clear visual hierarchy
- **Responsive**: Real-time updates as data changes
