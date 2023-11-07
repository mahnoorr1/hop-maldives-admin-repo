part of 'cubit.dart';

// fetch
@immutable
class DivingFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Diving>? data;
  final String? message;

  const DivingFetchState({
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
class DivingFetchDefault extends DivingFetchState {}

@immutable
class DivingFetchLoading extends DivingFetchState {
  const DivingFetchLoading() : super();
}

@immutable
class DivingFetchSuccess extends DivingFetchState {
  const DivingFetchSuccess({List<Diving>? data}) : super(data: data);
}

@immutable
class DivingFetchFailed extends DivingFetchState {
  const DivingFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class DivingAddState extends Equatable {
  static bool match(a, b) => a.add != b.add;

  final String? message;

  const DivingAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class DivingAddDefault extends DivingAddState {}

@immutable
class DivingAddLoading extends DivingAddState {
  const DivingAddLoading() : super();
}

@immutable
class DivingAddSuccess extends DivingAddState {
  const DivingAddSuccess() : super();
}

@immutable
class DivingAddFailed extends DivingAddState {
  const DivingAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class DivingUpdateState extends Equatable {
  static bool match(a, b) => a.update != b.update;

  final String? message;

  const DivingUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class DivingUpdateDefault extends DivingUpdateState {}

@immutable
class DivingUpdateLoading extends DivingUpdateState {
  const DivingUpdateLoading() : super();
}

@immutable
class DivingUpdateSuccess extends DivingUpdateState {
  const DivingUpdateSuccess() : super();
}

@immutable
class DivingUpdateFailed extends DivingUpdateState {
  const DivingUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class DivingDeleteState extends Equatable {
  static bool match(a, b) => a.delete != b.delete;

  final String? message;

  const DivingDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class DivingDeleteDefault extends DivingDeleteState {}

@immutable
class DivingDeleteLoading extends DivingDeleteState {
  const DivingDeleteLoading() : super();
}

@immutable
class DivingDeleteSuccess extends DivingDeleteState {
  const DivingDeleteSuccess() : super();
}

@immutable
class DivingDeleteFailed extends DivingDeleteState {
  const DivingDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class DivingState extends Equatable {
  final DivingFetchState? fetch;
  final DivingAddState? add;
  final DivingUpdateState? update;
  final DivingDeleteState? delete;

  const DivingState({
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

  DivingState copyWith({
    DivingFetchState? fetch,
    DivingUpdateState? update,
    DivingDeleteState? delete,
    DivingAddState? add,
  }) {
    return DivingState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      update: update ?? this.update,
      delete: delete ?? this.delete,
    );
  }
}

@immutable
class DivingStateDefault extends DivingState {
  const DivingStateDefault()
      : super(
          fetch: const DivingFetchState(),
          add: const DivingAddState(),
          update: const DivingUpdateState(),
          delete: const DivingDeleteState(),
        );
}
