import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class ItemsWidget extends StatelessWidget {

  const ItemsWidget({
    required this.title,
    required this.image,
    required this.desc,
    required this.heroTag,
    required this.index,
    required this.index2,
    required this.index3,
    this.onpress
  });
  final String image,title,desc,heroTag;
  final int index, index2, index3;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border(bottom: Divider.createBorderSide(context, width: 0.8))),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: image, 
                    width: 72, 
                    height: index3==0 ?96 :72,
                    fit: BoxFit.fill
                  ),
                )
              ),
              Gaps.hGap8,
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.textBold14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.vGap4,
                  GestureDetector(
                    onTap: desc!=''? onpress :null,
                    child: Text(
                      desc!='' ?desc :'N/A',
                      style: TextStyles.textSize12,
                      maxLines: index2==index ?null : index3==0 ?3 :2,
                      overflow: index2==index ?null :TextOverflow.ellipsis
                    )
                  )
                ]
              ))
            ]
          )
        )
      )
    );
  }
}