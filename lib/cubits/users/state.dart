part of 'cubit.dart';

@immutable
class UsersState extends Equatable {
  final List<UserData>? data;
  final String? message;

  const UsersState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

@immutable
class UsersDefault extends UsersState {}

@immutable
class UsersFetchLoading extends UsersState {
  const UsersFetchLoading() : super();
}

@immutable
class UsersFetchSuccess extends UsersState {
  const UsersFetchSuccess({List<UserData>? data}) : super(data: data);
}

@immutable
class UsersFetchFailed extends UsersState {
  const UsersFetchFailed({String? message}) : super(message: message);
}
