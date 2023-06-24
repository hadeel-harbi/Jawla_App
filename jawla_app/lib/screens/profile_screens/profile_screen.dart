import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/auth_screens/login_screen.dart';

import '../../constants/app_styles.dart';
import '../../models/user_model.dart';
import '../owner_screens/owner_activities_screens.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    User user = User();
    if (box.hasData("user")) {
      Map userMap = box.read("user");
      user = User.fromJson(json: userMap);
    }

    var divider = Divider(
      height: 50,
      color: Colors.grey.shade300,
      thickness: 1,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          // ------------------ edit profile button
          InkWell(
              onTap: () {
                context.push(screen: const EditProfileScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  FontAwesomeIcons.solidPenToSquare,
                ),
              )),
        ],
        backgroundColor: Colors.transparent,
        leading: width16,
        elevation: 0.0,
      ),
      backgroundColor: primaryColor,
      //---------------- activities management button
      floatingActionButton: _floatingActionButton(context),
      // ------------------ body
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height112,
                  profileDetailRow("Name", user.name),
                  divider,
                  profileDetailRow("Email", user.email),
                  divider,
                  profileDetailRow("Phone", user.phone),
                  divider,
                  profileDetailRow("City", user.city),
                  divider,
                  InkWell(
                    onTap: () {
                      box.remove("token");
                      box.remove("favorite");
                      box.remove("user");
                      context.push(screen: const LoginScreen());
                    },
                    child: Text(
                      "Log out",
                      style: headLineStyle2.copyWith(color: primaryColor),
                    ),
                  )
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
        ],
      ),
    );
  }

  Row profileDetailRow(String label, final detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$label : ',
          style: headLineStyle2,
        ),
        Text(
          detail ?? '',
          style: profileDetailsStyle,
        ),
      ],
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return Visibility(
      visible: box.read("is_owner"),
      child: FloatingActionButton(
        onPressed: () {
          context.push(screen: OwnerActivitiesScreen());
        },
        elevation: 0,
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.format_list_bulleted_rounded,
          size: 30,
        ),
      ),
    );
  }
}
