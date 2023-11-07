part of 'cubit.dart';

// fetch
@immutable
class DiscoverFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<DiscoverItem>? data;
  final String? message;

  const DiscoverFetchState({
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
class DiscoverFetchDefault extends DiscoverFetchState {}

@immutable
class DiscoverFetchLoading extends DiscoverFetchState {
  const DiscoverFetchLoading() : super();
}

@immutable
class DiscoverFetchSuccess extends DiscoverFetchState {
  const DiscoverFetchSuccess({List<DiscoverItem>? data}) : super(data: data);
}

@immutable
class DiscoverFetchFailed extends DiscoverFetchState {
  const DiscoverFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class DiscoverAddState extends Equatable {
  static bool match(a, b) => a.add != b.add;

  final String? message;

  const DiscoverAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class DiscoverAddDefault extends DiscoverAddState {}

@immutable
class DiscoverAddLoading extends DiscoverAddState {
  const DiscoverAddLoading() : super();
}

@immutable
class DiscoverAddSuccess extends DiscoverAddState {
  const DiscoverAddSuccess() : super();
}

@immutable
class DiscoverAddFailed extends DiscoverAddState {
  const DiscoverAddFailed({String? message}) : super(message: message);
}

// delete
@immutable
class DiscoverDeleteState extends Equatable {
  static bool match(a, b) => a.delete != b.delete;

  final String? message;

  const DiscoverDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class DiscoverDeleteDefault extends DiscoverDeleteState {}

@immutable
class DiscoverDeleteLoading extends DiscoverDeleteState {
  const DiscoverDeleteLoading() : super();
}

@immutable
class DiscoverDeleteSuccess extends DiscoverDeleteState {
  const DiscoverDeleteSuccess() : super();
}

@immutable
class DiscoverDeleteFailed extends DiscoverDeleteState {
  const DiscoverDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class DiscoverState extends Equatable {
  final DiscoverFetchState? fetch;
  final DiscoverAddState? add;
  final DiscoverDeleteState? delete;

  const DiscoverState({
    this.fetch,
    this.add,
    this.delete,
  });

  @override
  List<Object?> get props => [
        fetch,
        add,
        delete,
      ];

  DiscoverState copyWith({
    DiscoverFetchState? fetch,
    DiscoverAddState? add,
    DiscoverDeleteState? delete,
  }) {
    return DiscoverState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      delete: delete ?? this.delete,
    );
  }
}

@immutable
class DiscoverStateDefault extends DiscoverState {
  const DiscoverStateDefault()
      : super(
          fetch: const DiscoverFetchState(),
          add: const DiscoverAddState(),
          delete: const DiscoverDeleteState(),
        );
}
