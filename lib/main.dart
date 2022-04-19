import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/FormService/NotificationsService.dart';
import 'package:form_builder_test/logic/NotificationManager.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'FormService/FormRepository.dart';
import 'home_screen.dart';
import 'package:form_builder_test/logic/NotificationManager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void initNotifications(){
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
      debug: true
  );
}




Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  initNotifications();
 await  NotificationService().init();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return RepositoryProvider(
      create: (context) => FormRepository() ..initLocal(),
      child: BlocProvider(
        create: (context) => ValidationBloc(context.read<FormRepository>())
                  ..add(FormsRequested()),

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}

