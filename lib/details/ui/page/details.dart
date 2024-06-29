import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:marval/details/cubit/comics/comics_cubit.dart';
import 'package:marval/details/cubit/series/series_cubit.dart';
import 'package:marval/details/ui/page/comics.dart';
import 'package:marval/details/ui/page/series.dart';
import 'package:marval/bookmark/model/bookmark.dart';
import 'package:marval/res/colors.dart';
import 'package:marval/res/gaps.dart';
import 'package:marval/res/styles.dart';
import 'package:marval/widgets/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bookmark/database/bookmark_manager.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key,required this.id,required this.name,required this.image});
  final int id;
  final String name,image;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController? tabController;
  final PageController pageController = PageController();
  final BookMarkManager bookMarkManager = Get.find();
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    print(bookMarkManager.bookMarks);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void onBookmarkButtonPressed(Bookmark bookmark) {
    if (bookMarkManager.ids.contains(bookmark.id.toString())) {
      bookMarkManager.removeFromBookMarks(bookmark);
      Get.snackbar(
        bookmark.name,
        'Removed from bookmark successfully!',
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        duration: const Duration(milliseconds: 1300),
        snackPosition: SnackPosition.BOTTOM
      );
    } else {
      bookMarkManager.addToBookMarks(bookmark);
      Get.snackbar(
        bookmark.name,
        'Added to bookmark successfully!',
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        duration: const Duration(milliseconds: 1300),
        snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ComicsCubit>(create: (context) => ComicsCubit()),
        BlocProvider<SeriesCubit>(create: (context) => SeriesCubit())
      ],
      child: GetBuilder<BookMarkManager>(builder: (_) => 
        Scaffold(
          appBar: MyAppBar(
            title: widget.name.toString().split('(')[0],
            actionName: bookMarkManager.ids.contains(widget.id.toString()) 
              ?Icons.bookmark_remove 
              :Icons.bookmark_add,
            iconColor: bookMarkManager.ids.contains(widget.id.toString()) ?Colours.app_main :null,
            onPressed: () => onBookmarkButtonPressed(Bookmark(widget.id.toString(),widget.name,widget.image))
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(widget.image),
                  ),
                  Gaps.hGap8,
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,style: TextStyles.textBold16),
                      Text(widget.id.toString(),style: TextStyles.text),
                      GestureDetector(
                        onTap: () async{ await launchUrl(Uri.parse("https://marvel.fandom.com/wiki/${widget.name.toString().replaceAll(RegExp(r' '), '_')}"));},
                        child: Text(
                          'marvel.fandom.com/wiki/${widget.name.toString().replaceAll(RegExp(r' '), '_')}',
                          style: TextStyles.textSize12.copyWith(
                            color: Colours.dark_app_main,
                            decoration: TextDecoration.underline
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                    ]
                  ))
                ])
              ),
              Gaps.vGap8,
              Container(
                color: Colors.white,
                child: TabBar(
                  onTap: (index) {pageController.jumpToPage(index);},
                  isScrollable: true,
                  controller: tabController,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  tabAlignment: TabAlignment.start,
                  labelStyle: TextStyles.textSize16,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: Colours.app_main,
                  labelColor: Colours.app_main,
                  indicatorWeight: 2,
                  indicatorPadding: EdgeInsets.only(right: 30),
                  tabs: [
                    Container(height: 30,padding: EdgeInsets.only(right: 30),child: Center(child: Text('comics'))),
                    Container(height: 30,padding: EdgeInsets.only(right: 30),child: Center(child: Text('series'))),
                    Container(height: 30,padding: EdgeInsets.only(right: 30),child: Center(child: Text('stories')))
                  ]
                )
              ),
              Gaps.vGap8,
              Expanded(child: PageView.builder(
                itemCount: 3,
                onPageChanged: (index) => tabController?.animateTo(index),
                controller: pageController,
                itemBuilder: (_, int index) {
                  return index==2
                  ?Center(child: Text('Coming Soon..'))
                  :index==0
                  ?ComicsPage(id: widget.id)
                  :SeriesPage(id: widget.id);
                }
              ))
            ]
          )
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
