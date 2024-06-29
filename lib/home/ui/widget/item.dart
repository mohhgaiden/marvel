import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marval/res/colors.dart';
import 'package:marval/res/gaps.dart';
import 'package:marval/res/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'info.dart';

class ItemWidget extends StatelessWidget {
  
  ItemWidget({
    required this.id,
    required this.name,
    required this.image,
    required this.date,
    required this.desc,
    required this.index,
    required this.index2,
    required this.onpress
  });
  
  final int id;
  final String name,image,date,desc;
  final int index, index2;
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
              ExcludeSemantics(child: Hero(
                tag: '',
                child: CachedNetworkImage(
                  imageUrl: image, 
                  width: 72.0, 
                  height: 72.0
                ),
              )),
              Gaps.hGap8,
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: () async{ await launchUrl(Uri.parse("https://www.marvel.fandom.com/wiki/${name.toString().replaceAll(RegExp(r' '), '_')}"));},
                    child: Text(
                      'marvel.fandom.com/wiki/${name.toString().replaceAll(RegExp(r' '), '_')}',
                      style: TextStyles.textSize12.copyWith(
                        color: Colours.dark_app_main,
                        decoration: TextDecoration.underline
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gaps.vGap4,
                  Row(children: [
                    Visibility(
                      visible: id.toString() != '',
                      child: InfoWidget(
                        text: '' + id.toString(),
                        color: Theme.of(context).colorScheme.error,
                        icon: Icons.perm_identity_sharp,
                      )
                    ),
                    Opacity(
                      opacity: date == '' ? 0.0 : 1.0,
                      child: InfoWidget(
                        text: ' ' + date.toString().substring(0,16).replaceAll('T', ' '),
                        color: Theme.of(context).primaryColor,
                        icon: Icons.date_range,
                      )
                    )
                  ]),
                  Gaps.vGap4,
                  GestureDetector(
                    onTap: desc!=''? onpress :null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(
                          desc!='' ?desc :'N/A',
                          maxLines: index2==index ?null :1,
                          style: TextStyles.textSize12
                        )),
                        desc!=''?
                        Icon(index2==index?Icons.arrow_drop_up_outlined:Icons.arrow_drop_down_outlined)
                        : SizedBox()
                      ]
                    ),
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