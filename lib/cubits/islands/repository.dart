part of 'cubit.dart';

class IslandsRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      IslandsDataProvider.fetch();

  Future<void> add(Island island, List<XFile>? images) =>
      IslandsDataProvider.add(island, images);

  Future<void> update(Island island, List<XFile>? images, int index) =>
      IslandsDataProvider.update(island, images, index);

  Future<void> delete(int index) => IslandsDataProvider.delete(index);
}
