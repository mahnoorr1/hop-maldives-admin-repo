part of 'cubit.dart';

class DivingRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      DivingDataProvider.fetch();

  Future<void> add(Diving diving, List<XFile>? images) =>
      DivingDataProvider.add(diving, images);

  Future<void> update(Diving diving, List<XFile>? images, int index) =>
      DivingDataProvider.update(diving, images, index);

  Future<void> delete(int index) => DivingDataProvider.delete(index);
}
