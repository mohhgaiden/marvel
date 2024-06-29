import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:marval/bookmark/page/bookmark.dart';
import 'package:marval/home/ui/page/home.dart';
import 'package:marval/login/cubit/login/login_cubit.dart';
import '../../../res/dimens.dart';
import '../../../widgets/load_image.dart';
import '../../../widgets/popup_window.dart';
import '../widget/menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0.obs;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;
  final GlobalKey menuKey = GlobalKey();

  final List<Widget> _pages = [
    const HomePage(),
    BookmarkPage()
  ];

  void showMenu() {
    final RenderBox button = menuKey.currentContext!.findRenderObject()! as RenderBox;
    showPopupWindow<void>(
      context: context,
      isShowBg: true,
      offset: Offset(button.size.width - 8.0, -12.0),
      anchor: button,
      child: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: const ShowMenu(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: const Row(children: [
            SizedBox(width: 14),
            SizedBox(height: 24, width: 24, child: LoadAssetImage('shield.png')),
            SizedBox(width: 4),
            Text(
              'MARVEL',
              style: TextStyle(color: Colors.black,fontSize: Dimens.font_sp16)
            )
          ]),
          actions: [
            IconButton(
              tooltip: 'Settings',
              key: menuKey,
              onPressed: showMenu,
              icon: const LoadAssetImage(
                'home/setting.png',
                key: Key('add'), 
                width: 24.0, 
                height: 24.0, 
                color: null
              )
            )
          ]
        ),
        body: Obx(
          () => IndexedStack(
            index: currentIndex.value,
            children: _pages,
          ),
        ),
        
        bottomNavigationBar: Obx(
          () => NavigationBar(
          labelBehavior: labelBehavior,
          selectedIndex: currentIndex.value,
          height: 70,
          elevation: 2,
          onDestinationSelected: (int index) {
            currentIndex.value = index;
          },
          destinations: <Widget>[
            NavigationDestination(
              tooltip: "",
              icon: Icon(currentIndex.value == 0
                ? Icons.home_filled
                : Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              tooltip: "",
              icon: Icon(currentIndex.value == 1
                ? Icons.bookmark
                : Icons.bookmark_outline),
              label: 'BookMarks',
            ),
          ],
        )),
      ),
    );
  }
}