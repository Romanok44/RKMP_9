part of 'poll_cubit.dart';

@immutable
abstract class PollState {
  const PollState();
}

class PollInitial extends PollState {
  const PollInitial();
}

class PollInProgress extends PollState {
  final String pollId;
  final String pollTitle;
  final String pollCategory;
  final int currentScore;
  final int currentQuestionIndex;

  const PollInProgress({
    required this.pollId,
    required this.pollTitle,
    required this.pollCategory,
    required this.currentScore,
    required this.currentQuestionIndex,
  });

  PollInProgress copyWith({
    String? pollId,
    String? pollTitle,
    String? pollCategory,
    int? currentScore,
    int? currentQuestionIndex,
  }) {
    return PollInProgress(
      pollId: pollId ?? this.pollId,
      pollTitle: pollTitle ?? this.pollTitle,
      pollCategory: pollCategory ?? this.pollCategory,
      currentScore: currentScore ?? this.currentScore,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PollInProgress &&
        other.pollId == pollId &&
        other.pollTitle == pollTitle &&
        other.pollCategory == pollCategory &&
        other.currentScore == currentScore &&
        other.currentQuestionIndex == currentQuestionIndex;
  }

  @override
  int get hashCode {
    return pollId.hashCode ^
    pollTitle.hashCode ^
    pollCategory.hashCode ^
    currentScore.hashCode ^
    currentQuestionIndex.hashCode;
  }
}

class PollCompleted extends PollState {
  final String pollId;
  final String pollTitle;
  final String pollCategory;
  final int finalScore;
  final String result;

  const PollCompleted({
    required this.pollId,
    required this.pollTitle,
    required this.pollCategory,
    required this.finalScore,
    required this.result,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PollCompleted &&
        other.pollId == pollId &&
        other.pollTitle == pollTitle &&
        other.pollCategory == pollCategory &&
        other.finalScore == finalScore &&
        other.result == result;
  }

  @override
  int get hashCode {
    return pollId.hashCode ^
    pollTitle.hashCode ^
    pollCategory.hashCode ^
    finalScore.hashCode ^
    result.hashCode;
  }
}