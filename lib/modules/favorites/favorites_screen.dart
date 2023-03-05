// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/fav_data_model.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.favoritesModel != null,
            builder: (context) {
              return ConditionalBuilder(
                condition: cubit.favoritesModel!.data!.data!.isNotEmpty,
                fallback: (context) => Center(
                    child: Text('No Favorites Items',
                        style: TextStyle(
                          fontSize: 25,
                        ))),
                builder: (context) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return buildFavItem(
                            cubit.favoritesModel!.data!.data![index], cubit);
                      },
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: cubit.favoritesModel!.data!.data!.length);
                },
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(FavData model, ShopCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    height: 120,
                    image: NetworkImage('${model.product!.image}'),
                    width: 120,
                    errorBuilder: (context, error, stackTrace) {
                      return Image(
                          image: AssetImage('assets/images/error.png'));
                    }),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red[900],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('OFFER',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    '${model.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.product!.price}\$',
                        style:
                            TextStyle(fontSize: 14, color: Colors.deepPurple),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice}\$',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        iconSize: 18,
                        onPressed: () {
                          cubit.ChangeFavorites(model.product!.id!);
                          //  print('${cubit.favorite[model.id]}');
                          //  model.in_favorites = true;
                        },
                        icon: Icon(cubit.favorite[model.product!.id]!
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: cubit.favorite[model.product!.id]!
                            ? Colors.red[900]
                            : null,
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
