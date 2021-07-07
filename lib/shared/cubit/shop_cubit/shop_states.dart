import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeNavBottomState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopLoadingCategoriesState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopLoadingChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{}

class ShopErrorUpdateUserDataState extends ShopStates{}