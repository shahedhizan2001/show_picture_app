import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:photo_app/feature/photo/infrastructure/data_source/model/photos.dart';
import 'package:photo_app/feature/photo/presentation/bloc/photos_bloc.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  static const _pageSize = 10;
  final PagingController<int, Photos> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getPhotos(pageKey, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1b4965),
        title: Text("Photos"),
        actions: [
          RPadding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              },
              icon: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (context, state) {
          final bloc = context.read<PhotosBloc>();
          return RPadding(
            padding: const EdgeInsets.all(8.0),
            child: PagedGridView<int, Photos>(
              showNewPageProgressIndicatorAsGridChild: false,
              showNewPageErrorIndicatorAsGridChild: true,
              showNoMoreItemsIndicatorAsGridChild: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Photos>(
                animateTransitions: true,
                itemBuilder: (context, photos, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: photos!.urls!.regular!,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: 145.h,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Row(
                          children: [
                            BlocBuilder<PhotosBloc, PhotosState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        bloc.add(DownloadPhotos(
                                            url: photos.urls!.regular!));
                                      },
                                      icon: Icon(
                                        Icons.download,
                                        color: Color(0xff1b4965),
                                      )),
                                );
                              },
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    bloc.add(Favorite(
                                        photoUrl: photos.urls!.regular!));
                                  },
                                  icon: bloc.favoriteList
                                          .contains(photos.urls!.regular!)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Color(0xff1b4965),
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: Color(0xff1b4965),
                                        )),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getPhotos(int page, BuildContext context) async {
    final _dio = Dio();
    try {
      final response = await _dio.get(
          "https://api.unsplash.com/photos/?client_id=15m_zdELDVazk0kEKXlH4wPd_hU4syxDq1Ta5Hg440M&&page=$page&&per_page=$_pageSize");
      if (context.mounted) {
        context.read<PhotosBloc>().add(GetFavourite());
        final newItems = photosFromJson(response.data);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = page + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
