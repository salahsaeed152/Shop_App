import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/shared/cubit/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var globalKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                //save new token in the const variable
                kToken = state.loginModel.data.token;

                navigateAndFinish(context, HomeLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers ',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: nameController,
                          type: TextInputType.text,
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: RegisterCubit.get(context).suffix,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultTextForm(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (globalKey.currentState.validate()) {
                                RegisterCubit.get(context).registerUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                          fallback: (context) => loading(context, 'Signing Up...'),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
