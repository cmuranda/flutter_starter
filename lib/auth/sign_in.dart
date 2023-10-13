
import 'package:fin_app/auth/auth_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'auth_form_widgets.dart';

class SignInPage extends StatelessWidget{

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context){
    final formKey = GlobalKey<FormState>();
    final emailFieldController = TextEditingController();
    final passwordFieldController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Sign In")
      ),
      body: Center(
        child: StoreConnector<ApplicationState, VoidCallback>(
          converter: (store){
            var usernamePassword = SignInModel(
                emailFieldController.text.trim(),
                passwordFieldController.text.trim()
            );
            return () => store.dispatch(SignInAction(usernamePassword));
          },
          builder: (context, callback) {
            return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailField(emailFieldController),
                PasswordField(passwordFieldController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180,50),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey
                      ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signing In')),
                        );
                        callback();
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          );
        })
      ),
    );
  }
}

