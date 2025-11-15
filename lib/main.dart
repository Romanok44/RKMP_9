import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'shared/service_locator.dart';
import 'shared/counter_observer.dart';

void main() {
  setupServiceLocator();
  Bloc.observer = const CounterObserver();
  runApp(const PollApp());
}