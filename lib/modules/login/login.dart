

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_import, implementation_imports, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/layout/shop_layout.dart';
import 'package:frist_app/modules/login/cubit/cubit.dart';
import 'package:frist_app/modules/login/cubit/states.dart';
import 'package:frist_app/modules/register/register.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(builder: (context, state) {
        var cubit = ShopLoginCubit.get(context);
          return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text('Hello' ,
                    style: TextStyle(fontSize: 70 , color: Colors.deepPurple) ,
                    ) ,
                    Text('Sign in to your Account' ,
                    style: TextStyle(fontSize: 20) ,
                    ) ,           SizedBox(height: 40,),
                    defaultformField(
                      validate: (value) {
                        if(value!.isEmpty)
                          {
                              return "Email Musn't be Empty";
                          } 
                      },
                      prefix: Icons.email,
                      lable: 'Email', controller: emailController, type: TextInputType.emailAddress),SizedBox(height: 20,),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       defaultformField(
                        validate: ((value) {
                          if(value!.isEmpty)
                          {
                              return "Password Musn't be Empty";
                          } 
                          else if(value.length < 5)
                            {
                              return "Password too short";
                            }
                        }),
                      suffix: cubit.suffixIcon,
                      onSubmit: (vlaue)
                      {
                        if(formKey.currentState!.validate())
                      {
                        cubit.UserLogin(email: emailController.text, password: passwordController.text);
                      }
                      },
                      suffixpressed: () {
                         cubit.ChangeSuffixIcon();
                       },
                      lable: 'Password', controller: passwordController, type: TextInputType.visiblePassword
                    ,isPassword: cubit.isPass , 
                    prefix: Icons.lock),
                    TextButton(onPressed: ()
                        {
                            
                        }, 
                        child: Text('Forgot your password ?' , style: TextStyle(color: Colors.grey)),),
                    ],
                   ),
                    SizedBox(height: 25
                    ,),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => defultButton(
                        raduis: 20,
                        function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          cubit.UserLogin(email: emailController.text, password: passwordController.text);
                        }
                      }, Name:'Login' ),
                      fallback: (context) => CircularProgressIndicator(),
                    )  ,
                    SizedBox( 
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Do have an Account?'),
                        TextButton(onPressed: ()
                        {
                            NavigateTo(context, RegisterScreen());
                        }, child: Text('Register Now',),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      }, listener: (context, state) {
        if(state is ShopLoginSucsessState)
        {
          if(state.loginModel.status)
          {
            print(state.loginModel.message);
            print(state.loginModel.data?.token);
            CacheHelper.saveData(key: 'token' , value: state.loginModel.data?.token ).then((value)
            {
            token = state.loginModel.data!.token!;
             NavigateAndFinish(context, ShopLayout());
            }).catchError((onError)
            {
              print('Error While Navigating to Home : $onError');
            });
          }
          else 
          {
            print(state.loginModel.message);
            ShowToast(message: state.loginModel.message , state: ToastStates.ERROR);
          }
        }
      },),
    );
  }
}