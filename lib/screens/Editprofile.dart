import 'dart:io';
import 'package:spotpro_customer/screens/sp_profile.dart';
import 'package:flutter/material.dart';
import 'package:spotpro_customer/model/sp_model.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:spotpro_customer/screens/mainpage.dart';
import 'package:spotpro_customer/screens/home_screen.dart';
import 'package:spotpro_customer/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  File? image;
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();
  final serviceController = TextEditingController();
  final rateController = TextEditingController();





  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    locationController.dispose();
    descController.dispose();
    serviceController.dispose();
    rateController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Edit profile"),backgroundColor: Colors.deepPurple),

      body:
        SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 15),
                margin: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Full Name"),
                      textFeld(
                        hintText: ap.userModel.name,
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: nameController,
                      ),

                      Text("Location"),
                      textFeld(
                        hintText: ap.userModel.location,
                        icon: Icons.location_on_sharp,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: locationController,
                      ),
                      Text("Job description"),
                      textFeld(
                        hintText: ap.userModel.desc,
                        icon: Icons.description_sharp,
                        inputType: TextInputType.text,
                        maxLines: 2,
                        controller: descController,
                      ),
                      Text("Rate per hour"),

                      textFeld(
                        hintText: ap.userModel.rate+ "Rs",
                        icon: Icons.description_sharp,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: rateController,
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 190,

                      child: CustomButton(

                        text: "Save",
                        onPressed: () {
                          if  ((nameController.text=="") || (descController.text=="")||(locationController.text=="")||(rateController.text==""))
                            {
                              showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                            title: const Text("Alert Dialog Box"),
                            content: const Text("Please fill all the fields"),
                            actions: <Widget>[
                            TextButton(
                            onPressed: () {
                            Navigator.of(ctx).pop();
                            },
                                child: Container(
                            color: Colors.deepPurple,
                            padding: const EdgeInsets.all(14),
                            child: const Text("okay",style: TextStyle(color:Colors.white),),
                            ),
                            ),
                          ]
                            ));


                            }
                              else
                          storeData();}
    ),
    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 190,
                    child: CustomButton(


                        text: "Cancel",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SpProfile()));
                          }
                    ),
                  ),


                ],
              )
    ],
    ),
        )


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

        cursorColor: Colors.deepPurple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.deepPurple,
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
        url: "",
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        createdAt: "",
        phoneNumber: "",
        uid: "",
        service: serviceController.text,
        desc:descController.text,
        rate: rateController.text,
        review:["5"]
    );

    ap.saveUserDataToFirebase(
      context: context,
     // id: image!,

      userModel: userModel,
      onSuccess: () {
        ap.saveUserDataToSP().then(
              (value) => ap.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SpProfile(),
                ),(route) => false,
                    ),
          ),
        );
      },
    );

  }
}
