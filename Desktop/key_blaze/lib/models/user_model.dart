class UserModel {
  final String username;
  final int totalXp;
  final int level;
  final int streakDays;
  final double highestWpm;
  final double bestAccuracy;

  UserModel({
    required this.username,
    required this.totalXp,
    required this.level,
    required this.streakDays,
    required this.highestWpm,
    required this.bestAccuracy,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'totalXp': totalXp,
    'level': level,
    'streakDays': streakDays,
    'highestWpm': highestWpm,
    'bestAccuracy': bestAccuracy,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json['username'],
    totalXp: json['totalXp'],
    level: json['level'],
    streakDays: json['streakDays'],
    highestWpm: (json['highestWpm'] as num).toDouble(),
    bestAccuracy: (json['bestAccuracy'] as num).toDouble(),
  );
}
