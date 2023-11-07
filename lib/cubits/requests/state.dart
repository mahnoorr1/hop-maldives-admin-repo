part of 'cubit.dart';

@immutable
class RequestsFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<BookingRequests>? data;
  final String? message;

  const RequestsFetchState({
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
class RequestsFetchDefault extends RequestsFetchState {}

@immutable
class RequestsFetchLoading extends RequestsFetchState {
  const RequestsFetchLoading() : super();
}

@immutable
class RequestsFetchSuccess extends RequestsFetchState {
  const RequestsFetchSuccess({List<BookingRequests>? data}) : super(data: data);
}

@immutable
class RequestsFetchFailed extends RequestsFetchState {
  const RequestsFetchFailed({String? message}) : super(message: message);
}

// update request
@immutable
class RequestUpdateState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const RequestUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class RequestUpdateDefault extends RequestUpdateState {}

@immutable
class RequestUpdateLoading extends RequestUpdateState {
  const RequestUpdateLoading() : super();
}

@immutable
class RequestUpdateSuccess extends RequestUpdateState {
  const RequestUpdateSuccess() : super();
}

@immutable
class RequestUpdateFailed extends RequestUpdateState {
  const RequestUpdateFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class RequestsState extends Equatable {
  final RequestsFetchState? fetch;
  final RequestUpdateState? approve;

  const RequestsState({
    this.fetch,
    this.approve,
  });

  @override
  List<Object?> get props => [
        fetch,
        approve,
      ];

  RequestsState copyWith({
    RequestsFetchState? fetch,
    RequestUpdateState? approve,
  }) {
    return RequestsState(
      fetch: fetch ?? this.fetch,
      approve: approve ?? this.approve,
    );
  }
}

@immutable
class RequestsStateDefault extends RequestsState {
  const RequestsStateDefault()
      : super(
          fetch: const RequestsFetchState(),
          approve: const RequestUpdateState(),
        );
}
