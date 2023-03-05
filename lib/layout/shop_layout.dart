// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/modules/network_error_screen/error_screen.dart';
import 'package:frist_app/modules/search/search_screan.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is InternetConnectionErrorState){
          ShowToast(message: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  NavigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.ChangeBNB(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.items),
          body: cubit.isConnected
              ? cubit.screens[cubit.currentIndex]
              : ErrorScreen(),
        );
      },
    );
  }
}
