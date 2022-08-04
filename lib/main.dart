import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/MyApp.dart';
import 'package:form_builder_test/data/data_source/remote_data_source.dart';
import 'package:form_builder_test/data/mapper/form_fields_mappers.dart';
import 'package:form_builder_test/presentation/home/view/home_screen.dart';
import 'package:form_builder_test/presentation/resources/assets_manager.dart';
import 'package:form_builder_test/services/notification/NotificationsService.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app/dependency_injection.dart';
import 'data/FormRepository.dart';
import 'data/FormRepository.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/network/api_client.dart';
import 'presentation/resources/language_manager.dart';

void initNotifications() {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().initialize(
    // senullt the icon to null if you want to use the default app icon
      null,
      NotificationManager.channels,
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: false
  );
}
Future<void> test(  )  async {

  final api = getIT<RemoteDataSource>();
  var res = await  api.getAssignedForms();

  log(res.data![1].fields![7].toDomain().toString());
}

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
   EasyLocalization.ensureInitialized();
 await  initAppModules();

  initNotifications();
  await NotificationService().init();

  runApp(EasyLocalization(
    supportedLocales: const [englishLocale,arabicLocale],
    path: LanguageAssets.languageAssetBase,
    child: MyApp() ,) );
}


// class MyApp extends StatelessWidget {
//
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider(
//       create: (context) => OldFormRepository(),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) =>
//             ValidationBloc(context.read<OldFormRepository>())
//               ..add(ServiceRegistered())..add(FormsRequested()),
//
//           ),
//
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: HomeScreen(),
//         ),
//       ),
//     );
//   }
// }

