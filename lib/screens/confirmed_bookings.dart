// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class ScrollListhome extends StatelessWidget {
//   const ScrollListhome({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Confirmed bookings'),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(onPressed: (){
//
//           }, icon: Icon(CupertinoIcons.location_solid))
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true,).snapshots(),
//         builder: (context,snapshot){
//
//           if (snapshot.hasData) {
//             final requests = snapshot.data!.docs;
//             List<Card> requestWidgets = [];
//             for (var request in requests!) {
//               final user = request['name'];
//               final job = request['workDescription'];
//               final status = request['status'];
//               final id = request.id;
//               //final time = request['timestamp'];
//               final locality = request['locality'];
//               final UserID = request['SCid'];
//
//
//
//               final messageWidget = Card(
//
//                 elevation: 4,
//                 surfaceTintColor: Colors.purple,
//                 shadowColor: Colors.deepPurple.withOpacity(0.3),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               user,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[700],
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                             Divider(),
//                             Text(
//                               locality,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w200,
//                               ),
//                             ),
//                             const SizedBox(height: 0),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 0),
//                             /*Text(
//                               date,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[700],
//                               ),
//                               textAlign: TextAlign.right,
//                             ),*/
//                             ElevatedButton(
//                               onPressed: ()async{
//                                 final DocumentSnapshot<Map<String, dynamic>> userDoc =
//                                 await FirebaseFirestore.instance.collection('users').doc(UserID).get();
//
//                                 final String phoneNumber = userDoc.get('phoneNumber');
//                                 Uri phoneno = Uri.parse('tel:$phoneNumber');
//                                 if (await launchUrl(phoneno)) {
//                                   //dialer opened
//                                 }else{
//                                   //dailer is not opened
//                                 }
//                               },style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)
//                                 ),
//                                 backgroundColor: Colors.deepPurple),
//                               child: const Text("Contact"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     IconButton(onPressed: (){
//                       requestDialog(context, id);
//                     }, icon: Icon(CupertinoIcons.trash_fill, color: Colors.deepPurple, size: 30))
//
//                   ],
//                 ),
//               );
//               if (status=='accepted') {
//                 requestWidgets.add(messageWidget);
//               }
//
//             }
//             return  SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: requestWidgets,
//               ),
//             );
//
//
//           }
//           return Text("hi");
//         },
//       ),
//     );
//   }
// }
//
// _makingPhoneCall() async {
//   var url = Uri.parse("tel:9776765434");
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//     print('call');
//   } else {
//     print('cannot call');
//   }
// }
//
// Future<bool?> requestDialog(context,String id) async {
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//
//         content: SingleChildScrollView(
//           child: ListBody(
//             children:  <Widget>[
//               Text('Do you want to cancel the booking?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Yes'),
//             onPressed: () {
//               FirebaseFirestore.instance.collection('requests').doc(id).update(
//                   {
//                     'status':'cancelled',
//                   }
//               );
//
//
//               Navigator.of(context).pop();
//
//
//             },
//           ),
//           TextButton(
//             child: const Text('No'),
//             onPressed: () {
//
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
//}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';


class ScrollListhome extends StatelessWidget {
  const ScrollListhome({
    super.key,
  });
  void getlocation() async{
    late double latitude;
    late double longitude;
    final Spid = FirebaseAuth.instance.currentUser!.uid;
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);

    FirebaseFirestore.instance.collection('providers').doc(Spid).update(
        {
          'latlon':{'latitude':position.latitude,'longitude':position.longitude},
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmed bookings'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: (){
            getlocation();

          }, icon: Icon(Icons.my_location_sharp))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true,).snapshots(),
        builder: (context,snapshot){

          if (snapshot.hasData) {
            final requests = snapshot.data!.docs;
            List<Card> requestWidgets = [];
            for (var request in requests!) {
              final user = request['name'];
              final job = request['workDescription'];
              final status = request['status'];
              final id = request.id;
              final time = request['timestamp'];
              final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000);
              final locality = request['locality'];
              final UserID = request['SCid'];
              final latitude=request['latlon']['latitude'];
              final longitude=request['latlon']['longitude'];


              final messageWidget = Card(

                elevation: 4,
                surfaceTintColor: Colors.purple,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Divider(),
                            Text(
                              locality,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(height: 0),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 0),
                            Text(
                              date1.day.toString()+"-"+date1.month.toString()+"-"+date1.year.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),

                            ElevatedButton(
                              onPressed: ()async{
                                final DocumentSnapshot<Map<String, dynamic>> userDoc =
                                await FirebaseFirestore.instance.collection('users').doc(UserID).get();

                                final String phoneNumber = userDoc.get('phoneNumber');
                                Uri phoneno = Uri.parse('tel:$phoneNumber');
                                if (await launchUrl(phoneno)) {
                                  //dialer opened
                                }else{
                                  //dailer is not opened
                                }
                              },style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                backgroundColor: Colors.deepPurple),
                              child: const Text("Contact"),
                            ),

                          ],
                        ),
                      ),
                    ),


                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children:[

                        IconButton(onPressed: ()async{



                          final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                          if (await canLaunchUrlString(googleMapsUrl)) {
                            await launchUrlString(googleMapsUrl);
                          } else {
                            throw 'Could not launch $googleMapsUrl';
                          }

                        }, icon: Icon(Icons.location_pin, color: Colors.deepPurple, size: 40, )),

                        IconButton(onPressed: (){
                          requestDialog(context, id);
                        }, icon: Icon(CupertinoIcons.trash_fill, color: Colors.deepPurple, size: 16))
                      ],
                    ),

                  ],
                ),
              );
              if (status=='accepted') {
                requestWidgets.add(messageWidget);
              }

            }
            return  SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: requestWidgets,
              ),
            );


          }
          return Text("hi");
        },
      ),
    );

  }

}

_makingPhoneCall() async {
  var url = Uri.parse("tel:9776765434");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
    print('call');
  } else {
    print('cannot call');
  }
}

Future<bool?> requestDialog(context,String id) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(

        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text('Do you want to cancel the booking?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              FirebaseFirestore.instance.collection('requests').doc(id).update(
                  {
                    'status':'cancelled',
                  }
              );


              Navigator.of(context).pop();


            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


