import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_table_app/routes/calender.dart';
import 'package:get_table_app/routes/email.dart';
import 'package:get_table_app/routes/files.dart';
import 'package:get_table_app/routes/tasks.dart';
import 'package:get_table_app/routes/videoconference.dart';
import 'package:provider/provider.dart';
import 'package:platform/platform.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get_storage/get_storage.dart';
import 'blocs/timeTableScrollerIndexes.dart';
import 'blocs/userBloc.dart';
import 'blocs/indexMainBloc.dart';
import 'blocs/absentsTableApiBloc.dart';
import 'blocs/timeTableItemsBlock.dart';
import 'services/apiManagerService.dart';
import 'routes/home.dart';
import 'routes/tableView.dart';
import 'routes/timeTable.dart';
import 'routes/settings.dart';

bool swipeDetector;

Future<void> setStorage() async {
  // TODO do this in an separate thread or on the system
  // TODO only set if get returns no error
  try {
    if (!kIsWeb) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await GetStorage.init();
        final box = GetStorage("Get_Table_App");
        box.write('SubjectsRaw', await ApiRoutes.fetchSubjectsRaw());
        box.write('TeachersRaw', await ApiRoutes.fetchTeachersRaw());
        box.write('DaysRaw', await ApiRoutes.fetchDaysRaw());
        box.write('TodayRaw', await ApiRoutes.fetchTomorrowTodayRaw("today"));
        box.write(
            'TomorrowRaw', await ApiRoutes.fetchTomorrowTodayRaw("tomorrow"));
      }
    } else {
      await GetStorage.init();
      final box = GetStorage("Get_Table_App");
      box.write('SubjectsRaw', await ApiRoutes.fetchSubjectsRaw());
      box.write('TeachersRaw', await ApiRoutes.fetchTeachersRaw());
      box.write('DaysRaw', await ApiRoutes.fetchDaysRaw());
      box.write('TodayRaw', await ApiRoutes.fetchTomorrowTodayRaw("today"));
      box.write(
          'TomorrowRaw', await ApiRoutes.fetchTomorrowTodayRaw("tomorrow"));
    }
  } on SocketException catch (_) {
    print('No Internet');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    swipeDetector = false;
  } else {
    LocalPlatform platform = LocalPlatform();
    swipeDetector = platform.isAndroid || platform.isIOS;
  }
  try {
    setStorage();
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Time Table App';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IndexMainBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => AbsentsTableApiBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeTableItemsBlock(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeTableScrollerIndexes(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          bottomAppBarColor: Colors.grey[900],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          backgroundColor: Colors.grey[850],
          bottomAppBarColor: Colors.grey[900],
        ),
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return PageTransition(
                child: HomeRoute(swipeDetector),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/tableView':
              return PageTransition(
                child: TableViewRoute(swipeDetector),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/timeTable':
              return PageTransition(
                child: TimeTableRoute(swipeDetector),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/settings':
              return PageTransition(
                child: SettingsRoute(swipeDetector),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/email':
              return PageTransition(
                child: EmailRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/files':
              return PageTransition(
                child: FilesRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/calender':
              return PageTransition(
                child: CalenderRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/tasks':
              return PageTransition(
                child: TasksRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/videoconference':
              return PageTransition(
                child: VideoconferenceRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
