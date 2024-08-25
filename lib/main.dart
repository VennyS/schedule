import 'package:calendar_gymatech/cubit/schedule_cubit.dart';
import 'package:calendar_gymatech/pages/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/gto_page.dart';
import 'package:widgets/api/api_service.dart';
import 'package:widgets/api/config.dart';

// Для тестов.
// import 'package:schedule/api_service.dart';
// import 'package:widgets/models/list_item.dart';
// import 'package:widgets/models/spots.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU');
  await Config.load();
  ApiService.setBaseUrl(Config.baseUrl);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScheduleCubit()..loadSchedule(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home: GtoPage(
        //     item: ListItem(
        //         gtoId: 7,
        //         dayOfWeek: "Monday",
        //         date: "2024-08-19T00:00:00",
        //         timeStart: "12:00",
        //         name: "Качалка",
        //         coachName: "Александр Петров",
        //         trainerPhotoUrl: "",
        //         duration: 55,
        //         status: true,
        //         spots: Spots(
        //             maxSpots: 33,
        //             currentSpots: 0,
        //             confirmed: 0,
        //             canceled: 0,
        //             missed: 0,
        //             notConfirmed: 0,
        //             waitingList: 0))));
        home: CalendarPage(gtoPageBuilder: (item) => GtoPage(item: item)));
  }
}
