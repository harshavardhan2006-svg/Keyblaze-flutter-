class Achievements {
  final bool firstGame;
  final bool streak3;
  final bool level10;
  final bool wpm70;
  final bool perfect100;

  Achievements({
    required this.firstGame,
    required this.streak3,
    required this.level10,
    required this.wpm70,
    required this.perfect100,
  });

  Map<String, dynamic> toJson() => {
    'firstGame': firstGame,
    'streak3': streak3,
    'level10': level10,
    'wpm70': wpm70,
    'perfect100': perfect100,
  };

  factory Achievements.fromJson(Map<String, dynamic> json) => Achievements(
    firstGame: json['firstGame'] ?? false,
    streak3: json['streak3'] ?? false,
    level10: json['level10'] ?? false,
    wpm70: json['wpm70'] ?? false,
    perfect100: json['perfect100'] ?? false,
  );

  static Achievements empty() => Achievements(
    firstGame: false,
    streak3: false,
    level10: false,
    wpm70: false,
    perfect100: false,
  );
}
