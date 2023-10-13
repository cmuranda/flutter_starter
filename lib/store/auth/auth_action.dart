
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:fin_app/auth/auth_model.dart';
import 'package:image_picker/image_picker.dart';




abstract class AuthAction{}

class SignInAction extends AuthAction{
  final SignInModel usernamePassword;

  SignInAction(this.usernamePassword);

  @override
  String toString() => "$SignInAction";
}

class AuthSuccessAction extends AuthAction{
  final AuthUser user;

  AuthSuccessAction(this.user);

  @override
  String toString() => "$AuthSuccessAction";
}

class SignUpAction extends AuthAction{
  final SignUpModel signUpParameters;

  SignUpAction(this.signUpParameters);

  @override
  String toString() => "$SignUpAction";
}

class AuthFailedAction extends AuthAction{
  final String message;

  AuthFailedAction(this.message);

  @override
  String toString() => "$AuthFailedAction";
}

class AuthLoadingAction extends AuthAction{

  AuthLoadingAction();

  @override
  String toString() => "$AuthLoadingAction";
}

class AuthUploadingKYCImageAction extends AuthAction{

  AuthUploadingKYCImageAction(XFile file);

  @override
  String toString() => "$AuthUploadingKYCImageAction";
}

class AuthUploadingKYCDocumentAction extends AuthAction{
  AuthUploadingKYCDocumentAction(PlatformFile file);

  @override
  String toString() => "$AuthUploadingKYCDocumentAction";
}
