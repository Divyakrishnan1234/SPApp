import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScrollListhome extends StatelessWidget {
  const ScrollListhome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmed bookings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final booking in bookings)
              BookingListItem(
                name: booking.name,
                date: booking.date,
                number: booking.number,
                place: booking.place,
                url: booking.url,
              ),
          ],
        ),
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

class BookingListItem extends StatelessWidget {
  BookingListItem({
    Key? key,
    required this.name,
    required this.date,
    required this.number,
    required this.place,
    required this.url,
  }) : super(key: key);
  final String name;
  final String date;
  final String number;
  final String place;
  final String url;

  @override
  Widget build(BuildContext context) {
    var url = Uri.parse("tel:9776765434");
    
    return Card(

      elevation: 4,
      surfaceTintColor: Colors.purple,
      shadowColor: Colors.deepPurple.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Divider(),
                  Text(
                    place,
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
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 0),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      Uri phoneno = Uri.parse('tel:$number');
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
        ],
      ),
    );
  }
}

class booking {
  const booking({
    required this.date,
    required this.number,
    required this.place,
    required this.url,
    required this.name,
  });

  final String date;
  final String number;
  final String place;
  final String url;
  final String name;
}

const bookings = [
  booking(
    name: 'Customer : fai',
    date: '29-03-2022',
    number: '+7365859038',
    place: 'Kunnamangalam',
    url: 'URL',
  ),
  booking(
    name: 'Customer : amal',
    date: '31-03-2022',
    number: '+9248475869',
    place: 'Kunnamangalam',
    url: 'URL',
  ),
  booking(
    name: 'Customer : aarsha',
    date: '01-04-2022',
    number: '+919562537171',
    place: 'Kunnamangalam',
    url: 'URL',
  ),
];
