
// ignore_for_file: unused_import

import 'package:datalines/app/notification_bloc/notifications_bloc.dart';
import 'package:datalines/data/data_source/local_data_source.dart';
import 'package:datalines/data/data_source/remote_data_source.dart';
import 'package:datalines/data/database/hive_database.dart';
import 'package:datalines/data/network/api_client.dart';
import 'package:datalines/data/network/dio_factory.dart';
import 'package:datalines/data/network/network_info.dart';
import 'package:datalines/data/repository_impl/form_repository_impl.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/domain/repository/form_repository.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:datalines/services/io/FileCachingService.dart';
import 'package:datalines/services/notification/NotificationsService.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_prefs.dart';

final getIT = GetIt.instance;



//di for all the app must be lazy and for specific module has to be factory so we use new instance every time



Future<void> initHiveDatabase() async {



}

Future<void> initAppModules() async {

  //shared prefs
  final _prefs = await SharedPreferences.getInstance();
  getIT.registerLazySingleton<SharedPreferences>(() => _prefs);


  //app prefs
  final _appPreferences = AppPreferences(getIT<SharedPreferences>());
  getIT.registerLazySingleton<AppPreferences>(() => _appPreferences);

  //network info
  getIT.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //dio Factoty
  getIT.registerLazySingleton(() => DioFactory(getIT<AppPreferences>()));

  final dio = await getIT<DioFactory>().getDio();

  //api client
  getIT.registerLazySingleton<ApiClient>(() => ApiClient(dio));

  //remote data source

  getIT.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIT<ApiClient>()));


  //local


  FileCachingService _ioService = FileCachingService();
  await _ioService.init();
  getIT.registerLazySingleton<FileCachingService>(() => _ioService);

  HiveDatabase _hiveDatabase = HiveDatabase();
  await _hiveDatabase.init();
  getIT.registerLazySingleton<HiveDatabase>(() => _hiveDatabase);
  getIT.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(getIT<HiveDatabase>(),getIT<FileCachingService>()));



  //notifications
  getIT.registerLazySingleton<NotificationsBloc>(() => NotificationsBloc(NotificationService()));




  //repository
  getIT.registerLazySingleton<AssignedFormRepository>(() => AssignedFormRepositoryImpl(getIT<RemoteDataSource>(),
      getIT<NetworkInfo>(),
      getIT<LocalDataSource>()
  ));
  getIT.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getIT<RemoteDataSource>(),
      getIT<NetworkInfo>(),
      getIT<LocalDataSource>()
  ));


  getIT.registerLazySingleton<StateRendererBloc>(() => StateRendererBloc());


}

void initFormModule (){
  if(!getIT.isRegistered<FormsBloc>())
  getIT.registerLazySingleton<FormsBloc>(() => FormsBloc(getIT<AssignedFormRepository>()));
}





