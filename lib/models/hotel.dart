// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:hop_maldives_admin/models/facilities.dart';
import 'package:hop_maldives_admin/models/review.dart';

class Hotel {
  final String id;
  final String name;
  final String address;
  final String description;
  final double lat;
  final double lng;
  final double perNightPrice;
  final List<Review> reviews;
  List<String> images;
  final Facilities facilities;
  final bool isPopular;
  final double inclusiveCharges;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng,
    required this.perNightPrice,
    required this.reviews,
    required this.images,
    required this.facilities,
    required this.isPopular,
    required this.inclusiveCharges,
  });

  Hotel copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    double? lat,
    double? lng,
    double? perNightPrice,
    List<Review>? reviews,
    List<String>? images,
    Facilities? facilities,
    bool? isPopular,
    double? inclusiveCharges,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      perNightPrice: perNightPrice ?? this.perNightPrice,
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
      'perNightPrice': perNightPrice,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'images': images,
      'facilities': facilities.toMap(),
      'isPopular': isPopular,
      'inclusiveCharges': inclusiveCharges,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      description: map['description'],
      lat: map['lat'],
      lng: map['lng'],
      perNightPrice: double.parse(map['perNightPrice'].toString()),
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

  factory Hotel.fromJson(String source) =>
      Hotel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hotel(id: $id, name: $name, address: $address, description: $description, lat: $lat, lng: $lng, perNightPrice: $perNightPrice, reviews: $reviews, images: $images, facilities: $facilities, isPopular: $isPopular, inclusiveCharges: $inclusiveCharges)';
  }

  @override
  bool operator ==(covariant Hotel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.description == description &&
        other.lat == lat &&
        other.lng == lng &&
        other.perNightPrice == perNightPrice &&
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
        perNightPrice.hashCode ^
        reviews.hashCode ^
        images.hashCode ^
        facilities.hashCode ^
        isPopular.hashCode ^
        inclusiveCharges.hashCode;
  }
}
