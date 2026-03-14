sealed class Result {
  const Result();
}

class Win extends Result {
  const Win({
    this.reward = 0,
  });

  final int reward;
}

enum LoseReason {
  time,
  error,
}

class Lose extends Result {
  const Lose({
    required this.reason,
  });

  final LoseReason reason;
}
