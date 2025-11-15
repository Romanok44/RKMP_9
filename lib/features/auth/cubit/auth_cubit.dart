import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.unauthenticated());

  void login(String username, String password) {
    // Простая имитация аутентификации
    if (username.isNotEmpty && password.isNotEmpty) {
      emit(AuthState.authenticated(username));
    } else {
      emit(const AuthState.error('Введите логин и пароль'));
    }
  }

  void logout() {
    emit(const AuthState.unauthenticated());
  }

  void clearError() {
    if (state.errorMessage != null) {
      emit(const AuthState.unauthenticated());
    }
  }
}