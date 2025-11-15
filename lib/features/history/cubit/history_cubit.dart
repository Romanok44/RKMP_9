import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/service_locator.dart';
import '../../polls/state/history_service.dart';
import '../../polls/models/poll_result.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryService _historyService;

  HistoryCubit() : _historyService = getIt<HistoryService>(), super(const HistoryState.initial()) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    emit(const HistoryState.loading());
    // HistoryService уже загружает данные в конструкторе
    await Future.delayed(const Duration(milliseconds: 100)); // Небольшая задержка для демонстрации
    emit(HistoryState.loaded(_historyService.results));
  }

  Future<void> addResult(PollResult result) async {
    await _historyService.addResult(result);
    emit(HistoryState.loaded(_historyService.results));
  }

  Future<void> clearHistory() async {
    await _historyService.clearHistory();
    emit(HistoryState.loaded(_historyService.results));
  }

  Future<void> updateResult(String id, int rating, String review) async {
    await _historyService.updateResult(id, rating, review);
    emit(HistoryState.loaded(_historyService.results));
  }
}