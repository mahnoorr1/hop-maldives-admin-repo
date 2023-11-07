import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/cubits/discover/cubit.dart';
import 'package:provider/provider.dart';

import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/models/discover_item.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/providers/image_picker_provider.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:hop_maldives_admin/widgets/app_icon_button.dart';
import 'package:hop_maldives_admin/widgets/text_fields/multiline_text_field.dart';

part 'widgets/_item_card.dart';
part 'widgets/_item_form.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

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
                'Manage Discover',
                style: AppText.h1b,
              ),
              Space.xm!,
              SizedBox(
                width: AppDimensions.normalize(80),
                height: AppDimensions.normalize(18),
                child: AppButton(
                  child: Text(
                    'Add Item',
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
                          child: const _ItemForm(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Space.y2!,
          BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              if (state.fetch is DiscoverFetchFailed) {
                return Center(
                  child: Text(state.fetch!.message!),
                );
              } else if (state.fetch is DiscoverFetchLoading) {
                return const LinearProgressIndicator();
              } else if (state.fetch is DiscoverFetchSuccess) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: AppDimensions.normalize(5),
                      runSpacing: AppDimensions.normalize(5),
                      children: state.fetch!.data!
                          .asMap()
                          .entries
                          .map(
                            (e) => _ItemCard(
                              e: e.value,
                              index: e.key,
                            ),
                          )
                          .toList(),
                    ),
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
