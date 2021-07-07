import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/search_cubit/search_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      path: SEARCH,
      token: kToken,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      print(searchModel.data.data.length);

      //to get favorite products
      searchModel.data.data.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  Map<int, bool> favorites = {};

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId, String text) {
    //to toggle the favorite button
    //status of product = !status of product
    favorites[productId] = !favorites[productId];
    emit(SearchLoadingChangeFavoritesState());

    DioHelper.postData(
      path: FAVORITES,
      data: {
        'product_id' : productId
      },
      token: kToken,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print("change search");

      if(!changeFavoritesModel.status){
        favorites[productId] = !favorites[productId];
      }else{
        search(text);
      }

      emit(SearchSuccessChangeFavoritesState());
    }).catchError((error){

      favorites[productId] = !favorites[productId];

      print(error.toString());
      emit(SearchErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavoritesData() {

    emit(SearchLoadingGetFavoritesState());
    DioHelper.getData(
      path: FAVORITES,
      token: kToken,
    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(favorites.length.toString());

      emit(SearchSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorGetFavoritesState());
    });
  }

}