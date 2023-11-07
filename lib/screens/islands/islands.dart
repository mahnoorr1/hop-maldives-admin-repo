import 'package:hop_maldives_admin/cubits/diving/cubit.dart';
import 'package:hop_maldives_admin/cubits/excursion/cubit.dart';
import 'package:hop_maldives_admin/models/diving.dart';
import 'package:hop_maldives_admin/models/excursion.dart';
import 'package:hop_maldives_admin/widgets/text_fields/multiline_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:hop_maldives_admin/utils/utils.dart';
import 'package:hop_maldives_admin/models/hotel.dart';
import 'package:hop_maldives_admin/models/island.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:hop_maldives_admin/cubits/hotels/cubit.dart';
import 'package:hop_maldives_admin/cubits/islands/cubit.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/widgets/app_icon_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/custom_text_field.dart';
import 'package:hop_maldives_admin/providers/image_picker_provider.dart';

import '../../configs/app.dart';
import '../../models/facilities.dart';

part 'widgets/_add_island_form.dart';
part 'widgets/_edit_island_form.dart';

class Islands extends StatelessWidget {
  const Islands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Manage Islands',
                style: AppText.h1b,
              ),
              Space.xm!,
              SizedBox(
                width: AppDimensions.normalize(80),
                height: AppDimensions.normalize(18),
                child: AppButton(
                  child: Text(
                    'Add Island',
                    style: AppText.b2b!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Dialog(
                          insetPadding: Space.forDialog,
                          child: const _AddIslandForm(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
          Space.y2!,
          BlocBuilder<IslandsCubit, IslandsState>(
            builder: (context, state) {
              if (state.fetch is IslandsFetchLoading) {
                return const LinearProgressIndicator();
              } else if (state.fetch is IslandsFetchSuccess) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ID',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Name',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Address',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Ratings',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Hotels',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Diving Destinations',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Excursions',
                              style: AppText.b2b,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      if (state.delete is HotelDeleteLoading) ...[
                        Space.y!,
                        const LinearProgressIndicator(),
                      ],
                      if (state.fetch!.data != null &&
                          state.fetch!.data!.isNotEmpty) ...[
                        Space.y!,
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.fetch!.data!.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: Space.v!,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].id,
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].name,
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].address,
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].reviews
                                                .isEmpty
                                            ? '0.0'
                                            : AppUtils.ratings(state.fetch!
                                                    .data![index].reviews)
                                                .toStringAsFixed(2),
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].hotels.length
                                            .toString(),
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index]
                                            .divingDestinations.length
                                            .toString(),
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.fetch!.data![index].excursions
                                            .length
                                            .toString(),
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          AppIconButton(
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return Dialog(
                                                  insetPadding:
                                                      Space.forDialog,
                                                  child: _EditIslandForm(
                                                    island: state
                                                        .fetch!.data![index],
                                                    index: index,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Space.x!,
                                          AppIconButton(
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () =>
                                                IslandsCubit.c(context)
                                                    .delete(index),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              'No Islands Found!',
                              style: AppText.b1b,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
