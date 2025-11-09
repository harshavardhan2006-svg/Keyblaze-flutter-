# KeyBlaze - Typing Game

## Overview

**KeyBlaze** is a local typing game built with Flutter, designed to help users improve their typing speed and accuracy. The app features a gamified experience with XP systems, achievements, leaderboards, and multiple difficulty levels. The tagline "Type. Blaze. Rise." reflects the progressive nature of skill improvement.

- **Version**: 1.0.0+1
- **SDK**: Flutter ^3.8.1
- **Platforms**: Android, iOS, Linux, macOS, Windows, Web
- **Storage**: Local (SharedPreferences)
- **Themes**: Purple (default) or Cyan neon themes

## Features

### Core Gameplay
- **Typing Arena**: Interactive typing challenges with real-time WPM, accuracy, time, and error tracking
- **Difficulty Levels**: Easy, Medium, Hard with varying text complexity
- **Real-time Feedback**: Live stats updates during typing sessions
- **Confetti Celebrations**: Visual rewards upon completing rounds

### User System
- **User Profiles**: Customizable usernames with avatar initials
- **XP & Levels**: Earn XP based on performance (WPM * Accuracy / 10), level up every 100 XP
- **Streaks**: Track daily typing streaks
- **Personal Bests**: Record highest WPM and best accuracy

### Achievements
- **First Game**: Complete your first typing session
- **3-Day Streak**: Maintain a 3-day typing streak
- **Level 10**: Reach level 10
- **70+ WPM**: Achieve 70+ words per minute
- **100% Accuracy**: Complete a round with perfect accuracy

### Leaderboard & Stats
- **Global Leaderboard**: Rank players by XP, sorted by total XP
- **Game History**: View past game records with detailed stats
- **Personal Stats**: Track progress across all sessions

### Customization
- **Theme Switching**: Toggle between Purple and Cyan neon themes
- **Settings**: Reset all data or change themes

### UI/UX
- **Dark Theme**: Consistent black background with neon accents
- **Responsive Design**: Adapts to different screen sizes
- **Animations**: Smooth transitions, animated text, and confetti effects
- **Neon Aesthetics**: Glowing buttons and borders for a futuristic feel

## Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point, theme management, routing
├── models/                   # Data models
│   ├── user_model.dart       # User profile data
│   ├── game_record.dart      # Individual game session data
│   ├── achievements.dart     # Achievement flags
│   └── leaderboard_entry.dart # Leaderboard entry data
├── services/
│   └── storage_service.dart  # Local storage operations
├── screens/                  # UI screens
│   ├── splash_screen.dart    # Animated intro screen
│   ├── menu_screen.dart      # Main menu with user info
│   ├── arena_screen.dart     # Typing game interface
│   ├── stats_screen.dart     # Achievements and game history
│   ├── leaderboard_screen.dart # Rankings display
│   ├── settings_screen.dart  # App settings
│   └── result_dialog.dart    # Game result popup (currently unused)
├── widgets/                  # Reusable UI components
│   ├── neon_button.dart      # Custom glowing button
│   ├── stat_card.dart        # Stats display card
│   ├── xp_bar.dart           # XP progress bar
│   └── badge_card.dart       # Achievement badge
└── utils/
    └── typing_utils.dart     # Text generation for different levels
```

### Data Models

#### UserModel
Represents user profile information:
- `username`: String (editable)
- `totalXp`: int (cumulative XP)
- `level`: int (calculated as totalXp / 100)
- `streakDays`: int (consecutive days played)
- `highestWpm`: double (personal best WPM)
- `bestAccuracy`: double (personal best accuracy %)

#### GameRecord
Stores data for each completed game:
- `playedAt`: DateTime
- `level`: String (easy/medium/hard)
- `wpm`: double
- `timeSeconds`: int
- `errors`: int
- `accuracy`: double

#### Achievements
Boolean flags for unlocked achievements:
- `firstGame`, `streak3`, `level10`, `wpm70`, `perfect100`

#### LeaderboardEntry
Simplified data for leaderboard display:
- `name`: String
- `xp`: int
- `wpm`: double
- `accuracy`: double

### Services

#### StorageService
Handles all local data persistence using SharedPreferences:
- **User Data**: Save/load user profiles
- **Game Records**: Store and retrieve game history
- **Leaderboard**: Maintain sorted list of top players
- **Achievements**: Track unlocked achievements
- **Theme**: Persist theme preference (purple/cyan)
- **Initialization**: Set up default user on first launch
- **Reset**: Clear all data for fresh start

### Screens

#### SplashScreen
- Animated app title with gradient shader
- Tagline animation using AnimatedTextKit
- Auto-navigates to menu after 4 seconds
- "Enter the Arena" button for manual navigation

#### MenuScreen
- Displays user avatar, username, XP bar
- Navigation buttons: Start Battle, Leaderboard, Stats
- Username editing functionality
- Settings access via app bar

#### ArenaScreen
- Real-time typing interface with target text
- Live stats grid: WPM, Accuracy, Time, Errors
- Text input field with validation
- Confetti animation on completion
- Result dialog with stats and replay options
- XP calculation: `(WPM * Accuracy) / 10`

#### StatsScreen
- Achievements grid with unlock animations
- Game history list with detailed records
- Refresh functionality

#### LeaderboardScreen
- Sorted list of players by XP
- Highlight current user
- Top 3 special styling
- Reset leaderboard option
- Bottom bar showing user's level and XP

#### SettingsScreen
- Theme toggle (Purple/Cyan)
- Data reset functionality

### Widgets

#### NeonButton
- Elevated button with surface color background
- Glowing border using primary color
- Custom padding and border radius

#### StatCard
- Compact card displaying title, value, and icon
- Used for WPM, Accuracy, Time, Errors

#### XPBar
- Linear progress indicator
- Shows current XP vs. next level requirement
- Text labels for current and target XP

#### BadgeCard
- Achievement display with lock/unlock states
- Icon and title for each achievement

### Utils

#### typing_utils.dart
- `getTargetForLevel(String level)`: Returns random text based on difficulty
- **Easy**: Short motivational phrases
- **Medium**: Longer sentences about habits and progress
- **Hard**: Complex sentences about mastery and focus

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8          # iOS-style icons
  shared_preferences: ^2.2.3       # Local data storage
  animated_text_kit: ^4.2.2        # Text animations
  confetti: ^0.7.0                 # Celebration effects

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0            # Code linting
```

## Installation & Setup

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK (included with Flutter)
- Android Studio / Xcode / VS Code for development
- Connected device or emulator

### Steps
1. **Clone/Download**: Place project in desired directory
2. **Navigate**: `cd /home/harsha/StudioProjects/key_blaze`
3. **Install Dependencies**: `flutter pub get`
4. **Run**: `flutter run` (select target platform if prompted)

### Platform-Specific Setup
- **Android**: Ensure Android SDK and emulator/device connected
- **iOS**: macOS with Xcode required
- **Desktop**: Follow Flutter desktop setup guides
- **Web**: `flutter run -d chrome`

## Usage Guide

### First Launch
1. App opens to animated splash screen
2. Automatically navigates to menu after 4 seconds
3. Default user "Player" created

### Profile Setup
1. Tap username in menu to edit
2. Enter desired name and save

### Playing the Game
1. Tap "Start Typing Battle" in menu
2. Select difficulty (passed via arguments, default easy)
3. Type the displayed text as quickly and accurately as possible
4. View real-time stats
5. Complete round to see results and earn XP

### Viewing Progress
- **Stats**: Check achievements and game history
- **Leaderboard**: See how you rank against others
- **Menu**: View current level and XP progress

### Customization
- **Settings**: Toggle between Purple and Cyan themes
- **Reset**: Clear all data for fresh start

## Technical Details

### State Management
- Stateful widgets for screen-level state
- Stream-based theme updates
- Local storage for persistence

### Performance
- Efficient text comparison for real-time feedback
- Timer-based updates (1-second intervals)
- Optimized list views for history/leaderboard

### Data Flow
1. User input triggers stat calculations
2. Game completion saves record and updates user
3. Achievements checked and updated
4. Leaderboard refreshed with new entry

### Calculations
- **WPM**: `(correctChars / 5) / (elapsedMinutes)`
- **Accuracy**: `(correctChars / totalTyped) * 100`
- **XP Gain**: `(WPM * Accuracy) / 10` (rounded)

## Future Enhancements

- Online multiplayer mode
- More difficulty levels and text categories
- Sound effects and haptic feedback
- Cloud sync for cross-device progress
- Advanced statistics and graphs
- Custom text import
- Daily challenges

## Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature-name`
3. Make changes following Flutter best practices
4. Test on multiple platforms
5. Submit pull request

## License

This project is for educational and personal use. See pubspec.yaml for details.

---

*Built with ❤️ using Flutter*
