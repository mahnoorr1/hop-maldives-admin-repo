part of 'cubit.dart';

// fetch
@immutable
class ExcursionFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Excursion>? data;
  final String? message;

  const ExcursionFetchState({
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
class ExcursionFetchDefault extends ExcursionFetchState {}

@immutable
class ExcursionFetchLoading extends ExcursionFetchState {
  const ExcursionFetchLoading() : super();
}

@immutable
class ExcursionFetchSuccess extends ExcursionFetchState {
  const ExcursionFetchSuccess({List<Excursion>? data}) : super(data: data);
}

@immutable
class ExcursionFetchFailed extends ExcursionFetchState {
  const ExcursionFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class ExcursionAddState extends Equatable {
  static bool match(a, b) => a.add != b.add;

  final String? message;

  const ExcursionAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ExcursionAddDefault extends ExcursionAddState {}

@immutable
class ExcursionAddLoading extends ExcursionAddState {
  const ExcursionAddLoading() : super();
}

@immutable
class ExcursionAddSuccess extends ExcursionAddState {
  const ExcursionAddSuccess() : super();
}

@immutable
class ExcursionAddFailed extends ExcursionAddState {
  const ExcursionAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class ExcursionUpdateState extends Equatable {
  static bool match(a, b) => a.update != b.update;

  final String? message;

  const ExcursionUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ExcursionUpdateDefault extends ExcursionUpdateState {}

@immutable
class ExcursionUpdateLoading extends ExcursionUpdateState {
  const ExcursionUpdateLoading() : super();
}

@immutable
class ExcursionUpdateSuccess extends ExcursionUpdateState {
  const ExcursionUpdateSuccess() : super();
}

@immutable
class ExcursionUpdateFailed extends ExcursionUpdateState {
  const ExcursionUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class ExcursionDeleteState extends Equatable {
  static bool match(a, b) => a.delete != b.delete;

  final String? message;

  const ExcursionDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ExcursionDeleteDefault extends ExcursionDeleteState {}

@immutable
class ExcursionDeleteLoading extends ExcursionDeleteState {
  const ExcursionDeleteLoading() : super();
}

@immutable
class ExcursionDeleteSuccess extends ExcursionDeleteState {
  const ExcursionDeleteSuccess() : super();
}

@immutable
class ExcursionDeleteFailed extends ExcursionDeleteState {
  const ExcursionDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class ExcursionState extends Equatable {
  final ExcursionFetchState? fetch;
  final ExcursionAddState? add;
  final ExcursionUpdateState? update;
  final ExcursionDeleteState? delete;

  const ExcursionState({
    this.fetch,
    this.add,
    this.update,
    this.delete,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        delete,
        update,
      ];

  ExcursionState copyWith({
    ExcursionFetchState? fetch,
    ExcursionUpdateState? update,
    ExcursionDeleteState? delete,
    ExcursionAddState? add,
  }) {
    return ExcursionState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      update: update ?? this.update,
      delete: delete ?? this.delete,
    );
  }
}

@immutable
class ExcursionStateDefault extends ExcursionState {
  const ExcursionStateDefault()
      : super(
          fetch: const ExcursionFetchState(),
          add: const ExcursionAddState(),
          update: const ExcursionUpdateState(),
          delete: const ExcursionDeleteState(),
        );
}
