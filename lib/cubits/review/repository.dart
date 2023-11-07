part of 'cubit.dart';

class ReviewRepository {
  Future<void> update(
    String id,
    Review review,
    int index, [
    bool? isHotel,
    bool? isResort,
    bool? isIsland,
  ]) =>
      ReviewDataProvider.update(
        id,
        review,
        index,
        isHotel,
        isResort,
        isIsland,
      );
}
