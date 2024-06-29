import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:marval/login/cubit/register/register_cubit.dart';
import 'package:marval/widgets/my_scroll_view.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../../../util/change_notifier_manage.dart';
import '../../../widgets/load_image.dart';
import '../../../widgets/my_button.dart';
import '../widget/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with ChangeNotifierMixin<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nodeText1 = FocusNode();
  final FocusNode nodeText2 = FocusNode();
  final FocusNode nodeText3 = FocusNode();
  bool clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      nameController: callbacks,
      emailController: callbacks,
      passwordController: callbacks,
      nodeText1: null,
      nodeText2: null,
      nodeText3: null,
    };
  }

  bool progress=false;

  void verify() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    bool _clickable = true;
    if (name.isEmpty || name.length < 3) {
      _clickable = false;
    }
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
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state.status.isFailure){
          setState(() {progress=false;});
          Get.snackbar(
            'SignUp Failed',
            state.exceptionError,
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            duration: const Duration(milliseconds: 3000),
            snackPosition: SnackPosition.BOTTOM
          );
        }else if(state.status.isSuccess){
          setState(() {progress=false;});
          Navigator.pop(context);
        }else if(state.status.isInProgress) {
          setState(() {progress=true;});
        }
        nameController.clear();
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
              keyboardConfig: getKeyboardActionsConfig(context, [nodeText1, nodeText2, nodeText3]),
              crossAxisAlignment: CrossAxisAlignment.center,
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              children: _buildBody(),
            ))
          ),
        )
      )
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Center(child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: LoadAssetImage('marvel2.png')
      )),
      Text(
        "Open your account",
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        key: const Key('name'),
        focusNode: nodeText1,
        controller: nameController,
        maxLength: 11,
        keyboardType: TextInputType.name,
        hintText: "Username",
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('email'),
        focusNode: nodeText2,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        maxLength: 26,
        hintText: "Email",
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('password'),
        keyName: 'password',
        focusNode: nodeText3,
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
        key: const Key('register'),
        backgroundColor: clickable ?Colours.app_main :Colours.app_main.withAlpha(140),
        onPressed: () => clickable ?context.read<RegisterCubit>().signUpWithCredentials(emailController.text,passwordController.text) :null,
        text: "Register",
      ),
      Gaps.vGap8,
      Container(
        alignment: Alignment.center,
        child: GestureDetector(
          child: Text(
            "Already have account? ",
            key: const Key('noAccountRegister'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onTap: () => Navigator.pop(context),
        )
      )
    ];
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      actions: List.generate(list.length, (i) => KeyboardActionsItem(
        focusNode: list[i],
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text('Close'),
              )
            );
          }
        ]       
      ))
    );
  }
}
