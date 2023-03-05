


import 'package:frist_app/models/login_model.dart';

abstract class ShopLoginStates{}

class ChangeLoginSuffixState extends ShopLoginStates{}
class ShopLoginIntialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSucsessState extends ShopLoginStates
{
    late ShopLoginModel loginModel;
    ShopLoginSucsessState({required this.loginModel});
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

