// ignore_for_file: unused_import

import 'dart:developer';

import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/domain/repository/repository.dart';
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


