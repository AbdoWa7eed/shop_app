


import 'package:frist_app/models/login_model.dart';

abstract class ShopRegisterStates{}

class ChangeRegisterSuffixState extends ShopRegisterStates{}
class ShopRegisterIntialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSucsessState extends ShopRegisterStates
{
    late ShopLoginModel loginModel;
    ShopRegisterSucsessState({required this.loginModel});
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}

