import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/photos_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        final bloc = context.read<PhotosBloc>();
        return Scaffold(
          body: bloc.favoriteList.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(3.0),
                child: GridView.builder(
                    itemCount: bloc.favoriteList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl:bloc.favoriteList[index],
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                                height: 150.h,
                              ),
                              IconButton(
                                  onPressed: () {
                                    bloc.add(Favorite(
                                        photoUrl: bloc.favoriteList[index]));
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Color(0xff1b4965),
                                  ))
                            ],
                          ),
                        )),
              )
              : Center(
              child: Text(
                "No element",
                style: TextStyle(
                    color: Color(0xff1b4965),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              )),
        );
      },
    );
  }
}
