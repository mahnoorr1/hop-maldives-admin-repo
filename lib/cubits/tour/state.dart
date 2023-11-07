part of 'cubit.dart';

// fetch
@immutable
class TourFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Tour>? data;
  final String? message;

  const TourFetchState({
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
class TourFetchDefault extends TourFetchState {}

@immutable
class TourFetchLoading extends TourFetchState {
  const TourFetchLoading() : super();
}

@immutable
class TourFetchSuccess extends TourFetchState {
  const TourFetchSuccess({List<Tour>? data}) : super(data: data);
}

@immutable
class TourFetchFailed extends TourFetchState {
  const TourFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class TourAddState extends Equatable {
  static bool match(a, b) => a.add != b.add;

  final String? message;

  const TourAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class TourAddDefault extends TourAddState {}

@immutable
class TourAddLoading extends TourAddState {
  const TourAddLoading() : super();
}

@immutable
class TourAddSuccess extends TourAddState {
  const TourAddSuccess() : super();
}

@immutable
class TourAddFailed extends TourAddState {
  const TourAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class TourUpdateState extends Equatable {
  static bool match(a, b) => a.update != b.update;

  final String? message;

  const TourUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class TourUpdateDefault extends TourUpdateState {}

@immutable
class TourUpdateLoading extends TourUpdateState {
  const TourUpdateLoading() : super();
}

@immutable
class TourUpdateSuccess extends TourUpdateState {
  const TourUpdateSuccess() : super();
}

@immutable
class TourUpdateFailed extends TourUpdateState {
  const TourUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class TourDeleteState extends Equatable {
  static bool match(a, b) => a.delete != b.delete;

  final String? message;

  const TourDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class TourDeleteDefault extends TourDeleteState {}

@immutable
class TourDeleteLoading extends TourDeleteState {
  const TourDeleteLoading() : super();
}

@immutable
class TourDeleteSuccess extends TourDeleteState {
  const TourDeleteSuccess() : super();
}

@immutable
class TourDeleteFailed extends TourDeleteState {
  const TourDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class TourState extends Equatable {
  final TourDeleteState? delete;
  final TourUpdateState? update;
  final TourFetchState? fetch;
  final TourAddState? add;

  const TourState({
    this.update,
    this.delete,
    this.fetch,
    this.add,
  });

  @override
  List<Object?> get props => [
        update,
        delete,
        fetch,
        add,
      ];

  TourState copyWith({
    TourUpdateState? update,
    TourDeleteState? delete,
    TourFetchState? fetch,
    TourAddState? add,
  }) {
    return TourState(
      update: update ?? this.update,
      delete: delete ?? this.delete,
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
    );
  }
}

@immutable
class TourStateDefault extends TourState {
  const TourStateDefault()
      : super(
          update: const TourUpdateState(),
          delete: const TourDeleteState(),
          fetch: const TourFetchState(),
          add: const TourAddState(),
        );
}
