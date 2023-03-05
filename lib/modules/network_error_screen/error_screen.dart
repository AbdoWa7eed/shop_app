import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';

class ErrorScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Please check your internet connection"),
                  const SizedBox(
                    height: 40,
                  ),
                  defultButton(function: () {
                   if(cubit.homeModel == null){
                    cubit.getInitialData();
                   }else{
                    cubit.ChangeBNB(cubit.currentIndex);
                   }
                  }, Name: "Reload"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
