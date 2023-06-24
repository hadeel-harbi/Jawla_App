import 'package:flutter/material.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/components/general_components/text_label.dart';
import 'package:jawla_app/components/text_fields/text_field.dart';
import 'package:jawla_app/constants/app_styles.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';

import '../../components/general_components/show_dialog.dart';
import '../../components/modal_bottom_sheets.dart/done_modal_bottom_sheet.dart';
import '../../components/snack_bar/snack_bar.dart';
import '../../services/api/user/reservation/add_reservation_response.dart';
import 'my_navigation_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key, required this.price, required this.activityId});

  final String price;
  final int activityId;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final cardNumberController = TextEditingController();
  final holderNameController = TextEditingController();
  final expDateController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: headLineStyle1.copyWith(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height48,
            const Text(
              "Card Details",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            height16,
            Row(
              children: [
                Image.asset(
                  "assets/images/mada.jpg",
                  width: 70,
                ),
                Image.asset(
                  "assets/images/visa.jpg",
                  width: 70,
                ),
                Image.asset(
                  "assets/images/mastercardLogo.jpeg",
                  width: 50,
                ),
              ],
            ),
            label("Card Holder Name"),
            CustomTextField(
                hint: "Name",
                controller: holderNameController,
                iconName: Icons.person),
            label("Card Number"),
            height8,
            CustomTextField(
                hint: "Card Number",
                controller: cardNumberController,
                iconName: Icons.payment),
            height8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("Expiry Date"),
                    SizedBox(
                        width: 180,
                        child: CustomTextField(
                          hint: "Expiry Date",
                          controller: expDateController,
                          iconName: Icons.date_range_outlined,
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("CVV"),
                    SizedBox(
                        width: 120,
                        child: CustomTextField(
                          hint: "CVV",
                          controller: cvvController,
                          iconName: Icons.lock_outline,
                        )),
                  ],
                ),
              ],
            ),
            height56,
            height48,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total",
                    style: headLineStyle2.copyWith(color: greyTextColor)),
                width8,
                Text("${widget.price} SR",
                    style: headLineStyle1.copyWith(fontSize: 30)),
              ],
            ),
            height32,
            Center(
                child: CustomButton(
                    text: "Pay",
                    onPressed: () async {
                      showDialogFunc(context);
                      final response =
                          await addReservationResponse(widget.activityId);

                      if (response.statusCode == 200) {
                        print(response.body);

                        openDoneSheet(
                            context, "Payment completed successfully");

                        Future.delayed(const Duration(seconds: 2), () {
                          context.push(
                              screen: const MyNavigationBar(
                            screenIndex: 0,
                          ));
                        });
                      } else {
                        snackBar(context, "Sorry, try again");
                        Future.delayed(const Duration(seconds: 2), () {
                          context.push(
                              screen: const MyNavigationBar(
                            screenIndex: 0,
                          ));
                        });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
