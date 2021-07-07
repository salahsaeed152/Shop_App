import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_login_model.dart';
import 'package:shop_app/shared/cubit/login_cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserLoginModel loginModel;

  void loginUser({
  @required String email,
  @required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        path: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
    ).then((value) {
      loginModel = UserLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString())
      );
    });
  }

 IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    print('show');
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

}

