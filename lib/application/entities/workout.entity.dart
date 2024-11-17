class Workout {
  final String name;
  final int sets;
  final int defaultReps;
  final int defaultWeight;
  List<int?> weight;
  List<int?> reps;
  List<bool> completed;
  List<int> restTimes;

  Workout({
    required this.name,
    required this.sets,
    required this.defaultReps,
    required this.defaultWeight,
  })  : weight = List.filled(sets, defaultWeight),
        reps = List.filled(sets, defaultReps),
        completed = List.filled(sets, false),
        restTimes = List.filled(sets, 0);
}
