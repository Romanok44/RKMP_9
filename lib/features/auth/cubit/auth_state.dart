part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isAuthenticated;
  final String? username;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.isAuthenticated,
    this.username,
    this.errorMessage,
    this.isLoading = false,
  });

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        username = null,
        errorMessage = null,
        isLoading = false;

  const AuthState.authenticated(String username)
      : isAuthenticated = true,
        username = username,
        errorMessage = null,
        isLoading = false;

  const AuthState.error(String error)
      : isAuthenticated = false,
        username = null,
        errorMessage = error,
        isLoading = false;

  const AuthState.loading()
      : isAuthenticated = false,
        username = null,
        errorMessage = null,
        isLoading = true;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.username == username &&
        other.errorMessage == errorMessage &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^
    username.hashCode ^
    errorMessage.hashCode ^
    isLoading.hashCode;
  }
}