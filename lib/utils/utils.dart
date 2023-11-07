import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hop_maldives_admin/models/review.dart';
import 'package:hop_maldives_admin/screens/discover/discover.dart';
import 'package:hop_maldives_admin/screens/diving_destinations/diving_destinations.dart';
import 'package:hop_maldives_admin/screens/excursion/excursions.dart';
import 'package:hop_maldives_admin/screens/islands/islands.dart';
import 'package:hop_maldives_admin/screens/requests/requests.dart';
import 'package:hop_maldives_admin/screens/hotels/hotels.dart';
import 'package:hop_maldives_admin/screens/chat/chat.dart';
import 'package:hop_maldives_admin/screens/resorts/resorts.dart';
import 'package:hop_maldives_admin/screens/reviews_ratings/reviews_ratings.dart';
import 'package:hop_maldives_admin/screens/tours/tours.dart';

class AppUtils {
  static const List<String> tabs = [
    'Hotels',
    'Islands',
    'Resorts',
    'Excursion',
    'Dive Destinations',
    'Tours',
    'Discover',
    'Requests',
    'Reviews & Ratings',
    'Messages',
  ];

  static const List<Widget> views = [
    Hotels(),
    Islands(),
    Resorts(),
    Excursions(),
    DivingDestinations(),
    Tours(),
    Discover(),
    Requests(),
    ReviewsRatings(),
    Chat(),
  ];

  static const List<IconData> tabsIcons = [
    CommunityMaterialIcons.room_service,
    CommunityMaterialIcons.beach,
    CommunityMaterialIcons.food,
    Icons.people,
    CommunityMaterialIcons.swim,
    CommunityMaterialIcons.wallet_travel,
    CommunityMaterialIcons.image,
    CommunityMaterialIcons.book_settings,
    CommunityMaterialIcons.star,
    CommunityMaterialIcons.chat,
  ];

  static Widget loader(Color color) {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 2,
      ),
    );
  }

  static const List<String> facilities = [
    'wifi',
    'pool',
    'beach',
    'medkit',
    'passengerLift',
    'airportTransfers',
    'parking',
    'restaurant',
    'carRental',
    'laundry',
    'tv',
  ];

  static const List<String> activities = [
    'bigGameFising',
    'canoeing',
    'catamranSailing',
    'flyBoard',
    'funTube',
  ];

  static double ratings(List<Review> reviews) {
    double avg =
        reviews.map((m) => m.ratings).reduce((a, b) => a + b) / reviews.length;

    return avg;
  }
}

class StaticAssets {
  // logos
  static const String logo = 'assets/logos/logo.png';
  static const String fullLogo = 'assets/logos/full_logo.png';

  // images
  static const String dp = 'assets/images/dp.jpg';
  static const String eat = 'assets/images/eat.jpeg';
  static const String eat1 = 'assets/images/eat2.jpeg';
  static const String room = 'assets/images/room.jpeg';
  static const String beach = 'assets/images/beach.jpeg';
  static const String onboarding = 'assets/images/onboarding.png';
}
