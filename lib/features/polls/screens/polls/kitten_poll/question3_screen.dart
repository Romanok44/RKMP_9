import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/poll_question_screen.dart';
import 'question4_screen.dart';
import '../../../cubit/poll_cubit.dart';

class Question3Screen extends StatelessWidget {
  const Question3Screen({super.key});

  void _navigateToNext(BuildContext context, int additionalScore) {
    context.read<PollCubit>().answerQuestion(additionalScore);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Question4Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PollQuestionScreen(
      appBarTitle: "Вопрос 3/5",
      question: "Как пройдет твой день?",
      answers: [
        {
          'text': 'Планово и продуктивно. Я составлю список дел и последую ему.',
          'onPressed': () => _navigateToNext(context, 1),
        },
        {
          'text': 'Я буду исследовать что-то новое и следовать за своим любопытством.',
          'onPressed': () => _navigateToNext(context, 2),
        },
        {
          'text': 'Где мое самое уютное местечко? Идеальный день для отдыха.',
          'onPressed': () => _navigateToNext(context, -1),
        },
      ],
    );
  }
}