import 'dart:convert';
import 'dart:io';

import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jawla_app/components/buttons/button.dart';
import 'package:jawla_app/components/text_fields/text_field.dart';
import 'package:jawla_app/constants/app_styles.dart';
import 'package:jawla_app/constants/constants.dart';
import 'package:jawla_app/extensions/navigators.dart';

import '../../../components/general_components/text_label.dart';
import '../../../components/text_fields/number_text_field.dart';
import '../../../services/api/owner/add_image_response.dart';
import 'add_activity_second_screen.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});
  @override
  State<AddActivityScreen> createState() => AddActivityScreenState();
}

class AddActivityScreenState extends State<AddActivityScreen> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  int personNumbers = 1;
  File? image;

  Future pickImage() async {
    final theImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (theImage == null) return;
    final imageTemp = File(theImage.path);

    setState(() => image = imageTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Add Activity"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //---------------------text fields----------------------------

              label("Activity Title"),

              CustomTextField(hint: "title", controller: nameController),

              label("City"),

              CustomTextField(hint: "City", controller: cityController),

              label("Description"),

              CustomTextField(
                hint: "describe your activity",
                controller: descriptionController,
                minLines: 3,
                maxLines: 4,
              ),

              label("Upload activity image"),

              uploadImage(),

              label("price"),

              SizedBox(
                  width: 100,
                  child: NumberTextField(
                    hint: "price",
                    controller: priceController,
                  )),

              label("Number of Person"),

              CountStepper(
                // iconColor: primaryColor,
                defaultValue: 1,
                max: 50,
                min: 1,
                iconIncrementColor: secondaryColor,
                iconDecrementColor: secondaryColor,
                splashRadius: 25,
                textStyle: headLineStyle2,
                onPressed: (value) {
                  personNumbers = value;
                },
              ),

              height16,

              //------------------------Next Button-------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      text: "Next",
                      onPressed: () {
                        //print(imagePath);
                        final addActivityMap = {
                          "activity_name": nameController.text,
                          "activity_city": cityController.text,
                          "activity_price": priceController.text,
                          "activity_description": descriptionController.text,
                          "person_number": personNumbers,
                        };
                        context.push(
                            screen: AddActivitySecondScreen(
                          addActivityMap: addActivityMap,
                        ));
                        _addImage();
                      }),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  uploadImage() {
    return Container(
      height: 120,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: tertiaryColor),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              pickImage();
            },
            child: image != null
                ? Image.file(
                    // <-- image
                    File(image!.path),
                    fit: BoxFit.contain,
                  )
                : const Center(
                    child: Icon(
                    Icons.add,
                    color: tertiaryColor,
                    size: 45,
                  )),
          ),
        ],
      ),
    );
  }

  _addImage() async {
    try {
      final box = GetStorage();
      final response = await addImageResponse(File(image!.path.toString()));

      String imageUrlResponse = json.decode(response.body)['data'];
      box.write("imageUrl", imageUrlResponse);
    } catch (error) {
      return "$error";
    }
  }
}
