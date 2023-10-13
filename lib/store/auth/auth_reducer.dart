import 'package:fin_app/store/auth/auth_action.dart';
import 'package:fin_app/store/auth/auth_state.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, SignInAction>(onSignIn),
  TypedReducer<AuthState, AuthLoadingAction>(onLoading),
  TypedReducer<AuthState, AuthSuccessAction>(onAuthSuccess),
  TypedReducer<AuthState, AuthFailedAction>(onAuthFailure)
]);

AuthState onLoading(
    AuthState state,
    action
    ){
  return state.copyWith(isLoading: true);
}

AuthState onSignIn(
  AuthState state,
  action
){
  return state.copyWith(isLoading: true);
}

AuthState onAuthSuccess(
AuthState state,
action
){
  return state.copyWith(isLoading: false, user: action.user);
}

AuthState onAuthFailure(
    AuthState state,
    action
    ){
  return state.copyWith(
      isLoading: false,
      errorMessage: action.message
  );
}


