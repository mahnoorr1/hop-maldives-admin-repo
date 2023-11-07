import 'dart:convert';

class DiscoverItem {
  final String? url;
  final String? description;
  const DiscoverItem({
    this.url,
    this.description,
  });

  DiscoverItem copyWith({
    String? url,
    String? description,
  }) {
    return DiscoverItem(
      url: url ?? this.url,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'description': description,
    };
  }

  factory DiscoverItem.fromMap(Map<String, dynamic> map) {
    return DiscoverItem(
      url: map['url'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoverItem.fromJson(String source) =>
      DiscoverItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DiscoverImage(url: $url, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscoverItem &&
        other.url == url &&
        other.description == description;
  }

  @override
  int get hashCode => url.hashCode ^ description.hashCode;
}
