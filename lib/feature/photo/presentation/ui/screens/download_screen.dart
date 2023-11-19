import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/service/StorageService.dart';
import '../../bloc/photos_bloc.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    context.read<PhotosBloc>().add(GetDownload());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        final bloc = context.read<PhotosBloc>();
        return SafeArea(
          child: Scaffold(
            body: bloc.downloadList.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: bloc.downloadList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) =>
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:bloc.downloadList[index],
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: 150,
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      bloc.downloadList.remove(bloc.downloadList[index]);
                                      StorageService.setFavorite(bloc.downloadList);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0xff1b4965),
                                  )),
                            ),
                          ],
                        ),
                      )),
            )
                : Center(
                child: Text(
                  "No photo yet",
                  style: TextStyle(
                      color: Color(0xff1b4965),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                )),
          ),
        );
      },
    );
  }
}
