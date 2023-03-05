// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/categories_model.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.CategoryModel != null,
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildCatItem(cubit.CategoryModel!.data!.data[index]);
                  },
                  separatorBuilder: (context, index) => MyDivider(),
                  itemCount: cubit.CategoryModel!.data!.data.length);
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
              fit: BoxFit.cover,
              height: 80,
              width: 80,
              image: NetworkImage('${model.image}'),
              errorBuilder: (context, error, stackTrace) {
                return Image(image: AssetImage('assets/images/error.png'));
              }),
          SizedBox(
            width: 20,
          ),
          Text(
            '${model.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

}
