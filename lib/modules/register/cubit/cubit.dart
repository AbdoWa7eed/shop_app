

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/login_model.dart';
import 'package:frist_app/modules/register/cubit/states.dart';
import 'package:frist_app/shared/network/end_points.dart';
import 'package:frist_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterIntialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  bool isPass = true;
  IconData suffixIcon = Icons.visibility_outlined;
  void ChangeSuffixIcon()
  {
     isPass = !isPass;
    isPass ? suffixIcon = Icons.visibility_outlined : suffixIcon = Icons.visibility_off_outlined;
    emit(ChangeRegisterSuffixState());
  }
  void UserRegister(
    {
      required String email,
      required String password,
      required String name,
      required String phone,
    }
  )
  {
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(url: REGISTER, data: {
        'name' : name,
        'phone' : phone,
        'email' : email ,
        'password' : password,

    }).then((value) 
    {
       loginModel =  ShopLoginModel.fromJson(value.data);
        emit(ShopRegisterSucsessState(loginModel: loginModel));
    }).catchError((onError)
    {
        print('Error While Posting : ${onError.toString()}');
        emit(ShopRegisterErrorState(onError.toString()));
    });
  }

}