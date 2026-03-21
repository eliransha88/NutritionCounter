# Nutrition Tracker App Demo

## 🚀 Getting Started

1. **Open the Project**: Open `NutritionCounter.xcodeproj` in Xcode
2. **Build and Run**: Press ⌘+R to build and run the app in the iOS Simulator
3. **Choose Device**: Select iPhone 15 or any modern iPhone simulator

## 📱 App Features Demo

### Main Screen (Daily Tracker)

#### 1. Current Day Display
- The app automatically shows today's day of the week (e.g., "Monday")
- Updates automatically based on the current date

#### 2. Daily Counters
- **Protein Counter**: Blue-themed counter with + and - buttons
- **Carbs Counter**: Orange-themed counter with + and - buttons  
- **Fat Counter**: Green-themed counter with + and - buttons

**Try it out:**
- Tap the + button to increment by 0.5 servings
- Tap the - button to decrement by 0.5 servings
- Values range from 0.0 to 10.0 servings
- Watch the pie chart update in real-time!

#### 3. Daily Summary Pie Chart
- **Visual Representation**: Shows proportion of each nutrient consumed
- **Color Coding**: 
  - 🔵 Blue = Protein
  - 🟠 Orange = Carbs
  - 🟢 Green = Fat
- **Center Display**: Shows total servings consumed
- **Real-time Updates**: Changes as you adjust counters

#### 4. Weekly Graph
- **Line Chart**: Displays daily consumption across the week
- **Auto-updates**: Reflects changes made to daily counters
- **Legend**: Bottom legend shows which line represents each nutrient
- **Weekly Reset**: Automatically resets at the start of each new week

### Settings Screen

#### Accessing Settings
- Tap the gear icon (⚙️) in the top-right corner of the main screen

#### Setting Daily Goals
- **Protein Goal**: Set your daily protein target (0.5 - 10.0 servings)
- **Carbs Goal**: Set your daily carbohydrates target (0.5 - 10.0 servings)
- **Fat Goal**: Set your daily fat target (0.5 - 10.0 servings)

**Try it out:**
- Use + and - buttons to adjust goals in 0.5 serving increments
- Tap "Save Goals" to persist your settings
- Watch the pie chart adjust to show progress toward your goals

## 🔄 Data Persistence

- **Daily Goals**: Saved automatically and persist between app launches
- **Weekly Logs**: Automatically tracks consumption for the current week
- **UserDefaults**: All data is stored locally on the device

## 🎨 Design Features

- **Clean Interface**: Minimal, focused design for quick logging
- **Large Touch Targets**: Easy-to-tap buttons for accessibility
- **Color Consistency**: Same colors used across all charts and UI elements
- **Responsive Layout**: Adapts to different screen sizes
- **Dark Mode Support**: Automatically adapts to system appearance

## 📊 Sample Usage Scenario

1. **Set Your Goals**: 
   - Protein: 3.0 servings
   - Carbs: 4.0 servings
   - Fat: 2.0 servings

2. **Log Your Meals**:
   - Breakfast: +1.0 protein, +1.5 carbs, +0.5 fat
   - Lunch: +1.5 protein, +2.0 carbs, +1.0 fat
   - Dinner: +0.5 protein, +0.5 carbs, +0.5 fat

3. **Monitor Progress**:
   - View pie chart showing daily consumption vs. goals
   - Check weekly graph for trends
   - See total daily intake in the center of the pie chart

## 🛠 Technical Details

- **Framework**: SwiftUI with iOS 18.1+ target
- **Charts**: Swift Charts framework for data visualization
- **Architecture**: MVVM with ObservableObject pattern
- **Data Storage**: UserDefaults with Codable conformance
- **State Management**: @Published properties with automatic UI updates

## 🎯 Key Benefits

- **Quick Logging**: Large buttons for fast nutrient tracking
- **Visual Feedback**: Immediate visual updates as you log
- **Goal Tracking**: See progress toward daily targets
- **Weekly Insights**: Track patterns over time
- **Persistent Data**: No need to re-enter goals or data

## 🔧 Troubleshooting

- **Charts Not Showing**: Ensure you're running on iOS 18.1+ simulator
- **Data Not Saving**: Check that the app has proper permissions
- **UI Not Updating**: Verify that all @Published properties are properly connected

---

**Ready to start tracking your nutrition! 🥗💪**
