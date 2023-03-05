
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:frist_app/modules/login/login.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/network/local/chache_helper.dart';


void SignOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
        {
          if(value)
           NavigateAndFinish(context, ShopLoginScreen());
        }).catchError((onError)
        {
          print('Error while Signing out : $onError');
        });
}

void printFullText(String txt)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(txt).forEach((element) {
    print(element.group(0));
  }) ;
}

String token = '';