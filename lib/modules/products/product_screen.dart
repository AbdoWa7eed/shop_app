// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/categories_model.dart';
import 'package:frist_app/models/home_model.dart';
import 'package:frist_app/shared/components/components.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ChangeFavSuccessState) {
          if (!state.favModel.status) {
            ShowToast(
                message: state.favModel.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.CategoryModel != null,
          builder: (context) {
            return productsBuilder(
                cubit.homeModel!, cubit.CategoryModel!, cubit);
          },
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel model, CategoriesModel categoriesModel, ShopCubit cubit) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: ImagesList(model),
              options: CarouselOptions(
                  height: 200.0,
                  reverse: false,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          CategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data!.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.66,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      BuildGridProduct(model.data!.products[index], cubit)),
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryItem(DataModel model) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            fit: BoxFit.cover,
            image: NetworkImage('${model.image}'),
            errorBuilder: (context, error, stackTrace) {
              return Image(image: AssetImage('assets/images/error.png'));
            },
          ),
          Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  Widget BuildGridProduct(ProductModel model, ShopCubit cubit) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                height: 200,
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image(image: AssetImage('assets/images/error.png'));
                },
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.price.round()} \$',
                      style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_Price.round()} \$',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      iconSize: 18,
                      onPressed: () {
                        cubit.ChangeFavorites(model.id!);
                        model.in_favorites = cubit.favorite[model.id];
                        print('${cubit.favorite[model.id]}');
                        //  model.in_favorites = true;
                      },
                      icon: Icon(cubit.favorite[model.id]!
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: cubit.favorite[model.id]! ? Colors.red[900] : null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Image> ImagesList(HomeModel model) {
    List<Image> images = [];
    model.data?.banners.forEach((element) {
      images.add(
        Image(
          image: NetworkImage('${element.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image(image: AssetImage('assets/images/error.png'));
          },
        ),
      );
    });
    return images;
  }
}
