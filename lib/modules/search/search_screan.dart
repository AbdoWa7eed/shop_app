// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/search_model.dart';
import 'package:frist_app/modules/search/cubit/cubit.dart';
import 'package:frist_app/modules/search/cubit/states.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is SearchErrorState) {
            ShowToast(message: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultformField(
                        lable: 'Search',
                        prefix: Icons.search,
                        controller: textController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) return "Search musn't be Empty";
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).GetFavData();
                            cubit.ChangeFav(context);
                            cubit.getSearchData(value, context);
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      condition: state is SearchSuccessState ||
                          state is SearchChangeFavState,
                      builder: (context) {
                        return Expanded(
                          child: cubit.searchModel!.data!.data.isEmpty
                              ? Center(
                                  child: Text('No Searched Items',
                                      style: TextStyle(
                                        fontSize: 25,
                                      )))
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return buildFavItem(
                                        cubit.searchModel!.data!.data[index],
                                        cubit,
                                        context);
                                  },
                                  separatorBuilder: (context, index) =>
                                      MyDivider(),
                                  itemCount:
                                      cubit.searchModel!.data!.data.length),
                        );
                      },
                      fallback: (context) => Expanded(
                          child: Center(
                              child: state is SearchLoadingState
                                  ? CircularProgressIndicator()
                                  : Text('No Searched Items',
                                      style: TextStyle(
                                        fontSize: 25,
                                      )))),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFavItem(SearchedModel model, SearchCubit cubit, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    height: 120,
                    image: NetworkImage('${model.image}'),
                    width: 120,
                    errorBuilder: (context, error, stackTrace) {
                      return Image(
                          image: AssetImage('assets/images/error.png'));
                    }),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.price}\$',
                        style:
                            TextStyle(fontSize: 14, color: Colors.deepPurple),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Spacer(),
                      IconButton(
                        iconSize: 18,
                        onPressed: () {
                          ShopCubit.get(context).ChangeFavorites(model.id!);
                          cubit.ChangeFav(context);
                          print("My Map : ${cubit.favorite}");
                        },
                        icon: Icon(cubit.favorite[model.id]!
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color:
                            cubit.favorite[model.id]! ? Colors.red[900] : null,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
