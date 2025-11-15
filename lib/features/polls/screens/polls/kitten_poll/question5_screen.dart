import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/poll_question_screen.dart';
import 'result_screen.dart';
import '../../../cubit/poll_cubit.dart';

class Question5Screen extends StatelessWidget {
  const Question5Screen({super.key});

  void _navigateToNext(BuildContext context, int additionalScore) {
    final pollCubit = context.read<PollCubit>();

    // Сначала добавляем баллы за последний вопрос
    pollCubit.answerQuestion(additionalScore);

    // Затем вычисляем результат и завершаем опрос
    final state = pollCubit.state;
    if (state is PollInProgress) {
      final totalScore = state.currentScore;
      String result;

      if (totalScore <= 0) {
        result = 'СОННЫЙ КОТЕНОК! 🐱‍💤';
      } else if (totalScore <= 4) {
        result = 'КОТЕНОК-НЕВЕДИМКА! 🐱‍👤';
      } else if (totalScore <= 8) {
        result = 'ИГРИВЫЙ И ЛЮБОЗНАТЕЛЬНЫЙ КОТЕНОК! 🐱‍🚀';
      } else {
        result = 'ДОБРЫЙ И СОЦИАЛЬНЫЙ КОТЕНОК! 🥰';
      }

      // Завершаем опрос с результатом
      pollCubit.completePoll(result);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PollQuestionScreen(
      appBarTitle: "Вопрос 5/5",
      question: "Вечер настал. Чем займешься?",
      answers: [
        {
          'text': 'Устройлю игровую сессию (игры, сериалы, хобби).',
          'onPressed': () => _navigateToNext(context, 1),
        },
        {
          'text': 'Позвоню другу, чтобы поболтать и поделиться новостями.',
          'onPressed': () => _navigateToNext(context, 2),
        },
        {
          'text': 'Меня никто не найдет. Я в домике и отдыхаю от всех.',
          'onPressed': () => _navigateToNext(context, -1),
        },
      ],
    );
  }
}