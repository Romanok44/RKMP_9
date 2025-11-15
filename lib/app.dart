import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/polls/screens/start_screen.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/polls/cubit/poll_cubit.dart';
import 'features/history/cubit/history_cubit.dart';
import 'shared/app_theme.dart';
import 'shared/app_state.dart';

class PollApp extends StatefulWidget {
  const PollApp({super.key});

  @override
  State<PollApp> createState() => _PollAppState();
}

class _PollAppState extends State<PollApp> {
  int _completedPollsCount = 0;
  ThemeData _themeData = AppTheme.themeData;

  void _incrementCompletedPollsCount() {
    setState(() {
      _completedPollsCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      completedPollsCount: _completedPollsCount,
      themeData: _themeData,
      incrementCompletedPollsCount: _incrementCompletedPollsCount,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => PollCubit()),
          BlocProvider(create: (context) => HistoryCubit()),
        ],
        child: MaterialApp(
          title: 'Poll Tracker',
          theme: _themeData,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return state.isAuthenticated ? const StartScreen() : LoginScreen();
            },
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}