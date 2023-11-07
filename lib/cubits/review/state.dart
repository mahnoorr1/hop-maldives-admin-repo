part of 'cubit.dart';

@immutable
class ReviewState extends Equatable {
  final String? message;

  const ReviewState({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

@immutable
class ReviewDefault extends ReviewState {}

@immutable
class ReviewUpdateLoading extends ReviewState {
  const ReviewUpdateLoading() : super();
}

@immutable
class ReviewUpdateSuccess extends ReviewState {
  const ReviewUpdateSuccess() : super();
}

@immutable
class ReviewUpdateFailed extends ReviewState {
  const ReviewUpdateFailed({String? message}) : super(message: message);
}
