// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/modules/login/login.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {}
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        print(token);
        return ConditionalBuilder(
          condition: cubit.userModel?.data != null,
          builder: (context) {
            nameController.text = cubit.userModel!.data!.name!;
            emailController.text = cubit.userModel!.data!.email!;
            phoneController.text = cubit.userModel!.data!.phone!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        defaultformField(
                            isClickable: cubit.isNameClickable,
                            validate: ((value) {
                              if (value!.isEmpty) {
                                return "Name Musn't be Empty";
                              }
                            }),
                            prefix: Icons.person,
                            lable: 'Name',
                            controller: nameController,
                            type: TextInputType.name),
                        IconButton(
                            onPressed: () {
                              cubit.ChangeFormClickable('name');
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        defaultformField(
                            validate: ((value) {
                              if (value!.isEmpty) {
                                return "Email Musn't be Empty";
                              }
                            }),
                            isClickable: cubit.isEmailClickable,
                            prefix: Icons.email,
                            lable: 'email',
                            controller: emailController,
                            type: TextInputType.emailAddress),
                        IconButton(
                            onPressed: () {
                              emailController.text = emailController.text;
                              cubit.ChangeFormClickable('email');
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        defaultformField(
                            validate: ((value) {
                              if (value!.isEmpty) {
                                return "Phone Musn't be Empty";
                              }
                            }),
                            isClickable: cubit.isPhoneClickable,
                            prefix: Icons.phone,
                            lable: 'email',
                            controller: phoneController,
                            type: TextInputType.phone),
                        IconButton(
                            onPressed: () {
                              cubit.ChangeFormClickable('phone');
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        defultButton(
                            raduis: 50,
                            width: 120,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            Name: 'Update'),
                        Spacer(),
                        defultButton(
                            raduis: 50,
                            width: 120,
                            function: () {
                              CacheHelper.removeData(key: 'token')
                                  .then((value) {
                                if (value) {
                                  cubit.LogOut();
                                  NavigateAndFinish(context, ShopLoginScreen());
                                }
                              }).catchError((onError) {
                                print('Error While removing Token : $onError');
                              });
                            },
                            Name: 'Log Out')
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
