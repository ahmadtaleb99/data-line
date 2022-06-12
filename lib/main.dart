import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/services/notification/NotificationsService.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:hive/hive.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'data/FormRepository.dart';
import 'data/FormRepository.dart';
import 'home_screen.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void initNotifications(){
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




Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  initNotifications();
 await  NotificationService().init();


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return RepositoryProvider(
      create: (context) => FormRepository() ,
      child: BlocProvider(
        create: (context) => ValidationBloc(context.read<FormRepository>())
                  ..add(ServiceRegistered())
                  ..add(FormsRequested()),

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}

