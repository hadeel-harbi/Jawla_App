import 'package:flutter/material.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/components/text_fields/text_field.dart';
import 'package:jawla_app/extensions/format.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/auth_screens/login_screen.dart';
import 'package:jawla_app/services/api/auth/signup_response.dart';

import '../../components/modal_bottom_sheets.dart/done_modal_bottom_sheet.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_signup/signup_page_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Create New Account Text
                Align(
                  alignment: Alignment.center,
                  child: Text("Create New Account",
                      style: headLineStyle1.copyWith(color: primaryColor)),
                ),
                height24,

                // Textfields
                CustomTextField(
                  hint: "Name",
                  iconName: Icons.person_outlined,
                  controller: nameController,
                ),
                height16,
                CustomTextField(
                  hint: "Email",
                  iconName: Icons.email_outlined,
                  controller: emailController,
                ),
                height16,
                CustomTextField(
                  hint: "Phone",
                  iconName: Icons.phone_iphone_outlined,
                  controller: phoneController,
                ),
                height16,
                CustomTextField(
                  hint: "Password",
                  iconName: Icons.lock_outline_rounded,
                  controller: passwordController,
                  isPassword: true,
                ),
                height16,
                CustomTextField(
                  hint: "Confirm password",
                  iconName: Icons.lock_outline_rounded,
                  controller: confirmPasswordController,
                  isPassword: true,
                ),
                height16,
                CustomButton(
                  text: "Create Account",
                  onPressed: () async {
                    // if all fields not empty
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      // if password matches confirm password
                      if (confirmPasswordController.text ==
                          passwordController.text) {
                        // if email is valid
                        if (emailController.text.isValidEmail) {
                          if (phoneController.text.isValidPhone) {
                            // ---------- loading ----------
                            showDialog(
                                context: context,
                                barrierColor: const Color.fromARGB(0, 0, 0, 0),
                                builder: (context) => const Center(
                                        child: CircularProgressIndicator(
                                      color: primaryColor,
                                    )));
                            // ---------- signup response ----------
                            final response = await signupResponse(body: {
                              "name": nameController.text,
                              "email": emailController.text,
                              "phone": phoneController.text,
                              "password": passwordController.text,
                              "is_owner": false
                            });

                            if (response.statusCode == 200) {
                              print(response.body);

                              openDoneSheet(context,
                                  "Your Account has been created successfully");
                              Future.delayed(const Duration(seconds: 2), () {
                                context.push(screen: const LoginScreen());
                              });
                            } else {
                              print(response.body);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Phone is not valid"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Email is not valid"),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password does not match"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter all fields"),
                        ),
                      );
                    }
                  },
                ),
                height24,

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: haveAccountStyle,
                    ),
                    InkWell(
                      onTap: () {
                        context.push(screen: const LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: haveAccountStyle.copyWith(color: primaryColor),
                      ),
                    ),
                  ],
                ),
                height96
              ],
            ),
          ),
        ),
      ),
    );
  }
}
