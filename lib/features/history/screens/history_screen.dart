import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../polls/widgets/category_section.dart';
import '../../polls/widgets/confirmation_dialog.dart';
import '../widgets/empty_history_state.dart';
import '../cubit/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Map<String, List<dynamic>> _groupPollsByCategory(List<dynamic> polls) {
    final grouped = <String, List<dynamic>>{};
    for (final poll in polls) {
      final category = poll.category;
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(poll);
    }
    return grouped;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: 'Очистить историю',
        content: 'Вы уверены, что хотите удалить все результаты?',
        onConfirm: () => context.read<HistoryCubit>().clearHistory(),
      ),
    );
  }

  void _showResultDialog(BuildContext context, dynamic poll) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(poll.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Категория: ${poll.category}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Дата: ${_formatDate(poll.date)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Результат:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              poll.result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            if (poll.rating > 0) ...[
              const SizedBox(height: 16),
              const Text(
                'Оценка:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < poll.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
            ],

            if (poll.review.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Ваш отзыв:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                poll.review,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('История опросов'),
            backgroundColor: Colors.blue[700],
            actions: [
              if (state.results.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showClearConfirmationDialog(context),
                  tooltip: 'Очистить историю',
                ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HistoryState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.results.isEmpty) {
      return const EmptyHistoryState();
    }

    final groupedPolls = _groupPollsByCategory(state.results);

    return ListView(
      children: groupedPolls.entries.map((entry) {
        return CategorySection(
          category: entry.key,
          polls: entry.value,
          onPollTap: (poll) => _showResultDialog(context, poll),
        );
      }).toList(),
    );
  }
}