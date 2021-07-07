abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}

class SearchLoadingChangeFavoritesState extends SearchStates {}

class SearchChangeFavoritesState extends SearchStates {}

class SearchSuccessChangeFavoritesState extends SearchStates {}

class SearchErrorChangeFavoritesState extends SearchStates {}

class SearchLoadingGetFavoritesState extends SearchStates {}

class SearchSuccessGetFavoritesState extends SearchStates {}

class SearchErrorGetFavoritesState extends SearchStates {}