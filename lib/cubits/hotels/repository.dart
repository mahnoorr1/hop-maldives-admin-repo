part of 'cubit.dart';

class HotelsRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() =>
      HotelsDataProvider.fetch();

  Future<void> add(Hotel hotel, List<XFile>? images) =>
      HotelsDataProvider.add(hotel, images);

  Future<void> update(Hotel hotel, List<XFile>? images, int index) =>
      HotelsDataProvider.update(hotel, images, index);

  Future<void> delete(int index) => HotelsDataProvider.delete(index);
}
