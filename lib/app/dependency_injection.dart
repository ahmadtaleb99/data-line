
// ignore_for_file: unused_import

import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/app/notification_bloc/notifications_bloc.dart';
import 'package:datalines/data/data_source/local_data_source.dart';
import 'package:datalines/data/data_source/remote_data_source.dart';
import 'package:datalines/data/database/hive_database.dart';
import 'package:datalines/data/network/api_client.dart';
import 'package:datalines/data/network/cancel_tokens.dart';
import 'package:datalines/data/network/dio_factory.dart';
import 'package:datalines/data/network/network_info.dart';
import 'package:datalines/data/repository_impl/form_repository_impl.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/domain/repository/form_repository.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/services/io/FileCachingService.dart';
import 'package:datalines/services/notification/NotificationsService.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_prefs.dart';

final getIt = GetIt.instance;



//di for all the app must be lazy and for specific module has to be factory so we use new instance every time




Future<void> initAppModules() async {

  //shared prefs
  final _prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => _prefs);


  //app prefs
  final _appPreferences = AppPreferences(getIt<SharedPreferences>());
  getIt.registerLazySingleton<AppPreferences>(() => _appPreferences);

  //network info
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //dio Factoty
  getIt.registerLazySingleton(() => DioFactory(getIt<AppPreferences>()));

  final dio = await getIt<DioFactory>().getDio();

  //api client
  getIt.registerLazySingleton<ApiClient>(() => ApiClientImpl(dio,CancelTokenHandler()));

  //remote data source

  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIt<ApiClient>()));


  //local


  FileCachingService _ioService = FileCachingService();
  await _ioService.init();
  getIt.registerLazySingleton<FileCachingService>(() => _ioService);

  HiveDatabase _hiveDatabase = HiveDatabase();
  await _hiveDatabase.init();
  getIt.registerLazySingleton<HiveDatabase>(() => _hiveDatabase);
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(getIt<HiveDatabase>(),getIt<FileCachingService>()));

/////////////////////
//Authentication
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getIt<RemoteDataSource>(),
      getIt<NetworkInfo>(),
      getIt<LocalDataSource>()
  ));

  ///////////////////////////////////////



  //notifications
  getIt.registerLazySingleton<NotificationsBloc>(() => NotificationsBloc(NotificationService()));




  //repository
  getIt.registerLazySingleton<AssignedFormRepository>(() => AssignedFormRepositoryImpl(getIt<RemoteDataSource>(),
      getIt<NetworkInfo>(),
      getIt<LocalDataSource>()
  ));





}

void initFormModule (){
  if(!getIt.isRegistered<FormsBloc>())
  getIt.registerLazySingleton<FormsBloc>(() => FormsBloc(getIt<AssignedFormRepository>()));
}



AuthenticationBloc registerAuthBloc (){
  if(!getIt.isRegistered<AuthenticationBloc>())
    getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(getIt<AuthenticationRepository>()));
  return getIt<AuthenticationBloc>();
}

