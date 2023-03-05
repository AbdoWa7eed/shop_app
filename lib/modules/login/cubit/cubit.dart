

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/login_model.dart';
import 'package:frist_app/modules/login/cubit/states.dart';
import 'package:frist_app/shared/network/end_points.dart';
import 'package:frist_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginIntialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  bool isPass = true;
  IconData suffixIcon = Icons.visibility_outlined;
  void ChangeSuffixIcon()
  {
     isPass = !isPass;
    isPass ? suffixIcon = Icons.visibility_outlined : suffixIcon = Icons.visibility_off_outlined;
    emit(ChangeLoginSuffixState());
  }
  void UserLogin(
    {
      required String email,
      required String password,
    }
  )
  {
    emit(ShopLoginLoadingState());
    DioHelper.PostData(url: LOGIN, data: {
        'email' : email ,
        'password' : password,
    }).then((value) 
    {
       loginModel =  ShopLoginModel.fromJson(value.data);
        emit(ShopLoginSucsessState(loginModel: loginModel));
    }).catchError((onError)
    {
        print('Error While Posting : ${onError.toString()}');
        emit(ShopLoginErrorState(onError.toString()));
    });
  }

}