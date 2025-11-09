import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'screens/splash_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/arena_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.initialize();
  runApp(const KeyBlazeApp());
}

class KeyBlazeApp extends StatefulWidget {
  const KeyBlazeApp({Key? key}) : super(key: key);

  @override
  State<KeyBlazeApp> createState() => _KeyBlazeAppState();
}

class _KeyBlazeAppState extends State<KeyBlazeApp> {
  // Theme selection from prefs (purple or cyan)
  late bool useCyan; // false => purple

  @override
  void initState() {
    super.initState();
    useCyan = StorageService.getThemeCyan();
    StorageService.themeStream.listen((val) {
      setState(() => useCyan = val);
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = useCyan ? const Color(0xFF00FFFF) : const Color(0xFFA259FF);
    final secondary = useCyan ? const Color(0xFF00BFBF) : const Color(0xFF8A4BFF);

    final dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: primary,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: const Color(0xFF111111),
        background: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFEAEAEA)),
        bodyMedium: TextStyle(color: Color(0xFFBDBDBD)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      title: 'KeyBlaze',
      theme: dark,
      debugShowCheckedModeBanner: false,
      routes: {
        '/menu': (_) => const MenuScreen(),
        '/arena': (_) => const ArenaScreen(),
        '/stats': (_) => const StatsScreen(),
        '/leaderboard': (_) => const LeaderboardScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
