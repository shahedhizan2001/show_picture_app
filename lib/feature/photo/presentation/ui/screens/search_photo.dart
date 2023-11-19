import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../common/service/StorageService.dart';
import '../../../infrastructure/data_source/model_search/search_model.dart';
import '../../bloc/photos_bloc.dart';

class SearchPhoto extends StatefulWidget {
  SearchPhoto({Key? key}) : super(key: key);

  @override
  State<SearchPhoto> createState() => _SearchPhotoState();
}

class _SearchPhotoState extends State<SearchPhoto> {
  final searchController = TextEditingController();
  static const _pageSize = 10;
  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    searchController.addListener(() async {
      /// add debounce
      await Future.delayed(Duration(seconds: 2));
      _pagingController.refresh();
    });
    _pagingController.addPageRequestListener((pageKey) {
      searchPhoto(query: searchController.text, page: pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1b4965),
        ),
        body: BlocBuilder<PhotosBloc, PhotosState>(
          builder: (context, state) {
            final bloc = context.read<PhotosBloc>();
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      final searchQuery = searchController.text;
                      if (searchQuery.isNotEmpty) {
                        setState(() {
                          _pagingController.refresh();
                        });
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                      enabled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Color(0xff5fa8d3)),
                      ),
                    ),
                  ),
                  BlocBuilder<PhotosBloc, PhotosState>(
                    builder: (context, state) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PagedGridView<int, Result>(
                            showNewPageProgressIndicatorAsGridChild: false,
                            showNewPageErrorIndicatorAsGridChild: false,
                            showNoMoreItemsIndicatorAsGridChild: false,
                            pagingController: _pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Result>(
                              itemBuilder: (context, search, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: search.urls!.regular!,
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        height: 135.h,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  bloc.downloadList.add(
                                                      search.urls!.regular!);
                                                  StorageService
                                                      .setDownloadPhotos(
                                                          bloc.downloadList);
                                                  bloc.add(DownloadPhotos(
                                                      url: search
                                                          .urls!.regular!));
                                                },
                                                icon: Icon(
                                                  Icons.download,
                                                  color: Color(0xff1b4965),
                                                )),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  bloc.add(Favorite(
                                                      photoUrl: search
                                                          .urls!.regular!));
                                                },
                                                icon: bloc.favoriteList
                                                        .contains(search
                                                            .urls!.regular!)
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color:
                                                            Color(0xff1b4965),
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        color:
                                                            Color(0xff1b4965),
                                                      )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> searchPhoto({required String query, required int page}) async {
    final _dio = Dio();

    try {
      final response = await _dio.get(
          "https://api.unsplash.com/search/photos/?client_id=15m_zdELDVazk0kEKXlH4wPd_hU4syxDq1Ta5Hg440M&page=$page&query=$query");
      if (context.mounted) {
        context.read<PhotosBloc>().add(GetFavourite());
        Search search = Search.fromJson(response.data);
        final isLastPage = search.results!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(search.results ?? []);
        } else {
          final nextPageKey = page + search.results!.length;
          _pagingController.appendPage(search.results!, nextPageKey);
        }
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
