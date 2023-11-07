part of 'cubit.dart';

class IslandsDataProvider {
  static final firebase = FirebaseFirestore.instance;
  static final firebaseStorage = FirebaseStorage.instance;
  static final products = firebase.collection('products').doc('data');

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() {
    try {
      final raw = products.snapshots();
      return raw.asBroadcastStream();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> add(Island island, List<XFile>? images) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['islands'] ?? [];

      List<String> urls = await uploadImages(island.name, images);
      island.images = urls;

      data.add(island.toMap());

      map['islands'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(
      Island island, List<XFile>? images, int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['islands'] ?? [];

      List<String> urls = await uploadImages(island.name, images);
      island.images = List.from(island.images)..addAll(urls);

      data.removeAt(index);
      data.insert(index, island.toMap());

      map['islands'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['islands'] ?? [];
      Island island = Island.fromMap(data[index]);
      deletImages(island.name, island.images);

      data.removeAt(index);

      map['islands'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String islandName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/islands/$islandName/').child(file.name);

          final bytes = await file.readAsBytes();

          await ref.putData(bytes);

          String url = await ref.getDownloadURL();

          urls.add(url);
        }
      }

      return urls;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deletImages(String islandName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/islands/$islandName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
