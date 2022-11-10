import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(),
      hpController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
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
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                children: [
                  TextWidget(
                    label: "Sign Up",
                    color: primaryColor,
                    weight: 'bold',
                    type: 's1',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    label: "Please fill the detail and create account",
                    color: fontSecondaryColor,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "hidden",
                      hintText: "Name",
                      controller: nameController,
                      iconLeft: Icons.account_circle_outlined,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "hidden",
                      hintText: "No Hp",
                      controller: hpController,
                      iconLeft: Icons.phone_android_rounded,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "hidden",
                      hintText: "E-mail",
                      controller: emailController,
                      iconLeft: Icons.mail,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "hidden",
                      hintText: "Alamat",
                      controller: addressController,
                      iconLeft: Icons.location_on_outlined,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                      bottom: 20,
                    ),
                    child: InputWidget(
                      title: "hidden",
                      hintText: "Password",
                      controller: passwordController,
                      iconLeft: Icons.lock,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      label: "Sing Up",
                      onPressed: () {},
                      upperCase: true,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Navigation.loginScreen,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 33,
                  top: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "Already have an account? ",
                      color: fontSecondaryColor,
                      type: 'b2',
                    ),
                    TextWidget(
                      label: "Sign In",
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
      ),
    );
  }
}
