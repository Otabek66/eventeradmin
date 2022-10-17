abstract class HomeState{
  HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial();
}

class HomeSplash extends HomeState {
  HomeSplash();
}
class HomeLoading extends HomeState{
  HomeLoading();
}
class HomeComplate extends HomeState{
  List info;
  HomeComplate({required this.info});
}
class HomeRefresh extends HomeState{
  HomeRefresh();
}
class HomeError extends HomeState{
  String msg;
  HomeError({required this.msg});
}

