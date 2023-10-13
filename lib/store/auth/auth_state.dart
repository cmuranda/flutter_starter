import '../../auth/auth_model.dart';

class AuthState{
  final AuthUser? user;
  final String? errorMessage;
  final bool isLoading;

  AuthState(
      this.user,
      this.errorMessage,
      this.isLoading
  );

  factory AuthState.initial(){
    return AuthState(null, null, false);
  }

  AuthState copyWith({
    AuthUser? user,
    String? errorMessage,
    bool? isLoading
  }){
    return AuthState(
        user ?? this.user,
        user != null ? null : errorMessage ?? this.errorMessage,
        isLoading ?? this.isLoading
    );
  }

  @override
  int get hashCode => Object.hash(user, errorMessage, isLoading);

  @override
  bool operator == (Object other) {
    return identical(this, other) ||
        (
            other is AuthState &&
                user == other.user &&
                errorMessage == other.errorMessage &&
                isLoading == other.isLoading
        );
  }
}