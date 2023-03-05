// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/layout/shop_layout.dart';
import 'package:frist_app/modules/register/cubit/cubit.dart';
import 'package:frist_app/modules/register/cubit/states.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSucsessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                NavigateAndFinish(context, ShopLayout());
                ShowToast(
                  message: state.loginModel.message, state: ToastStates.SUCCESS);
              }).catchError((onError) {
                print('Error While Navigating to Home : $onError');
              });
            } else {
              print(state.loginModel.message);
              ShowToast(
                  message: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create an account',
                          style:
                              TextStyle(fontSize: 25, color: Colors.deepPurple),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        defaultformField(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Name Musn't be Empty";
                              }
                            },
                            prefix: Icons.person,
                            lable: 'Name',
                            controller: nameController,
                            type: TextInputType.name),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformField(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Email Musn't be Empty";
                              }
                            },
                            prefix: Icons.email,
                            lable: 'Email',
                            controller: emailController,
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformField(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password Musn't be Empty";
                              }
                            },
                            suffix: cubit.suffixIcon,
                            suffixpressed: () {
                              cubit.ChangeSuffixIcon();
                            },
                            lable: 'Password',
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPassword: cubit.isPass,
                            prefix: Icons.lock),
                        SizedBox(
                          height: 20,
                        ),
                        defaultformField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Phone Musn't be Empty";
                            }
                          },
                          lable: 'Phone',
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        
                        ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) {
                              return defultButton(
                                  raduis: 20,
                                  function: () {
                                    
                                    if (formKey.currentState!.validate()) {
                                      cubit.UserRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text);
                                    }
                                  },
                                  Name: 'Sign Up');
                            },
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
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
