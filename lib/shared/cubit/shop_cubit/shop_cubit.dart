import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/user_login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeNavBottomState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token: kToken,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel.data.products.length);

      //to get favorite products
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      path: GET_CATEGORIES,
    ).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    //to toggle the favorite button
    //status of product = !status of product
    favorites[productId] = !favorites[productId];
    emit(ShopLoadingChangeFavoritesState());

    DioHelper.postData(
      path: FAVORITES,
      data: {
        'product_id' : productId
      },
      token: kToken,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print("ay klaaam");
      print(value.data);
      print('token: $kToken');

      if(!changeFavoritesModel.status){
        favorites[productId] = !favorites[productId];
      }else{
        getFavoritesData();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){

      favorites[productId] = !favorites[productId];

      print(error.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavoritesData() {

    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      path: FAVORITES,
      token: kToken,
    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  UserLoginModel userLoginModel;

  void getUserData() {

    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      path: PROFILE,
      token: kToken,
    ).then((value) {

      userLoginModel = UserLoginModel.fromJson(value.data);

      print(userLoginModel.data.name);

      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  @required String name,
  @required String email,
  @required String phone,
}) {

    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      token: kToken,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value) {

      userLoginModel = UserLoginModel.fromJson(value.data);

      print(userLoginModel.data.name);

      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }

}
