import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_app/feature/photo/presentation/bloc/photos_bloc.dart';
import 'package:photo_app/feature/photo/presentation/ui/screens/search_photo.dart';
import 'common/helper/dependencies_injection.dart';
import 'common/service/StorageService.dart';
import 'feature/photo/presentation/ui/screens/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt.allReady();
  StorageService.init();
  runApp(BlocProvider(create: (context) => GetIt.I<PhotosBloc>(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          routes: {
            'search':(context) => SearchPhoto()
          },
            debugShowCheckedModeBanner: false, home: HomePage());
      },
    );
  }
}
