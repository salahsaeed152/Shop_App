import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_login_model.dart';
import 'package:shop_app/shared/cubit/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  UserLoginModel loginModel;

  void registerUser({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        path: REGISTER,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value) {
      loginModel = UserLoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString())
      );
    });
  }

 IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

}

