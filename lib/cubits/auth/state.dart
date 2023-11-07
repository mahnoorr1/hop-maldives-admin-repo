part of 'cubit.dart';

@immutable
class AuthState extends Equatable {
  final User? data;
  final String? message;

  const AuthState({
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
class AuthDefault extends AuthState {}

@immutable
class AuthFetchLoading extends AuthState {
  const AuthFetchLoading() : super();
}

@immutable
class AuthFetchSuccess extends AuthState {
  const AuthFetchSuccess({User? data}) : super(data: data);
}

@immutable
class AuthFetchFailed extends AuthState {
  const AuthFetchFailed({String? message}) : super(message: message);
}

@immutable
class AuthLoginLoading extends AuthState {
  const AuthLoginLoading() : super();
}

@immutable
class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess({User? data}) : super(data: data);
}

@immutable
class AuthLoginFailed extends AuthState {
  const AuthLoginFailed({String? message}) : super(message: message);
}

@immutable
class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading() : super();
}

@immutable
class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess({User? data}) : super(data: data);
}

@immutable
class AuthLogoutFailed extends AuthState {
  const AuthLogoutFailed({String? message}) : super(message: message);
}
