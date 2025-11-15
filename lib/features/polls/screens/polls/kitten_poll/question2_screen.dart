import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/poll_question_screen.dart';
import 'question3_screen.dart';
import '../../../cubit/poll_cubit.dart';

class Question2Screen extends StatelessWidget {
  const Question2Screen({super.key});

  void _navigateToNext(BuildContext context, int additionalScore) {
    context.read<PollCubit>().answerQuestion(additionalScore);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Question3Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PollQuestionScreen(
      appBarTitle: "Вопрос 2/5",
      question: "Что ты хочешь на завтрак?",
      answers: [
        {
          'text': 'Что-нибудь вкусненькое и сладкое, чтобы порадовать себя.',
          'onPressed': () => _navigateToNext(context, 1),
        },
        {
          'text': 'Просто кофе/чай. Главное — функциональность.',
          'onPressed': () => _navigateToNext(context, 0),
        },
        {
          'text': 'Сейчас бы поймать сочную сосиску или кусочек сыра!',
          'onPressed': () => _navigateToNext(context, 2),
        },
      ],
    );
  }
}