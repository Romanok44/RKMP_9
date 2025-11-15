import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/poll_question_screen.dart';
import 'question5_screen.dart';
import '../../../cubit/poll_cubit.dart';

class Question4Screen extends StatelessWidget {
  const Question4Screen({super.key});

  void _navigateToNext(BuildContext context, int additionalScore) {
    context.read<PollCubit>().answerQuestion(additionalScore);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Question5Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PollQuestionScreen(
      appBarTitle: "Вопрос 4/5",
      question: "Кто-то наступил тебе на лапу в транспорте. Твоя реакция?",
      answers: [
        {
          'text': 'Спокойно отойти в сторону. Бывает.',
          'onPressed': () => _navigateToNext(context, 0),
        },
        {
          'text': 'Недовольно фыркнуть и бросить осуждающий взгляд.',
          'onPressed': () => _navigateToNext(context, -1),
        },
        {
          'text': 'Мило улыбнуться и сказать "Ничего страшного!".',
          'onPressed': () => _navigateToNext(context, 2),
        },
      ],
    );
  }
}