import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spotpro_customer/model/sp_model.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:spotpro_customer/screens/mainpage.dart';
import 'package:spotpro_customer/screens/home_screen.dart';
import 'package:spotpro_customer/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var descController = TextEditingController();
  var serviceController = TextEditingController();
  var rateController = TextEditingController();


 String imageUrl="";


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    locationController.dispose();
    descController.dispose();
    serviceController.dispose();
    rateController.dispose();
  }
  // final nameController = TextEditingController();
  // final locationController = TextEditingController();
  // final descController = TextEditingController();
  // final serviceController = TextEditingController();
  // final rateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:NetworkImage("data:image/png;base64,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"),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            textFeld(
                              hintText: "Full Name",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // email
                            textFeld(
                              hintText: "Location",
                              icon: Icons.location_on_sharp,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: locationController,
                            ),
                            textFeld(
                              hintText: "Job category",
                              icon: Icons.work,
                              inputType: TextInputType.text,
                              maxLines: 1,
                              controller: serviceController,
                            ),
                            textFeld(
                              hintText: "Job description",
                              icon: Icons.description_sharp,
                              inputType: TextInputType.text,
                              maxLines: 3,
                              controller: descController,
                            ),
                            textFeld(
                              hintText: "Rate per hour",
                              icon: Icons.description_sharp,
                              inputType: TextInputType.text,
                              maxLines: 3,
                              controller: rateController,
                            ),
                            Text("Upload your ID Proof"),
                            IconButton(onPressed:() async{
                              ImagePicker imagepicker=ImagePicker();
                              XFile? file=await imagepicker.pickImage(source: ImageSource.gallery);
                              if (file!=null)  {
                              Reference referenceRoot=FirebaseStorage.instance.ref();
                              Reference  referenceDirImages=referenceRoot.child("ID proofs");
                              Reference referenceImageToUpload=referenceDirImages.child('${file?.name}');
                              try{
                                await referenceImageToUpload.putFile(File(file!.path));
                               imageUrl=await referenceImageToUpload.getDownloadURL();
                               print(imageUrl);
                              }
                              catch(error){

                              }
                            }}, icon: Icon(Icons.file_upload_rounded))

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Register",
                          onPressed: () {
                            if (imageUrl.isEmpty) {
                              ScaffoldMessenger. of (context)
                            .showSnackBar (SnackBar (content: Text('Please upload your ID Proof')));
                            return;
                            }
                            else
                            storeData();}
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        autofocus: true,

        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(

          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      location: locationController.text.trim(),
      createdAt: "",
      phoneNumber: "",
      uid: "",
        url: imageUrl,
      service: serviceController.text,
      desc:descController.text,
      rate: rateController.text,
      review:["5"]
    );

      ap.saveUserDataToFirebase(


        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(title: 'title'),
                          ),
                          (route) => false),
                    ),
              );
        },
      );

  }
}
