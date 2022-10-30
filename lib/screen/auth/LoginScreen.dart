import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .3,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                  defaultBorderRadius,
                ),
              ),
            ),
            child: const SafeArea(
              child: Center(
                child: ImageWidget(
                  image: bgAuth,
                  width: 250,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 50,
              bottom: 33,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              children: [
                TextWidget(
                  label: "Sign In",
                  color: primaryColor,
                  weight: 'bold',
                  type: 's1',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  label: "Please login to continue using our app",
                  color: fontSecondaryColor,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: InputWidget(
                    title: "hidden",
                    hintText: "E-mail",
                    controller: emailController,
                    iconLeft: const Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Icon(
                        Icons.mail,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: defaultMargin,
                  ),
                  child: InputWidget(
                    title: "hidden",
                    hintText: "Password",
                    controller: passwordController,
                    iconLeft: const Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 30,
                  ),
                  width: double.infinity,
                  child: TextWidget(
                    label: "Forget Password?",
                    color: fontSecondaryColor,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    label: "Sing In",
                    onPressed: () {},
                    upperCase: true,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Navigation.registerScreen,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 33,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    label: "Don't have an account? ",
                    color: fontSecondaryColor,
                    type: 'b2',
                  ),
                  TextWidget(
                    label: "Sign Up",
                    color: primaryColor,
                    weight: 'bold',
                    type: 'b2',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
