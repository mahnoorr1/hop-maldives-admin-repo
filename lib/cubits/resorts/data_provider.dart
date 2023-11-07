part of 'cubit.dart';

class ResortsDataProvider {
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

  static Future<void> add(Resort resort, List<XFile>? images) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['resorts'] ?? [];

      List<String> urls = await uploadImages(resort.name, images);
      resort.images = urls;

      data.add(resort.toMap());

      map['resorts'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(
      Resort resort, List<XFile>? images, int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['resorts'] ?? [];

      List<String> urls = await uploadImages(resort.name, images);
      resort.images = List.from(resort.images)..addAll(urls);

      data.removeAt(index);
      data.insert(index, resort.toMap());

      map['resorts'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['resorts'] ?? [];
      Resort resort = Resort.fromMap(data[index]);
      deletImages(resort.name, resort.images);

      data.removeAt(index);

      map['resorts'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String resortName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/resorts/$resortName/').child(file.name);

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

  static Future<void> deletImages(String resortName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/resorts/$resortName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
