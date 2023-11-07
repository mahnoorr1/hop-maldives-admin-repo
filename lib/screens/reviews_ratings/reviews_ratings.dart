import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/cubits/diving/cubit.dart';
import 'package:hop_maldives_admin/cubits/excursion/cubit.dart';
import 'package:hop_maldives_admin/cubits/hotels/cubit.dart';
import 'package:hop_maldives_admin/cubits/islands/cubit.dart';
import 'package:hop_maldives_admin/cubits/resorts/cubit.dart';
import 'package:hop_maldives_admin/cubits/review/cubit.dart';
import 'package:hop_maldives_admin/models/diving.dart';
import 'package:hop_maldives_admin/models/excursion.dart';
import 'package:hop_maldives_admin/models/hotel.dart';
import 'package:hop_maldives_admin/models/island.dart';
import 'package:hop_maldives_admin/models/resort.dart';
import 'package:hop_maldives_admin/models/review.dart';
import 'package:hop_maldives_admin/providers/tab_provider.dart';
import 'package:hop_maldives_admin/utils/utils.dart';
import 'package:provider/provider.dart';

part 'widgets/_review_card.dart';

class ReviewsRatings extends StatefulWidget {
  const ReviewsRatings({Key? key}) : super(key: key);

  @override
  State<ReviewsRatings> createState() => _ReviewsRatingsState();
}

class _ReviewsRatingsState extends State<ReviewsRatings> {
  @override
  Widget build(BuildContext context) {
    final hotelCubit = HotelsCubit.c(context);
    final islandCubit = IslandsCubit.c(context);
    final resortCubit = ResortsCubit.c(context);
    final divingCubit = DivingCubit.c(context);
    final excursionCubit = ExcursionCubit.c(context);

    final tabProvider = Provider.of<TabProvider>(context);

    return Padding(
      padding: Space.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Manage Reviews',
            style: AppText.h1b,
          ),
          Space.y1!,
          Row(
            children: [
              'Hotels',
              'Islands',
              'Resorts',
              'Dive Destinations',
              'Excursions'
            ]
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: Space.h!,
                    child: GestureDetector(
                      onTap: () => tabProvider.tab = e.key,
                      child: Chip(
                        backgroundColor: e.key == tabProvider.tab
                            ? AppTheme.c!.primary
                            : null,
                        label: Text(
                          e.value,
                          style: AppText.l1!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Space.y1!,
          SingleChildScrollView(
            child: Wrap(
              spacing: AppDimensions.normalize(10),
              runSpacing: AppDimensions.normalize(5),
              children: [
                if (tabProvider.tab == 0)
                  ...hotelCubit.state.fetch!.data!
                      .asMap()
                      .entries
                      .map((e) => _ReviewCard(
                            hotel: e.value,
                          )),
                if (tabProvider.tab == 1)
                  ...islandCubit.state.fetch!.data!
                      .asMap()
                      .entries
                      .map((e) => _ReviewCard(
                            island: e.value,
                          )),
                if (tabProvider.tab == 2)
                  ...resortCubit.state.fetch!.data!
                      .asMap()
                      .entries
                      .map((e) => _ReviewCard(
                            resort: e.value,
                          )),
                if (tabProvider.tab == 3)
                  ...divingCubit.state.fetch!.data!
                      .asMap()
                      .entries
                      .map((e) => _ReviewCard(
                            diving: e.value,
                          )),
                if (tabProvider.tab == 4)
                  ...excursionCubit.state.fetch!.data!
                      .asMap()
                      .entries
                      .map((e) => _ReviewCard(
                            excursion: e.value,
                          )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
