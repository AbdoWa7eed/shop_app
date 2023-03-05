import 'package:frist_app/models/favorites_model.dart';
import 'package:frist_app/models/login_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}

class ShopChangeFormClickableState extends ShopStates {}

class ShopChangeBNBState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDateState extends ShopStates {
  final String error;
  ShopErrorHomeDateState(this.error);
}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDateState extends ShopStates {
  final String error;
  ShopErrorCategoriesDateState(this.error);
}

class ChangeFavIconState extends ShopStates {}

class ChangeFavSuccessState extends ShopStates {
  final FavModel favModel;
  ChangeFavSuccessState(this.favModel);
}

class ChangeFavErrorState extends ShopStates {
  final String error;
  ChangeFavErrorState(this.error);
}

class ShopLoadingFavDataState extends ShopStates {}

class ShopSuccessFavDataState extends ShopStates {}

class ShopErrorFavDateState extends ShopStates {
  final String error;
  ShopErrorFavDateState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel userModel;
  ShopSuccessUserDataState(this.userModel);
}

class ShopErrorUserDateState extends ShopStates {
  final String error;
  ShopErrorUserDateState(this.error);
}

class ShopLoadingLogOutState extends ShopStates {}

class ShopSuccessLogOutState extends ShopStates {}

class ShopErrorLogOutState extends ShopStates {
  final String error;
  ShopErrorLogOutState(this.error);
}

class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {
  final ShopLoginModel userModel;
  ShopSuccessUpdateState(this.userModel);
}

class ShopErrorUpdateState extends ShopStates {
  final String error;
  ShopErrorUpdateState(this.error);
}

class InternetConnectionErrorState extends ShopStates {
  final String error;
  InternetConnectionErrorState(this.error);
}
