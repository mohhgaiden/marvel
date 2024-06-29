import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:marval/login/cubit/login/login_cubit.dart';
import 'package:marval/login/cubit/register/register_cubit.dart';
import 'package:marval/login/ui/page/register.dart';
import 'package:marval/res/colors.dart';
import '../../../res/gaps.dart';
import '../../../util/change_notifier_manage.dart';
import '../../../widgets/load_image.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_scroll_view.dart';
import '../widget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode nodeText1 = FocusNode();
  final FocusNode nodeText2 = FocusNode();
  bool clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      emailController: callbacks,
      passwordController: callbacks,
      nodeText1: null,
      nodeText2: null,
    };
  }

  bool progress=false;

  void verify() {
    final String email = emailController.text;
    final String password = passwordController.text;
    bool _clickable = true;
    if (email.isEmpty || email.length < 6) {
      _clickable = false;
    }
    if (password.isEmpty || password.length < 5) {
      _clickable = false;
    }
    if (_clickable != clickable) {
      setState(() {
        clickable = _clickable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isFailure){
          setState(() {progress=false;});
          Get.snackbar(
            'Login Failed',
            state.exceptionError,
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            duration: const Duration(milliseconds: 3000),
            snackPosition: SnackPosition.BOTTOM
          );
        }else if(state.status.isSuccess) {
          setState(() {progress=false;});
        }else if(state.status.isInProgress) {
          setState(() {progress=true;});
        }
        passwordController.clear();
        emailController.clear();
      },
      builder: (context, state) => Scaffold(
        body: PopScope(
          canPop: false,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login/auth-bg.png'),
                fit: BoxFit.cover
              )
            ),
            child: Center(child: MyScrollView(
              keyboardConfig: getKeyboardActionsConfig(context, <FocusNode>[nodeText1, nodeText2]),
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              children: _buildBody,
            ))
          ),
        )
      )
    );
  }

  List<Widget> get _buildBody => <Widget>[
    Center(child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: LoadAssetImage('marvel.png')
    )),
    Gaps.vGap16,
    MyTextField(
      key: const Key('email'),
      focusNode: nodeText1,
      controller: emailController,
      maxLength: 26,
      keyboardType: TextInputType.emailAddress,
      hintText: "Email",
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('password'),
      keyName: 'password',
      focusNode: nodeText2,
      isInputPwd: true,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      hintText: "Password",
    ),
    Gaps.vGap24,
    progress
    ?MyButton(
      onPressed: () => null,
      progress: true,
    )
    :MyButton(
      key: const Key('login'),
      backgroundColor: Colours.app_main,
      onPressed: clickable ?() => context.read<LoginCubit>().logInWithCredentials(emailController.text, passwordController.text):null,
      text: 'Login'
    ),
    Gaps.vGap8,
    Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Text(
          "No account yet? Register now",
          key: const Key('noAccountRegister'),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onTap: () {
          nodeText1.unfocus();
          nodeText2.unfocus();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => BlocProvider<RegisterCubit>(
              create: (context) => RegisterCubit(),
              child: RegisterPage(),
            )
          ));
        }
      )
    )
  ];

  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      actions: List.generate(list.length,(i) => KeyboardActionsItem(
        focusNode: list[i],
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text('Close')
              )
            );
          }
        ]
      ))
    );
  }
}
