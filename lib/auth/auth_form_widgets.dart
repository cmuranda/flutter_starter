import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailFieldController;

  const EmailField(
    this.emailFieldController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailFieldController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
        hintText: 'Enter your email',
      ),
      keyboardType: TextInputType.emailAddress,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!EmailValidator.validate(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }
}

class GenericTextField extends StatelessWidget {
  final String hintString;
  final TextEditingController textFieldController;
  final bool isNumeric;

  const GenericTextField(
      {super.key,
      required this.hintString,
      required this.textFieldController,
      this.isNumeric = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      keyboardType: isNumeric? TextInputType.number : TextInputType.text,
      inputFormatters: isNumeric?[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]:[],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintString,
      ),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintString';
        }
        return null;
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordFieldController;

  const PasswordField(
    this.passwordFieldController, {
    super.key,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordFieldController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
