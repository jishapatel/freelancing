import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freelancing_task/Providers/programs_provider.dart';
import 'package:provider/provider.dart';

import 'Providers/lessons_provider.dart';
import 'Screens/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProgramsProvider()),
        ChangeNotifierProvider(create: (context) => LessonsProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(446, 960),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          home: const NavigationScreen(),
        ),
      ),
    );
  }
}
