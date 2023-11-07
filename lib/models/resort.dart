// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hop_maldives_admin/models/facilities.dart';
import 'package:hop_maldives_admin/models/review.dart';

class Resort {
  final String id;
  final String name;
  final String address;
  final String description;
  final double lat;
  final double lng;
  final double price;
  final List<Review> reviews;
  List<String> images;
  final Facilities facilities;
  final bool isPopular;
  final double inclusiveCharges;
  Resort({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng,
    required this.price,
    required this.reviews,
    required this.images,
    required this.facilities,
    required this.isPopular,
    required this.inclusiveCharges,
  });

  Resort copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    double? lat,
    double? lng,
    double? price,
    List<Review>? reviews,
    List<String>? images,
    Facilities? facilities,
    bool? isPopular,
    double? inclusiveCharges,
  }) {
    return Resort(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      price: price ?? this.price,
      reviews: reviews ?? this.reviews,
      images: images ?? this.images,
      facilities: facilities ?? this.facilities,
      isPopular: isPopular ?? this.isPopular,
      inclusiveCharges: inclusiveCharges ?? this.inclusiveCharges,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'lat': lat,
      'lng': lng,
      'price': price,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'images': images,
      'facilities': facilities.toMap(),
      'isPopular': isPopular,
      'inclusiveCharges': inclusiveCharges,
    };
  }

  factory Resort.fromMap(Map<String, dynamic> map) {
    return Resort(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      description: map['description'],
      lat: map['lat'],
      lng: map['lng'],
      price: double.parse(map['price'].toString()),
      reviews: List<Review>.from(
        (map['reviews'] as List<dynamic>)
            .map<Review?>((x) => Review.fromMap(x)),
      ),
      images: List<String>.from(map['images']),
      facilities: Facilities.fromMap(map['facilities']),
      isPopular: map['isPopular'],
      inclusiveCharges: double.parse(map['inclusiveCharges'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Resort.fromJson(String source) =>
      Resort.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Resort(id: $id, name: $name, address: $address, description: $description, lat: $lat, lng: $lng, price: $price, reviews: $reviews, images: $images, facilities: $facilities, isPopular: $isPopular, inclusiveCharges: $inclusiveCharges)';
  }

  @override
  bool operator ==(covariant Resort other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.description == description &&
        other.lat == lat &&
        other.lng == lng &&
        other.price == price &&
        listEquals(other.reviews, reviews) &&
        listEquals(other.images, images) &&
        other.facilities == facilities &&
        other.isPopular == isPopular &&
        other.inclusiveCharges == inclusiveCharges;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        description.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        price.hashCode ^
        reviews.hashCode ^
        images.hashCode ^
        facilities.hashCode ^
        isPopular.hashCode ^
        inclusiveCharges.hashCode;
  }
}
