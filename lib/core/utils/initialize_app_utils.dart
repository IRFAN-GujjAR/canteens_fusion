import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/shared_pref/shared_pref_utils.dart';
import 'package:canteens_fusion/features/app_launch/data/datasources/app_launch_data_source.dart';
import 'package:canteens_fusion/features/app_launch/data/repositories/app_launch_repo_impl.dart';
import 'package:canteens_fusion/features/app_launch/domain/usecases/app_launch_use_case.dart';
import 'package:canteens_fusion/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:canteens_fusion/features/auth/data/datasources/remote/auth_manage_remote_data_source.dart';
import 'package:canteens_fusion/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:canteens_fusion/features/auth/data/repositories/auth_manage_repo_impl.dart';
import 'package:canteens_fusion/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_change_user_type_usecase.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_current_user_usecase.dart';
import 'package:canteens_fusion/features/auth/domain/usecases/auth_reload_user_usecase.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/data/data_sources/canteen_details_data_source.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/data/repositories/canteen_details_repo_impl.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/domain/use_cases/canteen_details_use_case_fetch.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/providers/canteen_details_provider.dart';
import 'package:canteens_fusion/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;
Logger get customLogger => locator.get<Logger>();
String get geoCodingApiKey =>
    locator.get<String>(instanceName: 'geo_coding_api_key');

Future<Widget> get initializeFlutterApp async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebaseApp;
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<UserSessionProvider>.value(
        value: await _initializeServicesApp,
      ),
      ChangeNotifierProvider(create: (_) => CanteenDetailsProvider()),
      BlocProvider(create: (_) => _canteenDetailsBloc),
    ],
    child: const MyApp(),
  );
}

CanteenDetailsBloc get _canteenDetailsBloc {
  final canteenDetailsRepo = CanteenDetailsRepoImpl(
    CanteenDetailsDataSourceImpl(locator.get<FirebaseFirestore>()),
  );
  return CanteenDetailsBloc(CanteenDetailsUseCaseFetch(canteenDetailsRepo));
}

Future<void> get _initializeFirebaseApp async {
  await Firebase.initializeApp();
}

Future<UserSessionProvider> get _initializeServicesApp async {
  await _initializeGeocodingApiKey;
  final prefsUtils = SharedPrefUtils();
  final prefs = await SharedPreferences.getInstance();
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore =
      FirebaseFirestore.instance
        ..settings = const Settings(persistenceEnabled: false);
  final storage = FirebaseStorage.instance;

  locator.registerLazySingleton<Logger>(() => Logger());
  locator.registerSingleton<SharedPrefUtils>(prefsUtils);
  locator.registerSingleton(prefs);
  locator.registerSingleton<FirebaseAuth>(firebaseAuth);
  locator.registerSingleton<FirebaseFirestore>(fireStore);
  locator.registerSingleton<FirebaseStorage>(storage);

  final authManageRepo = AuthManageRepoImpl(
    AuthLocalDataSourceImpl(
      firebaseAuth: firebaseAuth,
      prefs: prefs,
      prefsUtils: prefsUtils,
    ),
    AuthManageRemoteDataSourceImpl(firebaseAuth),
  );
  final userSessionProvider = UserSessionProvider(
    AuthCurrentUserUseCase(authManageRepo),
    AuthReloadUserUseCase(authManageRepo),
    AuthChangeUserTypeUseCase(authManageRepo),
  );
  await userSessionProvider.checkShowUserTypeSelectionPage(
    AppLaunchUseCase(
      AppLaunchRepoImpl(
        AppLaunchDataSourceImpl(
          authLocalDataSource: AuthLocalDataSourceImpl(
            firebaseAuth: firebaseAuth,
            prefs: prefs,
            prefsUtils: prefsUtils,
          ),
          firebaseAuth: firebaseAuth,
          prefs: prefs,
          prefsUtil: prefsUtils,
        ),
      ),
    ),
  );

  locator.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(AuthRemoteDataSourceImpl(firebaseAuth, fireStore)),
  );

  return userSessionProvider;
}

Future<void> get _initializeGeocodingApiKey async {
  await dotenv.load(fileName: '.env');
  final apiKey = dotenv.env['GEO_CODING_API_KEY']!;
  locator.registerSingleton(apiKey, instanceName: 'geo_coding_api_key');
}
