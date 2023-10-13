
import 'package:fin_app/auth/auth_model.dart';
import 'package:fin_app/auth/auth_view_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'auth_form_widgets.dart';

class SignUpPage extends StatelessWidget{

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context){
    final formKey = GlobalKey<FormState>();
    final emailFieldController = TextEditingController();
    final passwordFieldController = TextEditingController();
    final firstNameFieldController = TextEditingController();
    final lastNameFieldController = TextEditingController();
    final idFieldController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: const LinearProgressIndicator(
            minHeight: 10,
            semanticsLabel: "Login Information",
            value: .34,
          )

      ),

      body: StoreConnector<ApplicationState, AuthViewModel>(
          converter: (store) => AuthViewModel.converter(store),
          builder: (context, viewModel) => viewModel.isLoading?
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
          : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                  key: formKey,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GenericTextField(
                            hintString: 'First Name',
                            textFieldController: firstNameFieldController
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GenericTextField(
                            hintString: 'Last Name',
                            textFieldController: lastNameFieldController
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GenericTextField(
                            hintString: 'ID Number',
                            textFieldController: idFieldController,
                            isNumeric: true
                        ),
                      ),
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
                              FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signing Up')),
                              );
                              var signUpParameters = SignUpModel(
                                  firstNameFieldController.text.trim(),
                                  lastNameFieldController.text.trim(),
                                  idFieldController.text.trim(),
                                  emailFieldController.text.trim(),
                                  passwordFieldController.text.trim()
                              );
                              viewModel.signUpUser(signUpParameters);
                            }
                          },
                          child: const Text(
                              'Sign Up',
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) ,
                )
              ),
          ),
        ),
    );
  }
}

