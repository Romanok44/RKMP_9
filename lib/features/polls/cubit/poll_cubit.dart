import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'poll_state.dart';

class PollCubit extends Cubit<PollState> {
  PollCubit() : super(const PollInitial());

  void startPoll(String pollId, String pollTitle, String pollCategory) {
    emit(PollInProgress(
      pollId: pollId,
      pollTitle: pollTitle,
      pollCategory: pollCategory,
      currentScore: 0,
      currentQuestionIndex: 0,
    ));
  }

  void answerQuestion(int scoreToAdd) {
    if (state is PollInProgress) {
      final currentState = state as PollInProgress;
      emit(currentState.copyWith(
        currentScore: currentState.currentScore + scoreToAdd,
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
      ));
    }
  }

  void completePoll(String result) {
    if (state is PollInProgress) {
      final currentState = state as PollInProgress;
      emit(PollCompleted(
        pollId: currentState.pollId,
        pollTitle: currentState.pollTitle,
        pollCategory: currentState.pollCategory,
        finalScore: currentState.currentScore,
        result: result,
      ));
    }
  }

  void resetPoll() {
    emit(const PollInitial());
  }
}