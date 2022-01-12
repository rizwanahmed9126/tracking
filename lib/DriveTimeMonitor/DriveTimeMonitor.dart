import 'package:flutter/material.dart';

class DriveTimeMonitor extends StatefulWidget {
  final String appBartxt;
  final bool isTen;
  DriveTimeMonitor({this.appBartxt,this.isTen});

  @override
  _DriveTimeMonitorState createState() => _DriveTimeMonitorState();
}

class _DriveTimeMonitorState extends State<DriveTimeMonitor> {

  List<String> ten=[];
  //List<String> fours=['1:23','2:37','TMA-023'];


  @override
  void initState() {
    super.initState();
    if(widget.isTen)
    {
      ten.add('10:00');
      ten.add('10:00');
      ten.add('10:00');
    }
    else
      {
        ten.add('04:00');
        ten.add('04:00');
        ten.add('04:00');
      }






  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.appBartxt),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),


      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child:

                   ListView.builder(
                      shrinkWrap: true,
                      itemCount: ten.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: GestureDetector(

                            child: vrnTile(
                              'TLZ-096',
                              ten[i],
                              '00:00',


                            ),
                          ),
                        );
                      }
                  )

      ),
    );
  }
}


Widget vrnTile(String vrn, String remaining,String moving){
  return Container(
    child: Container(
      height: 65,
      decoration: BoxDecoration(
          color: Color(0xff87a564),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17,top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(vrn,style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(

                  children: [

                    Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white
                      ),
                      child: Center(
                        child: Text(moving),
                      ),
                    ),
                    SizedBox(height: 1,),
                    Text('Moving',style: TextStyle(fontSize: 11,color: Colors.white)),

                  ],
                ),
                SizedBox(width: 15,),
                Column(
                  children: [

                    Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white
                      ),
                      child: Center(
                        child: Text(remaining),
                      ),
                    ),
                    SizedBox(height: 1,),
                    Text('Remaining',style: TextStyle(fontSize: 11,color:Colors.white ),),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}