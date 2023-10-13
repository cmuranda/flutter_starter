import 'package:fin_app/api/api.dart';
import 'package:fin_app/auth/auth_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:redux/redux.dart';

class AuthMiddleware implements MiddlewareClass<ApplicationState>{
  final Api api;

  AuthMiddleware(this.api);

  @override
  call(Store<ApplicationState> store,
      dynamic action,
      NextDispatcher next
      ) async {
    next(action);

    if (action is SignInAction){
      try{
        final signInResult = await api.signInUser(action.usernamePassword);
        String jwtToken = signInResult.loginAccessKey;
        String userName = action.usernamePassword.username;
        final customer = await api.getUserByEmail(userName, jwtToken);
        var user = AuthUser.fromCustomerJwt(
            customer,
            signInResult.loginAccessKey
        );
        store.dispatch(AuthSuccessAction(user));
        store.dispatch(NavigateToAction.replace("/products-home"));
      } on ApiException catch (e){
        store.dispatch(AuthFailedAction(e.message));
      }
    }

    else if (action is SignUpAction){
      try{
        final customer = await api.signUpUser(action.signUpParameters);
        final signInResult = await api.signInUser(action.signUpParameters);
        var user = AuthUser.fromCustomerJwt(
            customer,
            signInResult.loginAccessKey
        );
        store.dispatch(AuthSuccessAction(user));
        store.dispatch(NavigateToAction.push("/products-home"));
      } on ApiException catch (e){
        store.dispatch(AuthFailedAction(e.message));
      }
    }
  }
}

void checkUserLoggedIn(Store<ApplicationState> store){
  String? jwtToken = store.state.authState.user?.jwtToken;
  if(jwtToken == null){
    displayToastMessage("Login first to continue");
    store.dispatch(
        NavigateToAction(
            "/sign-in",
            arguments: {
              "message": "Login first to continue",
              "redirect": "/cart"
            }
        )
    );
    return;
  }
  if (JwtDecoder.isExpired(jwtToken)){
    displayToastMessage("Session expired please login again.");
    store.dispatch(
        NavigateToAction(
            "/sign-in",
            arguments: {
              "message": "Session expired please login again.",
              "redirect": "/cart"
            }
        )
    );
    return;
  }
}

displayToastMessage(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}