
import 'package:form_builder_test/data/data_source/local_data_source.dart';
import 'package:form_builder_test/data/data_source/remote_data_source.dart';
import 'package:form_builder_test/data/database/hive_database.dart';
import 'package:form_builder_test/data/network/api_client.dart';
import 'package:form_builder_test/data/network/dio_factory.dart';
import 'package:form_builder_test/data/network/network_info.dart';
import 'package:form_builder_test/data/repository_impl/form_repository_impl.dart';
import 'package:form_builder_test/data/repository_impl/repository_impl.dart';
import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/domain/repository/repository.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';
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

  HiveDatabase _hiveDatabase = HiveDatabase();
  await _hiveDatabase.init();
  getIT.registerLazySingleton<HiveDatabase>(() => _hiveDatabase);
  // await initHiveDatabase();
  getIT.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(getIT<HiveDatabase>()));


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
  getIT.registerLazySingleton<FormsBloc>(() => FormsBloc(getIT<AssignedFormRepository>()));
}






