// ignore_for_file: unused_import

import 'dart:developer';

import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/data/network/api_constants.dart';
import 'package:datalines/data/network/dio_factory.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/app/MyApp.dart';
import 'package:datalines/app/MyBlocObserver.dart';
import 'package:datalines/data/data_source/remote_data_source.dart';
import 'package:datalines/data/mapper/form_fields_mappers.dart';
import 'package:datalines/presentation/home/view/home_screen.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/services/notification/NotificationsService.dart';
import 'package:datalines/services/notification/NotificationManager.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app/dependency_injection.dart';
import 'app/notification_bloc/notifications_bloc.dart';
import 'package:datalines/services/notification/NotificationManager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/network/api_client.dart';
import 'presentation/resources/language_manager.dart';


Future<void> main() async {

 //  final dio = Dio();
 //  var formData = FormData.fromMap({
 //    'name': 'wendux',
 //    'age': 25,
 //    'fasdsaile': await MultipartFile.fromFile(
 //        '/data/user/0/com.flexsolutionsjo.datalines/app_flutter/filePickerCache/65-2/Caerte_van_Oostlant_4MB (1).jpg'),
 //      'a':'s'
 //
 //  });
 //
 //  final headers = DioFactory.getDefaultHeaders;
 //  headers[CONTENT_TYPE] = MULTIPART_FORMDATA;
 //  var response =
 // await dio.post(ApiConstants.baseUrl+ApiConstants.syncFormUrl, data: formData,options: Options(
 //   headers: {
 //     'Accept' : 'json'
 //   }
 // ));
 //
 //  print(response.toString());
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await initAppModules();
  NotificationService().initNotifications();
  BlocOverrides.runZoned(
        () {
      runApp(EasyLocalization(
        supportedLocales: const [englishLocale, arabicLocale],
        path: LanguageAssets.languageAssetBase,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: getIt<NotificationsBloc>(),
            ),

          ],
          child: MyApp(),
        ),));
    },
    blocObserver: MyBlocObserver(),
  );
}


