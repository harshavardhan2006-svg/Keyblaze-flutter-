import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/game_record.dart';
import '../models/leaderboard_entry.dart';
import '../models/achievements.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static const _userKey = 'kb_user';
  static const _recordsKey = 'kb_records';
  static const _leaderboardKey = 'kb_leaderboard';
  static const _achKey = 'kb_achievements';
  static const _themeKey = 'kb_theme_cyan';

  static final StreamController<bool> _themeCtrl = StreamController.broadcast();
  static Stream<bool> get themeStream => _themeCtrl.stream;

  // Initialize
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey(_userKey)) {
      final u = UserModel(
        username: 'Player',
        totalXp: 0,
        level: 1,
        streakDays: 0,
        highestWpm: 0,
        bestAccuracy: 0,
      );
      await saveUser(u);
    }
  }

  // USER ----------------------------------------------------------------------
  static Future<void> saveUser(UserModel u) async {
    await _prefs.setString(_userKey, jsonEncode(u.toJson()));
  }

  static Future<UserModel> getUser() async {
    final s = _prefs.getString(_userKey);
    if (s == null) {
      final u = UserModel(
        username: 'Player',
        totalXp: 0,
        level: 1,
        streakDays: 0,
        highestWpm: 0,
        bestAccuracy: 0,
      );
      await saveUser(u);
      return u;
    }
    return UserModel.fromJson(jsonDecode(s));
  }

  // RECORDS -------------------------------------------------------------------
  static Future<void> addRecord(GameRecord r) async {
    final list = await getRecords();
    list.insert(0, r);
    final enc = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs.setString(_recordsKey, enc);
  }

  static Future<List<GameRecord>> getRecords() async {
    final s = _prefs.getString(_recordsKey);
    if (s == null) return [];
    final list = jsonDecode(s) as List;
    return list.map((e) => GameRecord.fromJson(e)).toList();
  }

  // LEADERBOARD ---------------------------------------------------------------
  static Future<void> addLeaderboard(LeaderboardEntry e) async {
    final list = await getLeaderboard();
    list.add(e);
    list.sort((a, b) => b.xp.compareTo(a.xp));
    final enc = jsonEncode(list.map((x) => x.toJson()).toList());
    await _prefs.setString(_leaderboardKey, enc);
  }

  static Future<List<LeaderboardEntry>> getLeaderboard() async {
    final s = _prefs.getString(_leaderboardKey);
    if (s == null) return [];
    final list = jsonDecode(s) as List;
    return list.map((e) => LeaderboardEntry.fromJson(e)).toList();
  }

  static Future<void> clearLeaderboard() async {
    await _prefs.remove(_leaderboardKey);
  }

  // ACHIEVEMENTS --------------------------------------------------------------
  static Future<void> saveAchievements(Achievements a) async {
    await _prefs.setString(_achKey, jsonEncode(a.toJson()));
  }

  static Future<Achievements> getAchievements() async {
    final s = _prefs.getString(_achKey);
    if (s == null) {
      final a = Achievements(
        firstGame: false,
        streak3: false,
        level10: false,
        wpm70: false,
        perfect100: false,
      );
      await saveAchievements(a);
      return a;
    }
    return Achievements.fromJson(jsonDecode(s));
  }

  // THEME ---------------------------------------------------------------------
  static bool getThemeCyan() => _prefs.getBool(_themeKey) ?? false;
  static Future<void> setThemeCyan(bool v) async {
    await _prefs.setBool(_themeKey, v);
    _themeCtrl.add(v);
  }

  // RESET ---------------------------------------------------------------------
  static Future<void> resetAll() async {
    await _prefs.clear();
    await initialize();
  }
}
