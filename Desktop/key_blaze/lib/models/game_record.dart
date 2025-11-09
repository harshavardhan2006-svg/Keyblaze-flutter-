class GameRecord {
  final DateTime playedAt;
  final String level;
  final double wpm;
  final int timeSeconds;
  final int errors;
  final double accuracy;

  GameRecord({
    required this.playedAt,
    required this.level,
    required this.wpm,
    required this.timeSeconds,
    required this.errors,
    required this.accuracy,
  });

  Map<String, dynamic> toJson() => {
    'playedAt': playedAt.toIso8601String(),
    'level': level,
    'wpm': wpm,
    'timeSeconds': timeSeconds,
    'errors': errors,
    'accuracy': accuracy,
  };

  factory GameRecord.fromJson(Map<String, dynamic> json) => GameRecord(
    playedAt: DateTime.parse(json['playedAt']),
    level: json['level'],
    wpm: (json['wpm'] as num).toDouble(),
    timeSeconds: json['timeSeconds'],
    errors: json['errors'],
    accuracy: (json['accuracy'] as num).toDouble(),
  );
}
