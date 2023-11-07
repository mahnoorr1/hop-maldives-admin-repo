import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/cubits/tour/cubit.dart';
import 'package:hop_maldives_admin/models/tour.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/providers/image_picker_provider.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:hop_maldives_admin/widgets/app_icon_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/custom_text_field.dart';
import 'package:hop_maldives_admin/widgets/text_fields/date_text_field.dart';
import 'package:hop_maldives_admin/widgets/text_fields/multiline_text_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'widgets/_add_tour_form.dart';
part 'widgets/_edit_tour_form.dart';

class Tours extends StatelessWidget {
  const Tours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tourCubit = TourCubit.c(context);

    return Padding(
      padding: Space.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Manage Tours',
                style: AppText.h1b,
              ),
              Space.xm!,
              SizedBox(
                width: AppDimensions.normalize(80),
                height: AppDimensions.normalize(18),
                child: AppButton(
                  child: Text(
                    'Add Tour',
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
                          child: const _AddTourForm(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Space.y2!,
          BlocBuilder<TourCubit, TourState>(
            builder: (context, state) {
              if (state.fetch is TourFetchLoading) {
                return const LinearProgressIndicator();
              } else if (state.fetch is TourFetchSuccess) {
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
                              'Package Name',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Places/Address',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Deadline',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Package Price',
                              style: AppText.b2b,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      if (state.delete is TourDeleteLoading) ...[
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
                                        state.fetch!.data![index].place,
                                        style: AppText.l1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        DateFormat('dd MMM, yyyy').format(
                                            state.fetch!.data![index].deadline),
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
                                                  child: _EditTourForm(
                                                    tour: state
                                                        .fetch!.data![index],
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
                                            onPressed: () => tourCubit.delete(
                                                state.fetch!.data![index]),
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
                              'No Tours Found!',
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
