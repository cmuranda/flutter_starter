
import 'package:fin_app/auth/auth_model.dart';
import 'package:fin_app/auth/auth_view_model.dart';
import 'package:fin_app/auth/sign_up.dart';
import 'package:fin_app/store/application_state.dart';
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
        child: StoreConnector<ApplicationState, AuthViewModel>(
          converter: (store) => AuthViewModel.converter(store),
          builder: (context, viewModel) {
            return viewModel.isLoading?
                const CircularProgressIndicator(
                  color: Colors.orange,
                )
              : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EmailField(emailFieldController),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: PasswordField(passwordFieldController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200,50),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange
                      ),
                      onPressed: () {
                        var usernamePassword = SignInModel(
                            emailFieldController.text.trim(),
                            passwordFieldController.text.trim()
                        );
                        if (formKey.currentState!.validate()) {
                          viewModel.signInUser(usernamePassword);
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage())
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
          ),
            );
        })
      ),
    );
  }
}

