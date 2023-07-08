abstract class BaseState {
  BaseState();
}

class InitialState<T> extends BaseState {
  InitialState({this.data});
  final T? data;
}

class LoadingState<T> extends BaseState {
  LoadingState({this.data});

  final T? data;
}

class SuccessState<T> extends BaseState {
  SuccessState({this.data});

  final T? data;
}

class ErrorState<T> extends BaseState {
  ErrorState({this.data});

  final T? data;
}
