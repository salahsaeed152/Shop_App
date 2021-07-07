import 'package:shop_app/models/user_login_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final UserLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates{}

