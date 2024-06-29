import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marval/login/cubit/login/login_cubit.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';
import '../../../widgets/load_image.dart';

class ShowMenu extends StatefulWidget {
  const ShowMenu({super.key});

  @override
  ShowMenuState createState() => ShowMenuState();
}

class ShowMenuState extends State<ShowMenu> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: LoadAssetImage('home/jt.png', width: 8.0, height: 4.0,
            color: null
          ),
        ),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const LoadAssetImage('home/user2.png', width: 22, height: 22, color: null),
            label: const Align(alignment: Alignment.centerLeft,child: Text('Profile',style: TextStyles.textSize12)),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
              disabledForegroundColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.12),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
              ),
            ),
          ),
        ),
        Container(width: 120.0, height: 0.6, color: Colours.line),
        SizedBox(
          width: 120.0,
          height: 40.0,
          child: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              context.read<LoginCubit>().signOut();
            },
            icon: const LoadAssetImage('home/logout.png', width: 16, height: 16, color: null),
            label: const Align(alignment: Alignment.centerLeft,child: Text('Logout',style: TextStyles.textSize12)),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
              disabledForegroundColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.12),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: Alignment.topRight,
          child: child,
        );
      },
      child: body,
    );
  }

}
