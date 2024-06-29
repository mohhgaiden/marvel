import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marval/details/ui/page/details.dart';
import 'package:marval/res/colors.dart';
import 'package:marval/res/styles.dart';
import 'package:marval/widgets/state_layout.dart';
import '../database/bookmark_manager.dart';

class BookmarkPage extends StatelessWidget {
  final bookmarkManager = Get.find<BookMarkManager>();
  BookmarkPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: bookmarkManager.loadBookMarksFromDatabase(), 
      builder: (context, snapshot) => GetBuilder<BookMarkManager> (
       builder: (_) => bookmarkManager.bookMarks.isEmpty
        ?StateLayout(type: StateType.empty,hintText: 'BookMarks is Empty')
        :ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: bookmarkManager.bookMarks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow> [BoxShadow(color: Color(0x80DCE7FA), offset: Offset(0.0, 2.0), blurRadius: 8.0)] 
              ),
              width: double.infinity,
              height: 150,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: int.parse(bookmarkManager.bookMarks[index].id),name: bookmarkManager.bookMarks[index].name,image: bookmarkManager.bookMarks[index].image))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 0.6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: '${bookmarkManager.bookMarks[index].image}',
                            ),
                          ),
                        ),
                      ),
                      Flexible(child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          bookmarkManager.bookMarks[index].name,
                          softWrap: true,
                          style: TextStyles.text,
                        )
                      )),
                      IconButton(
                        onPressed: () {
                          var bookmark = bookmarkManager.bookMarks[index];
                          bookmarkManager.removeFromBookMarks(bookmark);
                          Get.snackbar(
                            bookmark.name,
                            'Removed from bookmark successfully!',
                            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                            duration: const Duration(milliseconds: 1300),
                            snackPosition: SnackPosition.BOTTOM
                          );
                        },
                        icon: const Icon(
                          Icons.bookmark_remove_rounded,
                          color: Colours.app_main,
                          semanticLabel: 'Remove',
                        ))
                      ],
                    ),
                  ),
                )
            );
          }
        )
      )
    );
  }
}