import 'package:fin_app/store/auth/auth_action.dart';
import '../store/application_state.dart';
import 'package:redux/redux.dart';

class AuthViewModel{
  final Store<ApplicationState> _store;
  final bool isLoading;
  final String? errorMessage;


  AuthViewModel(
      this._store,
      this.isLoading,
      this.errorMessage
      );

  static AuthViewModel converter(
      Store<ApplicationState> store
      ){
    return AuthViewModel(
        store,
        store.state.authState.isLoading,
        store.state.authState.errorMessage
    );
  }

  void signUpUser(signUpParameters){
    _store.dispatch(AuthLoadingAction());
    _store.dispatch(SignUpAction(signUpParameters));
  }

  void signInUser(usernamePassword) => _store.dispatch(SignInAction(usernamePassword));
}