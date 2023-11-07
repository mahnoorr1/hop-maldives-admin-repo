part of 'cubit.dart';

// fetch
@immutable
class IslandsFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Island>? data;
  final String? message;

  const IslandsFetchState({
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
class IslandsFetchDefault extends IslandsFetchState {}

@immutable
class IslandsFetchLoading extends IslandsFetchState {
  const IslandsFetchLoading() : super();
}

@immutable
class IslandsFetchSuccess extends IslandsFetchState {
  const IslandsFetchSuccess({List<Island>? data}) : super(data: data);
}

@immutable
class IslandsFetchFailed extends IslandsFetchState {
  const IslandsFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class IslandAddState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const IslandAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class IslandAddDefault extends IslandAddState {}

@immutable
class IslandAddLoading extends IslandAddState {
  const IslandAddLoading() : super();
}

@immutable
class IslandAddSuccess extends IslandAddState {
  const IslandAddSuccess() : super();
}

@immutable
class IslandAddFailed extends IslandAddState {
  const IslandAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class IslandUpdateState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const IslandUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class IslandUpdateDefault extends IslandUpdateState {}

@immutable
class IslandUpdateLoading extends IslandUpdateState {
  const IslandUpdateLoading() : super();
}

@immutable
class IslandUpdateSuccess extends IslandUpdateState {
  const IslandUpdateSuccess() : super();
}

@immutable
class IslandUpdateFailed extends IslandUpdateState {
  const IslandUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class IslandDeleteState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const IslandDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class IslandDeleteDefault extends IslandDeleteState {}

@immutable
class IslandDeleteLoading extends IslandDeleteState {
  const IslandDeleteLoading() : super();
}

@immutable
class IslandDeleteSuccess extends IslandDeleteState {
  const IslandDeleteSuccess() : super();
}

@immutable
class IslandDeleteFailed extends IslandDeleteState {
  const IslandDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class IslandsState extends Equatable {
  final IslandsFetchState? fetch;
  final IslandAddState? add;
  final IslandUpdateState? update;
  final IslandDeleteState? delete;

  const IslandsState({
    this.fetch,
    this.add,
    this.update,
    this.delete,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        update,
        delete,
      ];

  IslandsState copyWith({
    IslandsFetchState? fetch,
    IslandAddState? add,
    IslandUpdateState? update,
    IslandDeleteState? delete,
  }) {
    return IslandsState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      update: update ?? this.update,
      delete: delete ?? this.delete,
    );
  }
}

@immutable
class IslandsStateDefault extends IslandsState {
  const IslandsStateDefault()
      : super(
          fetch: const IslandsFetchState(),
          add: const IslandAddState(),
          update: const IslandUpdateState(),
          delete: const IslandDeleteState(),
        );
}
