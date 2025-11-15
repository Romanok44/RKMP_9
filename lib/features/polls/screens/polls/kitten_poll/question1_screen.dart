import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/poll_question_screen.dart';
import 'question2_screen.dart';
import '../../../cubit/poll_cubit.dart';

class Question1Screen extends StatelessWidget {
  const Question1Screen({super.key});

  void _navigateToNext(BuildContext context, int score) {
    // Обновляем состояние в Cubit
    context.read<PollCubit>().answerQuestion(score);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Question2Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PollQuestionScreen(
      appBarTitle: "Вопрос 1/5",
      question: "Твой будильник прозвенел. Первая мысль?",
      answers: [
        {
          'text': '"Уже?! Еще пять минуточек..."',
          'onPressed': () => _navigateToNext(context, -1),
        },
        {
          'text': '"Время начинать день! Столько всего интересного!"',
          'onPressed': () => _navigateToNext(context, 2),
        },
        {
          'text': '"Мой день начнется тогда, когда я сам этого захочу."',
          'onPressed': () => _navigateToNext(context, 0),
        },
      ],
    );
  }
}