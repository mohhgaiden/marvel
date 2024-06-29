import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/res/colors.dart';
import '/widgets/load_image.dart';
import '../res/dimens.dart';
import '../res/gaps.dart';

class StateLayout extends StatelessWidget {
  
  const StateLayout({
    super.key,
    required this.type,
    this.hintText,
    this.fonction
  });
  
  final StateType type;
  final String? hintText;
  final void Function()? fonction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        type == StateType.loading
        ?const CupertinoActivityIndicator(radius: 16.0)
        :Opacity(
          opacity: 1,
          child: LoadAssetImage(
            'state/${type.img}.png',
            width: 120,
          )
        ),
        const SizedBox(width: double.infinity, height: Dimens.gap_dp16,),
        Text(
          hintText ?? type.hintText,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: Dimens.font_sp14),
        ),
        fonction == null
        ?const SizedBox()
        :Center(
          child: GestureDetector(
            onTap: fonction,
            child: Icon(Icons.sync,color: Colours.app_main)
          )
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  network,
  loading,
  empty
}

extension StateTypeExtension on StateType {
  String get img => <String>[
    'network', '', 'empty']
  [index];
  
  String get hintText => <String>[
    "No Internet Connection", 
    '', 
    'BookMarks is Empty'
  ][index];
}