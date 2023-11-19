import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_app/feature/photo/presentation/bloc/photos_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        final bloc= context.read<PhotosBloc>();
        return Scaffold(
          body:bloc.screens[bloc.value] ,
          bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              iconSize: 22.sp,
              currentIndex: bloc.value,
              onTap: (value) {
                bloc.add(GhangeIndex(index: value));
              },
              unselectedItemColor: Color(0xff1b4965),
              selectedItemColor: Color(0xff5fa8d3),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.download), label: "Download")
              ]),
        );
      },
    );
  }
}
