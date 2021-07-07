import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeMode({bool mode}) {
    if(mode != null){
       isDark = mode;
      emit(AppChangeModeState());
    }else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) => {
        emit(AppChangeModeState())
      });
    }
  }

}
