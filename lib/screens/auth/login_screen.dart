import 'package:flutter/material.dart';
import 'package:flutter_social/resources/auth_methods.dart';
import 'package:flutter_social/responsive/mobile_screen_layout.dart';
import 'package:flutter_social/responsive/responsive_layout.dart';
import 'package:flutter_social/responsive/web_screen_layout.dart';
import 'package:flutter_social/screens/auth/signup_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:flutter_social/widgets/forms/text_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    } else {
      showSnackbar(context, res);
    }
  }

  void showSignupScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                SvgPicture.asset('assets/ic_instagram.svg',
                    color: primaryColor, height: 64),
                const SizedBox(height: 64),
                TextFieldInput(
                  hintText: 'Enter your email',
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Password',
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: login,
                  child: Container(
                      child: _isLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.0),
                            )
                          : const Text('Login'),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          color: blueColor)),
                ),
                const SizedBox(height: 12),
                Flexible(child: Container(), flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Don\'t have an account?'),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: showSignupScreen,
                      child: Container(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12)
              ],
            )),
      )),
    );
  }
}
