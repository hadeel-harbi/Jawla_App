import 'package:flutter/material.dart';
import 'package:jawla_app/components/snack_bar/snack_bar.dart';
import 'package:jawla_app/extensions/navigators.dart';
import 'package:jawla_app/screens/owner_screens/add_activity/add_activity_screen.dart';

import '../../constants/constants.dart';
import '../../services/api/user/profile/upgrade_to_owner_response.dart';
import '../buttons/button.dart';
import '../text_fields/text_field.dart';

class UpgradeToOwner extends StatelessWidget {
  UpgradeToOwner({super.key});

  final TextEditingController licenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 244, 244),
          borderRadius: BorderRadius.circular(20)),
      height: 600,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height32,
            const Text(
              "Register",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            height24,
            const Text(
              "To be able to add activites, add your Business License to register.",
              style: TextStyle(fontSize: 16),
            ),
            height48,
            CustomTextField(
                hint: "Business License",
                iconName: Icons.credit_card,
                controller: licenseController),
            height112,
            Center(
              child: CustomButton(
                text: "Register",
                onPressed: () async {
                  // --------- upgrade to owner response
                  final response = await upgradeToOwnerResponse(
                      body: {"business_license": licenseController.text});
                  if (response.statusCode == 200) {
                    print(response.body);
                    box.write("is_owner", true);

                    Navigator.pop(context);
                    context.push(screen: const AddActivityScreen());
                    // opensheet(context, view)
                  } else {
                    snackBar(context, "Error");
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
