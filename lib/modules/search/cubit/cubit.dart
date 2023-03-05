import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_app/models/search_model.dart';
import 'package:frist_app/modules/search/cubit/states.dart';
import 'package:frist_app/shared/components/constants.dart';
import 'package:frist_app/shared/cubit/cubit.dart';
import 'package:frist_app/shared/network/end_points.dart';
import 'package:frist_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchIntialState());
  Map<int?, bool?> favorite = {};
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void getSearchData(String text, BuildContext context) async{
    await ShopCubit.get(context).getNetworkInfo();
    if (ShopCubit.get(context).isConnected) {
      emit(SearchLoadingState());
      DioHelper.PostData(token: token, url: SEARCH, data: {
        'text': text,
      }).then((value) {
        searchModel = SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
      }).catchError((onError) {
        print('Error While Searching : $onError');
        emit(SearchErrorState(onError.toString()));
      });
    } else {
      SearchErrorState("Please check your internet connection");
    }
  }

  void ChangeFav(context) async{
    await ShopCubit.get(context).getNetworkInfo();
    if (ShopCubit.get(context).isConnected) {
      favorite = ShopCubit.get(context).favorite;
      emit(SearchChangeFavState());
    }
  }
}

