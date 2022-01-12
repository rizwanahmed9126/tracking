import 'package:flutter/material.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Setting'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body:  Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Text(
                        'Settings',
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap:(){
                          getContactBottomSheet(context);
                          },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Text('Live Support'),

                                  Icon(Icons.arrow_forward_ios_sharp,size: 17,)
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ]

          )
      )

    );
  }
}

getContactBottomSheet(context){

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32)

      )
    ),
      context: context,
      builder: (context) {
       return Container(

         height: 100,
         child:Padding(
           padding: const EdgeInsets.all(20.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               GestureDetector(
                 onTap: (){
                   openUrl('tel:+923033067341');
                 },
                 child: Column
                   (
                   children: [
                     Icon(Icons.call,size: 30,),
                     Text('Call')
                   ],
                 ),
               ),
               GestureDetector(
                 onTap: (){
                   openUrl('mailto:tech.support@xtremesolutions.pk');
                 },
                 child: Column
                   (
                   children: [
                     Icon(Icons.email,size: 30,),
                     Text('E-mail')
                   ],
                 ),
               ),
               GestureDetector(
                 onTap: (){
                   openUrl('whatsapp://send?phone=+923033067341');
                 },
                 child: Column
                   (
                   children: [

                     ImageIcon(
                       AssetImage('assets/whatsapp.png'),
                       size: 30,
                     ),
                     Text('WhatsApp')
                   ],
                 ),
               ),

               GestureDetector(
                 onTap: (){
                   openUrl('sms:+923033067341');
                 },
                 child: Column
                   (
                   children: [
                     Icon(Icons.sms,size: 30,),
                     Text('SMS')
                   ],
                 ),
               ),

             ],
           ),
         )
       ) ;
      }
  );

}


Future openUrl(String url)async{
  //final url='mailto:$toEmail';
  await _launchUrl(url);
}
// Future makeCall(String makeCall)async{
//   final url='tel:$makeCall';
//   await _launchUrl(url);
// }
// Future makeCall(String makeCall)async{
//   final url='tel:$makeCall';
//   await _launchUrl(url);
// }

Future _launchUrl(String url)async{
  if(await canLaunch(url)){
    await launch(url);
  }

}