part of 'cubit.dart';

class DivingDataProvider {
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

  static Future<void> add(Diving diving, List<XFile>? images) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['divings'] ?? [];

      List<String> urls = await uploadImages(diving.name, images);
      diving.images = urls;

      data.add(diving.toMap());

      map['divings'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update(
      Diving diving, List<XFile>? images, int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['divings'] ?? [];

      List<String> urls = await uploadImages(diving.name, images);
      diving.images = List.from(diving.images)..addAll(urls);

      data.removeAt(index);
      data.insert(index, diving.toMap());

      map['divings'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete(int index) async {
    try {
      final raw = await products.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['divings'] ?? [];

      Diving diving = Diving.fromMap(data[index]);
      deletImages(diving.name, diving.images);

      data.removeAt(index);

      map['divings'] = data;

      await products.set(map);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<String>> uploadImages(
      String divingName, List<XFile>? files) async {
    try {
      List<String> urls = [];
      if (files != null) {
        for (var file in files) {
          Reference ref =
              firebaseStorage.ref('/divings/$divingName/').child(file.name);

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

  static Future<void> deletImages(String divingName, List<String> urls) async {
    try {
      for (var url in urls) {
        firebaseStorage.ref(url).delete();
      }
      firebaseStorage.ref('/divings/$divingName/').delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
