import 'dart:math';

List<String> getTargetForLevel(String level) {
  final rand = Random();

  List<String> easy = [
    "fast typing makes perfect",
    "flutter is fun",
    "practice builds confidence",
    "type every day",
    "accuracy is key"
  ];

  List<String> medium = [
    "speed and precision both matter for mastery",
    "building habits creates unstoppable progress",
    "practice typing with rhythm and focus",
    "consistency is the ultimate performance booster"
  ];

  List<String> hard = [
    "precision distinguishes professionals from amateurs in every pursuit",
    "mindful repetition enhances neural pathways for true efficiency",
    "developers achieve mastery through patience, focus, and iteration",
    "consistent deliberate effort produces exponential growth in skill"
  ];

  switch (level.toLowerCase()) {
    case 'medium':
      return [medium[rand.nextInt(medium.length)]];
    case 'hard':
      return [hard[rand.nextInt(hard.length)]];
    default:
      return [easy[rand.nextInt(easy.length)]];
  }
}
