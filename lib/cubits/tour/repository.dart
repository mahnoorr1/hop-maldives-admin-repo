part of 'cubit.dart';

class TourRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetch() =>
      TourDataProvider.fetch();
}
