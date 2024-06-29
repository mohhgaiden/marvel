import 'package:flutter/material.dart';
import 'package:marval/res/styles.dart';

class TabsWidget extends StatelessWidget {
  
  const TabsWidget(this.tabName, this.index);
  
  final String tabName;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Tab(child: SizedBox(
      width: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(tabName),
          Visibility(
            visible: true,
            child: Text(' (count)',style: TextStyles.textSize12)
          ),
        ]
      )
    ));
  }
}