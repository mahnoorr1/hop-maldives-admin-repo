import 'package:flutter/material.dart';
import 'package:hop_maldives_admin/cubits/discover/cubit.dart';
import 'package:hop_maldives_admin/cubits/diving/cubit.dart';
import 'package:hop_maldives_admin/cubits/excursion/cubit.dart';
import 'package:hop_maldives_admin/cubits/requests/cubit.dart';
import 'package:hop_maldives_admin/cubits/resorts/cubit.dart';
import 'package:hop_maldives_admin/cubits/tour/cubit.dart';
import 'package:hop_maldives_admin/cubits/users/cubit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/utils/utils.dart';
import 'package:hop_maldives_admin/configs/configs.dart';
import 'package:hop_maldives_admin/cubits/auth/cubit.dart';
import 'package:hop_maldives_admin/cubits/chat/cubit.dart';
import 'package:hop_maldives_admin/cubits/hotels/cubit.dart';
import 'package:hop_maldives_admin/cubits/islands/cubit.dart';
import 'package:hop_maldives_admin/widgets/screen/screen.dart';
import 'package:hop_maldives_admin/providers/tab_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hop_maldives_admin/widgets/overlay_snackbars/overlay_snackbars.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    ChatCubit.c(context).fetch();
    TourCubit.c(context).fetch();
    HotelsCubit.c(context).fetch();
    DivingCubit.c(context).fetch();
    IslandsCubit.c(context).fetch();
    ResortsCubit.c(context).fetch();
    RequestsCubit.c(context).fetch();
    DiscoverCubit.c(context).fetch();
    ExcursionCubit.c(context).fetch();
    UsersCubit.cubit(context).fetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final tabs = Provider.of<TabProvider>(context);

    return Screen(
      overlaySnackbar: [
        BlocBuilder<HotelsCubit, HotelsState>(
          buildWhen: (previous, current) => previous.add != current.add,
          builder: (context, state) {
            if (state.add is HotelAddFailed) {
              return OverlaySnackbar(
                message: state.add!.message!,
                success: false,
              );
            }

            if (state.add is HotelAddSuccess) {
              return const OverlaySnackbar(
                message: 'Hotel has been added successfully!',
                success: true,
              );
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<IslandsCubit, IslandsState>(
          buildWhen: (previous, current) => previous.add != current.add,
          builder: (context, state) {
            if (state.add is IslandAddFailed) {
              return OverlaySnackbar(
                message: state.add!.message!,
                success: false,
              );
            }

            if (state.add is IslandAddSuccess) {
              return const OverlaySnackbar(
                message: 'Island has been added successfully!',
                success: true,
              );
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<ResortsCubit, ResortsState>(
          buildWhen: (previous, current) => previous.add != current.add,
          builder: (context, state) {
            if (state.add is ResortAddFailed) {
              return OverlaySnackbar(
                message: state.add!.message!,
                success: false,
              );
            }

            if (state.add is ResortAddSuccess) {
              return const OverlaySnackbar(
                message: 'Resort has been added successfully!',
                success: true,
              );
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<DiscoverCubit, DiscoverState>(
          builder: (context, state) {
            if (state.add is DiscoverAddFailed ||
                state.delete is DiscoverDeleteFailed ||
                state.fetch is DiscoverFetchFailed) {
              String msg = state.fetch!.message ??
                  state.add!.message ??
                  state.delete!.message!;

              return OverlaySnackbar(
                message: msg,
                success: false,
              );
            }

            if (state.add is DiscoverAddSuccess) {
              return const OverlaySnackbar(
                message: 'Item has been added successfully!',
                success: true,
              );
            }

            if (state.delete is DiscoverDeleteSuccess) {
              return const OverlaySnackbar(
                message: 'Item has been deleted successfully!',
                success: true,
              );
            }
            return const SizedBox();
          },
        )
      ],
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: Space.all(1, 2),
                    color: AppTheme.c!.primary,
                    child: Column(
                      children: [
                        Image.asset(
                          StaticAssets.fullLogo,
                          height: AppDimensions.normalize(35),
                        ),
                        Divider(
                          color: Colors.white,
                          height: AppDimensions.normalize(20),
                        ),
                        ...AppUtils.tabs.asMap().entries.map(
                              (e) => Padding(
                                padding: Space.v!,
                                child: Material(
                                  color: Colors.transparent,
                                  child: ListTile(
                                    onTap: () => tabs.index = e.key,
                                    tileColor: tabs.currentIndex == e.key
                                        ? Colors.white
                                        : Colors.transparent,
                                    leading: Icon(
                                      AppUtils.tabsIcons[e.key],
                                      color: tabs.currentIndex == e.key
                                          ? AppTheme.c!.primary
                                          : Colors.white,
                                    ),
                                    title: Text(
                                      e.value,
                                      style: AppText.b2!.copyWith(
                                        color: tabs.currentIndex == e.key
                                            ? AppTheme.c!.primary
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: const Icon(
                              CommunityMaterialIcons.logout,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Logout',
                              style: AppText.b2!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthLogoutSuccess) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLogoutLoading) {
                                  return const LinearProgressIndicator();
                                }
                                return const SizedBox();
                              },
                            ),
                            onTap: () {
                              AuthCubit.cubit(context).logout();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space.y1!,
                    Expanded(
                      child: AppUtils.views[tabs.currentIndex],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
