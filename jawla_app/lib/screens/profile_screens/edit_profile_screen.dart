import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/components/snack_bar/snack_bar.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/format.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/main_screens/my_navigation_bar.dart';
import 'package:jawla_app/services/api/user/profile/edit_profile_response.dart';

import '../../components/buttons/button.dart';
import '../../components/modal_bottom_sheets.dart/done_modal_bottom_sheet.dart';
import '../../components/text_fields/text_field.dart';
import '../../constants/app_styles.dart';
import '../../models/user_model.dart';
import '../../services/api/user/profile/user_response.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final box = GetStorage();

  User user = User();
  @override
  void initState() {
    super.initState();

    if (box.hasData("user")) {
      Map userMap = box.read("user");
      user = User.fromJson(json: userMap);
    }
    nameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    phoneController.text = user.phone ?? '';
    cityController.text = user.city ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      //----------------------------
      backgroundColor: primaryColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 56),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height96,
                  height24,
                  label("Name"),
                  height8,
                  CustomTextField(
                    hint: "your name",
                    iconName: Icons.person,
                    isPassword: false,
                    controller: nameController,
                  ),
                  height8,
                  label("Email"),
                  height8,
                  CustomTextField(
                    hint: "aabb@gmail.com",
                    iconName: Icons.lock_outline_rounded,
                    isPassword: false,
                    controller: emailController,
                  ),
                  height8,
                  label("Phone"),
                  height8,
                  CustomTextField(
                    hint: "05xxxxxxxx",
                    iconName: Icons.phone,
                    isPassword: false,
                    controller: phoneController,
                  ),
                  height8,
                  label("City"),
                  height8,
                  CustomTextField(
                    hint: "Riyadh",
                    iconName: Icons.location_city,
                    isPassword: false,
                    controller: cityController,
                  ),
                  height56,
                  Center(
                    child: CustomButton(
                      text: "Save",
                      onPressed: () async {
                        // -------------- edit profile Response
                        try {
                          if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              cityController.text.isNotEmpty) {
                            if (emailController.text.isValidEmail &&
                                phoneController.text.isValidPhone) {
                              final response = await editProfileResponse(body: {
                                "name": nameController.text,
                                "email": emailController.text,
                                "phone": phoneController.text,
                                "city": cityController.text,
                              });
                              print(response.body);
                              if (response.statusCode == 200) {
                                getUser();
                                if (!mounted) return;
                                openDoneSheet(context,
                                    "Your profile has been updated successfully");
                                Future.delayed(const Duration(seconds: 2), () {
                                  context.push(
                                      screen: const MyNavigationBar(
                                    screenIndex: 3,
                                  ));
                                });
                              } else {
                                if (!mounted) return;
                                snackBar(context,
                                    "Sorry, can't updated your profile");
                              }
                            } else {
                              snackBar(context, "Email OR phone are not valid");
                            }
                          } else {
                            snackBar(context, "Please enter all fields");
                          }
                        } catch (error) {
                          print(error);
                          snackBar(context, "Error");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          //profile image
          Positioned(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 65,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(user.profilePic ??
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
              ),
            ),
          ),
          const Positioned(
              right: 145,
              top: 100,
              child: CircleAvatar(
                  radius: 16,
                  backgroundColor: secondaryColor,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  )))
        ],
      ),
    );
  }

  Padding label(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Text(
        '$label : ',
        style: headLineStyle2,
      ),
    );
  }

  getUser() async {
    final responseUser = await userResponse();
    if (responseUser.statusCode == 200) {
      User user = User.fromJson(json: json.decode(responseUser.body)["data"]);

      box.write("user", user.toMap());
      box.write("is_owner", json.decode(responseUser.body)["data"]["is_owner"]);
    } else {
      print("------- ${responseUser.body}");
    }
  }
}
