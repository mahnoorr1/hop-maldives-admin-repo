part of 'cubit.dart';

class ExcursionDataProvider {
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

  static Future<void> add(Excursion exc, List<XFile>? images) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['excursions'] ?? [];

      List<String> urls = await uploadImages(exc.name, images);
      exc.images = urls;

      data.add(exc.toMap());

      map['excursions'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(
      Excursion exc, List<XFile>? images, int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['excursions'] ?? [];

      List<String> urls = await uploadImages(exc.name, images);
      exc.images = List.from(exc.images)..addAll(urls);

      data.removeAt(index);
      data.insert(index, exc.toMap());

      map['excursions'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['excursions'] ?? [];

      Diving diving = Diving.fromMap(data[index]);
      deletImages(diving.name, diving.images);

      data.removeAt(index);

      map['excursions'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String excName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/excursions/$excName/').child(file.name);

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

  static Future<void> deletImages(String excName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/excursions/$excName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
