part of 'cubit.dart';

// fetch
@immutable
class HotelsFetchState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final List<Hotel>? data;
  final String? message;

  const HotelsFetchState({
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
class HotelsFetchDefault extends HotelsFetchState {}

@immutable
class HotelsFetchLoading extends HotelsFetchState {
  const HotelsFetchLoading() : super();
}

@immutable
class HotelsFetchSuccess extends HotelsFetchState {
  const HotelsFetchSuccess({List<Hotel>? data}) : super(data: data);
}

@immutable
class HotelsFetchFailed extends HotelsFetchState {
  const HotelsFetchFailed({String? message}) : super(message: message);
}

// add
@immutable
class HotelAddState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const HotelAddState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class HotelAddDefault extends HotelAddState {}

@immutable
class HotelAddLoading extends HotelAddState {
  const HotelAddLoading() : super();
}

@immutable
class HotelAddSuccess extends HotelAddState {
  const HotelAddSuccess() : super();
}

@immutable
class HotelAddFailed extends HotelAddState {
  const HotelAddFailed({String? message}) : super(message: message);
}

// update
@immutable
class HotelUpdateState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const HotelUpdateState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class HotelUpdateDefault extends HotelUpdateState {}

@immutable
class HotelUpdateLoading extends HotelUpdateState {
  const HotelUpdateLoading() : super();
}

@immutable
class HotelUpdateSuccess extends HotelUpdateState {
  const HotelUpdateSuccess() : super();
}

@immutable
class HotelUpdateFailed extends HotelUpdateState {
  const HotelUpdateFailed({String? message}) : super(message: message);
}

// delete
@immutable
class HotelDeleteState extends Equatable {
  static bool match(a, b) => a.fetch != b.fetch;

  final String? message;

  const HotelDeleteState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class HotelDeleteDefault extends HotelDeleteState {}

@immutable
class HotelDeleteLoading extends HotelDeleteState {
  const HotelDeleteLoading() : super();
}

@immutable
class HotelDeleteSuccess extends HotelDeleteState {
  const HotelDeleteSuccess() : super();
}

@immutable
class HotelDeleteFailed extends HotelDeleteState {
  const HotelDeleteFailed({String? message}) : super(message: message);
}

// root-state
@immutable
class HotelsState extends Equatable {
  final HotelsFetchState? fetch;
  final HotelAddState? add;
  final HotelDeleteState? delete;
  final HotelUpdateState? update;

  const HotelsState({
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

  HotelsState copyWith({
    HotelsFetchState? fetch,
    HotelAddState? add,
    HotelDeleteState? delete,
    HotelUpdateState? update,
  }) {
    return HotelsState(
      fetch: fetch ?? this.fetch,
      add: add ?? this.add,
      delete: delete ?? this.delete,
      update: update ?? this.update,
    );
  }
}

@immutable
class HotelsStateDefault extends HotelsState {
  const HotelsStateDefault()
      : super(
          fetch: const HotelsFetchState(),
          add: const HotelAddState(),
          delete: const HotelDeleteState(),
          update: const HotelUpdateState(),
        );
}
