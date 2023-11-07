import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/cubits/requests/cubit.dart';
import 'package:hop_maldives_admin/cubits/users/cubit.dart';
import 'package:hop_maldives_admin/models/request.dart';
import 'package:hop_maldives_admin/models/user_data.dart';
import 'package:hop_maldives_admin/widgets/app_button.dart';
import 'package:intl/intl.dart';

part 'widgets/_request_card.dart';

class Requests extends StatelessWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersCubit = UsersCubit.cubit(context);

    return Padding(
      padding: Space.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bookings Requests',
            style: AppText.h1b,
          ),
          Space.y2!,
          BlocBuilder<RequestsCubit, RequestsState>(
            builder: (context, state) {
              if (state.fetch is RequestsFetchLoading) {
                return const LinearProgressIndicator();
              } else if (state.fetch is RequestsFetchSuccess) {
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
                              'Full Name',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Email',
                              style: AppText.b2b,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'No. of Requests',
                              style: AppText.b2b,
                            ),
                          ),
                        ],
                      ),
                      Space.y!,
                      if (state.approve is RequestUpdateLoading) ...[
                        const LinearProgressIndicator(),
                        Space.y!,
                      ],
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.fetch!.data!.length,
                          itemBuilder: (context, index) {
                            final item = state.fetch!.data![index];
                            item.requests.sort(
                                (a, b) => b.createdAt.compareTo(a.createdAt));
                            List<UserData> users = usersCubit.state.data!
                                .where((element) => element.uid == item.uid)
                                .toList();

                            return ExpansionTile(
                              expandedAlignment: Alignment.center,
                              tilePadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.uid.substring(0, 8),
                                      style: AppText.l1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      users.first.fullName,
                                      style: AppText.l1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      users.first.email,
                                      style: AppText.l1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.requests.length.toString(),
                                      style: AppText.l1,
                                    ),
                                  ),
                                ],
                              ),
                              childrenPadding: Space.all(0.5),
                              children: [
                                Wrap(
                                  spacing: AppDimensions.normalize(5),
                                  runSpacing: AppDimensions.normalize(5),
                                  children: item.requests
                                      .asMap()
                                      .entries
                                      .map((e) => _RequestCard(
                                            key: ObjectKey(e.value),
                                            e: e.value,
                                            index: e.key,
                                          ))
                                      .toList(),
                                )
                              ],
                            );
                          },
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
