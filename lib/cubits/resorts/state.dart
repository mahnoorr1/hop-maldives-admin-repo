part of 'cubit.dart';

@immutable
class ResortsFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Resort>? data;
  final String? message;

  const ResortsFetchState({
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
class ResortsFetchDefault extends ResortsFetchState {}

@immutable
class ResortsFetchLoading extends ResortsFetchState {
  const ResortsFetchLoading() : super();
}

@immutable
class ResortsFetchSuccess extends ResortsFetchState {
  const ResortsFetchSuccess({List<Resort>? data}) : super(data: data);
}

@immutable
class ResortsFetchFailed extends ResortsFetchState {
  const ResortsFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class ResortAddState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const ResortAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ResortAddDefault extends ResortAddState {}

@immutable
class ResortAddLoading extends ResortAddState {
  const ResortAddLoading() : super();
}

@immutable
class ResortAddSuccess extends ResortAddState {
  const ResortAddSuccess() : super();
}

@immutable
class ResortAddFailed extends ResortAddState {
  const ResortAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class ResortUpdateState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const ResortUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ResortUpdateDefault extends ResortUpdateState {}

@immutable
class ResortUpdateLoading extends ResortUpdateState {
  const ResortUpdateLoading() : super();
}

@immutable
class ResortUpdateSuccess extends ResortUpdateState {
  const ResortUpdateSuccess() : super();
}

@immutable
class ResortUpdateFailed extends ResortUpdateState {
  const ResortUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class ResortDeleteState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const ResortDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ResortDeleteDefault extends ResortDeleteState {}

@immutable
class ResortDeleteLoading extends ResortDeleteState {
  const ResortDeleteLoading() : super();
}

@immutable
class ResortDeleteSuccess extends ResortDeleteState {
  const ResortDeleteSuccess() : super();
}

@immutable
class ResortDeleteFailed extends ResortDeleteState {
  const ResortDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class ResortsState extends Equatable {
  final ResortsFetchState? fetch;
  final ResortAddState? add;
  final ResortDeleteState? delete;
  final ResortUpdateState? update;

  const ResortsState({
    this.fetch,
    this.add,
    this.delete,
    this.update,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        delete,
        update,
      ];

  ResortsState copyWith({
    ResortsFetchState? fetch,
    ResortAddState? add,
    ResortDeleteState? delete,
    ResortUpdateState? update,
  }) {
    return ResortsState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      delete: delete ?? this.delete,
      update: update ?? this.update,
    );
  }
}

@immutable
class ResortsStateDefault extends ResortsState {
  const ResortsStateDefault()
      : super(
          fetch: const ResortsFetchState(),
          add: const ResortAddState(),
          delete: const ResortDeleteState(),
          update: const ResortUpdateState(),
        );
}
