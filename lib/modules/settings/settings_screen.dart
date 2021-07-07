import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_states.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var globalKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        var userModel = shopCubit.userLoginModel;
        if(userModel != null){
          nameController.text = userModel.data.name;
          emailController.text = userModel.data.email;
          phoneController.text = userModel.data.phone;
        }

        return ConditionalBuilder(
          condition: userModel != null,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is ShopLoadingUpdateUserDataState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20.0),
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
                      SizedBox(height: 20.0),
                      defaultTextForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        prefix: Icons.email,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      defaultTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        prefix: Icons.email,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      defaultButton(
                        function: () {
                          if (globalKey.currentState.validate()) {
                            shopCubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      SizedBox(height: 20.0),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => loading(context, 'Loading...'),
        );
      },
    );
  }
}
