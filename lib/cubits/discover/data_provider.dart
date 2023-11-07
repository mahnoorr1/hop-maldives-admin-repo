part of 'cubit.dart';

class DiscoverDataProvider {
  static final firestore = FirebaseFirestore.instance;
  static final discover = firestore.collection('discover').doc('data');

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetch() {
    try {
      final raw = discover.snapshots();
      return raw.asBroadcastStream();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<DiscoverItem>> add(String description, XFile image) async {
    try {
      final raw = await discover.get();
      Map<String, dynamic> data = raw.data()!;

      String url = await uploadImage(image);

      List images = data['images'];
      images.add({
        'description': description,
        'url': url,
      });

      await discover.set({
        'images': images,
      });

      List<DiscoverItem> imgs = List.generate(
        images.length,
        (i) => DiscoverItem.fromMap(
          images[i],
        ),
      );

      return imgs;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<DiscoverItem>> delete(int index) async {
    try {
      final raw = await discover.get();
      Map<String, dynamic>? map = raw.data();

      List data = map!['images'] ?? [];

      String path = data[index]['url'];

      data.removeAt(index);

      map['images'] = data;

      await discover.set(map);
      List<DiscoverItem> imgs = List.generate(
        data.length,
        (i) => DiscoverItem.fromMap(
          data[i],
        ),
      );

      FirebaseStorage.instance.ref(path).delete();

      return imgs;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<String> uploadImage(XFile? file) async {
    try {
      String link = '';
      if (file != null) {
        Reference ref =
            FirebaseStorage.instance.ref('/discover/').child(file.name);

        final bytes = await file.readAsBytes();

        await ref.putData(bytes);

        String url = await ref.getDownloadURL();
        link = url;
      }

      return link;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
