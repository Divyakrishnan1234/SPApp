import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotpro_customer/screens/Editprofile.dart';
class SpProfile extends StatelessWidget {
  const SpProfile({Key? key}) : super(key: key);

  static const String _title = 'SpotPro';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(textTheme: GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(

        body: const MyStatefulWidget(),
      ),
    );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late bool forAndroid=true;
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return
      SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    'https://cdnassets.hw.net/dims4/GG/2ac1736/2147483647/resize/876x%3E/quality/90/?url=https%3A%2F%2Fcdnassets.hw.net%2Fe3%2F76%2F1244c96b48fa9a1f23ade5d0e34b%2Flead-carpenter.jpg',
                    height: 200,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    fit: BoxFit.fill,
                  ),

                ),
                Container(alignment: FractionalOffset.centerLeft,child:Text(ap.userModel.service), padding: EdgeInsets.only(left:15, top:5),),
                // Text(ap.userModel.name),
                // Text(ap.userModel.phoneNumber),
                // Text(ap.userModel.email),
                ListTile(

                  title:Padding(padding: const EdgeInsets.only(bottom: 5.0),child:  Text(
                    ap.userModel.name,
                    style: TextStyle(fontSize: 20),

                  ))
                  ,
                  subtitle: Text(
                    "Rs "+ap.userModel.rate+"/hr",
                    style: TextStyle(fontSize: 16),
                  ),

                  minVerticalPadding: 4.0,),

                ListTile(

                    title: Text(
                      'Rating',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing:Wrap(children: [
                      Icon(Icons.star, color: Colors.deepPurple,),
                      Text(ap.userModel.review[0],style: TextStyle(fontSize: 20),),
                    ],)


                ),
                ListTile(

                  title:Row(
                    children: [
                      Text('Description', style: TextStyle(fontSize: 16),),
                      //IconButton(onPressed:(){}, icon: Icon(Icons.edit)),
                    ],
                  ),
                  subtitle: Text(ap.userModel.desc),

                ),
                ListTile(title: Text('Available At:'),subtitle: Text(ap.userModel.location),),
                Padding(
                  padding: const EdgeInsets.only(top:0.5,left:15, right:15),
                  child: Divider(thickness: 2),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Text('Set Availabilty '),
                      Spacer(),
                      Switch(
                        // thumb color (round icon)
                        activeColor: Colors.deepPurple,
                        activeTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.shade400,
                        splashRadius: 50.0,
                        // boolean variable value

                        value: forAndroid,
                        // changes the state of the switch
                        onChanged: (value) => setState(() => forAndroid = value),
                      ),
                    ],
                  ),
                )
                ,


                ListTile(title: Text('Reviews(1)'),),
                ListTile(leading: Icon(Icons.person,size: 50,),
                    title: Text('Faiza'),
                    subtitle: Text('amazing'),
                    trailing:Wrap(children: [
                      Icon(Icons.star, size: 18,color: Colors.deepPurple,),
                      Text('5.0',style: TextStyle(fontSize: 18),),
                    ],)),
                ElevatedButton(onPressed:  (){
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                builder: (context) => const Editprofile()),
                (route) => false);}
                ,child: Text("Edit Profile >",),
                    style:ElevatedButton.styleFrom(primary: Colors.deepPurple))

              ],
            ),
          ),
        ),
      );
  }
}



class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}



