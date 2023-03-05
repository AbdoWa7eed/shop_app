// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/categories_model.dart';
import 'package:frist_app/models/fav_data_model.dart';
import 'package:frist_app/models/favorites_model.dart';
import 'package:frist_app/models/home_model.dart';
import 'package:frist_app/models/login_model.dart';
import 'package:frist_app/modules/categories/categories_screen.dart';
import 'package:frist_app/modules/favorites/favorites_screen.dart';
import 'package:frist_app/modules/products/product_screen.dart';
import 'package:frist_app/modules/settings/settings_screen.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/cubit/states.dart';
import 'package:frist_app/shared/network/end_points.dart';
import 'package:frist_app/shared/network/remote/dio_helper.dart';
import 'package:frist_app/shared/network/remote/network_info.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? CategoryModel;
  FavModel? favModel;
  Map<int?, bool?> favorite = {};
  bool isNameClickable = false;
  bool isEmailClickable = false;
  bool isPhoneClickable = false;
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  bool isConnected = false;

  Future<void> getNetworkInfo() async {
    isConnected = await NetworkInfo().isConnected;
  }

  getInitialData() async {
    await getNetworkInfo();
    if (isConnected) {
      GetHomeDate();
      GetCategoriesData();
      GetFavData();
      GetUserData();
    }
  }

  void ChangeFormClickable(String key) {
    if (key == 'email')
      isEmailClickable = !isEmailClickable;
    else if (key == 'name')
      isNameClickable = !isNameClickable;
    else
      isPhoneClickable = !isPhoneClickable;
    emit(ShopChangeFormClickableState());
  }

  void ChangeBNB(int index) async {
    await getNetworkInfo();
    currentIndex = index;
    emit(ShopChangeBNBState());
  }

  void ChangeFavorites(int id) async {
    await getNetworkInfo();
    if (isConnected) {
      favorite[id] = !favorite[id]!;
      emit(ChangeFavIconState());
      DioHelper.PostData(url: FAVORITES, token: token, data: {
        'product_id': id,
      }).then((value) {
        favModel = FavModel.fromJson(value.data);
        if (!favModel!.status) {
          favorite[id] = !favorite[id]!;
        } else
          GetFavData();
        emit(ChangeFavSuccessState(favModel!));
      }).catchError((onError) {
        favorite[id] = !favorite[id]!;
        print('Error While Changing Favorites : $onError');
        emit(ChangeFavErrorState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }

  void GetHomeDate() async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingHomeDataState());
      DioHelper.getData(url: HOME, token: token).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel?.data?.products.forEach(((element) {
          favorite.addAll({element.id: element.in_favorites});
        }));
        emit(ShopSuccessHomeDataState());
      }).catchError((onError) {
        print('Error While getting HomeData : $onError');
        emit(InternetConnectionErrorState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }

  void GetCategoriesData() async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingCategoriesDataState());
      DioHelper.getData(url: GET_CATEGORIES).then((value) {
        CategoryModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesDataState());
      }).catchError((onError) {
        print('Error While getting CategoriesData : $onError');
        emit(ShopErrorCategoriesDateState(onError));
      });
    } else {
      emit(
          ShopErrorCategoriesDateState("Please check you internet connection"));
    }
  }

  FavoritesModel? favoritesModel;
  void GetFavData() async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingFavDataState());
      DioHelper.getData(
        url: FAVORITES,
        token: token,
      ).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(ShopSuccessFavDataState());
      }).catchError((onError) {
        print('Error While getting FavData : $onError');
        emit(ShopErrorFavDateState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }

  ShopLoginModel? userModel;
  void GetUserData() async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingUserDataState());
      DioHelper.getData(
        url: PROFILE,
        token: token,
      ).then((value) {
        userModel = ShopLoginModel.fromJson(value.data);
        printFullText(userModel!.data!.name!);
        emit(ShopSuccessUserDataState(userModel!));
      }).catchError((onError) {
        print('Error While getting UserData : $onError');
        emit(ShopErrorUserDateState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }

  void LogOut() async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingLogOutState());
      DioHelper.PostData(url: LOGOUT, data: {
        'fcm_token': 'SomeFcmToken',
      }).then((value) {
        currentIndex = 0;
        print('Logged Out');
        emit(ShopSuccessLogOutState());
      }).catchError((onError) {
        print('Error While Logging out : $onError');
        emit(ShopErrorLogOutState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    await getNetworkInfo();
    if (isConnected) {
      emit(ShopLoadingUpdateState());
      DioHelper.updateData(
        url: UPDATE_PRO,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
        token: token,
      ).then((value) {
        userModel = ShopLoginModel.fromJson(value.data);
        printFullText(userModel!.data!.name!);
        emit(ShopSuccessUpdateState(userModel!));
      }).catchError((onError) {
        print('Error While getting UserData : $onError');
        emit(ShopErrorUpdateState(onError.toString()));
      });
    } else {
      emit(
          InternetConnectionErrorState("Please check you internet connection"));
    }
  }
}
