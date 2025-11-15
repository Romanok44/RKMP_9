part of 'history_cubit.dart';

@immutable
class HistoryState {
  final List<PollResult> results;
  final bool isLoading;
  final String? errorMessage;

  const HistoryState({
    required this.results,
    this.isLoading = false,
    this.errorMessage,
  });

  const HistoryState.initial()
      : results = const [],
        isLoading = false,
        errorMessage = null;

  const HistoryState.loading()
      : results = const [],
        isLoading = true,
        errorMessage = null;

  const HistoryState.loaded(List<PollResult> results)
      : results = results,
        isLoading = false,
        errorMessage = null;

  const HistoryState.error(String error)
      : results = const [],
        isLoading = false,
        errorMessage = error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryState &&
        other.results == results &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return results.hashCode ^ isLoading.hashCode ^ errorMessage.hashCode;
  }
}