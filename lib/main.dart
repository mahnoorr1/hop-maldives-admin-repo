import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hop_maldives_admin/app_routes.dart';
import 'package:hop_maldives_admin/cubits/auth/cubit.dart';
import 'package:hop_maldives_admin/cubits/chat/cubit.dart';
import 'package:hop_maldives_admin/cubits/discover/cubit.dart';
import 'package:hop_maldives_admin/cubits/diving/cubit.dart';
import 'package:hop_maldives_admin/cubits/excursion/cubit.dart';
import 'package:hop_maldives_admin/cubits/hotels/cubit.dart';
import 'package:hop_maldives_admin/cubits/islands/cubit.dart';
import 'package:hop_maldives_admin/cubits/requests/cubit.dart';
import 'package:hop_maldives_admin/cubits/resorts/cubit.dart';
import 'package:hop_maldives_admin/cubits/review/cubit.dart';
import 'package:hop_maldives_admin/cubits/tour/cubit.dart';
import 'package:hop_maldives_admin/cubits/users/cubit.dart';
import 'package:hop_maldives_admin/firebase_options.dart';
import 'package:hop_maldives_admin/providers/chat_provider.dart';
import 'package:hop_maldives_admin/providers/form_provider.dart';
import 'package:hop_maldives_admin/providers/image_picker_provider.dart';
import 'package:hop_maldives_admin/providers/tab_provider.dart';
import 'package:hop_maldives_admin/screens/dashboard/dashboard.dart';
import 'package:hop_maldives_admin/screens/login/login.dart';
import 'package:hop_maldives_admin/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'configs/core_theme.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();

  await Hive.initFlutter();

  Hive.openBox('users');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(create: (_) => TourCubit()),
        BlocProvider(create: (_) => UsersCubit()),
        BlocProvider(create: (_) => ReviewCubit()),
        BlocProvider(create: (_) => DivingCubit()),
        BlocProvider(create: (_) => HotelsCubit()),
        BlocProvider(create: (_) => IslandsCubit()),
        BlocProvider(create: (_) => ResortsCubit()),
        BlocProvider(create: (_) => RequestsCubit()),
        BlocProvider(create: (_) => DiscoverCubit()),
        BlocProvider(create: (_) => ExcursionCubit()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hope Maldives Admin',
        theme: theme.themeLight,
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.dashboard: (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
