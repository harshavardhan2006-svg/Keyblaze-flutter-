class LeaderboardEntry {
  final String name;
  final int xp;
  final double wpm;
  final double accuracy;

  LeaderboardEntry({
    required this.name,
    required this.xp,
    required this.wpm,
    required this.accuracy,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'xp': xp,
    'wpm': wpm,
    'accuracy': accuracy,
  };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => LeaderboardEntry(
    name: json['name'] ?? 'Unknown',
    xp: (json['xp'] ?? 0).toInt(),
    wpm: (json['wpm'] ?? 0).toDouble(),
    accuracy: (json['accuracy'] ?? 0).toDouble(),
  );
}
