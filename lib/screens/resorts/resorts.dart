import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/configs/app_dimensions.dart';
import 'package:hop_maldives_admin/configs/app_typography.dart';
import 'package:hop_maldives_admin/configs/space.dart';
import 'package:hop_maldives_admin/configs/ui_props.dart';
import 'package:hop_maldives_admin/cubits/resorts/cubit.dart';
import 'package:hop_maldives_admin/models/facilities.dart';
import 'package:hop_maldives_admin/models/resort.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/providers/image_picker_provider.dart';
import 'package:hop_maldives_admin/utils/utils.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:hop_maldives_admin/widgets/app_icon_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/custom_text_field.dart';
import 'package:hop_maldives_admin/widgets/text_fields/multiline_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'widgets/_add_resort_form.dart';
part 'widgets/_edit_resort_form.dart';

class Resorts extends StatelessWidget {
  const Resorts({Key? key}) : super(key: key);

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
                'Manage Resorts',
                style: AppText.h1b,
              ),
              Space.xm!,
              SizedBox(
                width: AppDimensions.normalize(80),
                height: AppDimensions.normalize(18),
                child: AppButton(
                  child: Text(
                    'Add Resort',
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
                          child: const _AddResortForm(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Space.y2!,
          BlocBuilder<ResortsCubit, ResortsState>(
            builder: (context, state) {
              if (state.fetch is ResortsFetchLoading) {
                return const LinearProgressIndicator();
              } else if (state.fetch is ResortsFetchSuccess) {
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
                              'Charges (\$)',
                              style: AppText.b2b,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      if (state.delete is ResortDeleteLoading) ...[
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
                                        App.format(
                                          state.fetch!.data![index].price,
                                        ),
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
                                                  child: _EditResortForm(
                                                    resort: state
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
                                                ResortsCubit.c(context)
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
                              'No Resorts Found!',
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
