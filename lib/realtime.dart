///// Insertpage////

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/viewdata.dart';

/* insert and update*///code
class realtime extends StatefulWidget {
  Map? m;
  realtime({this.m});

  @override
  State<realtime> createState() => _realtimeState();
}

class _realtimeState extends State<realtime> {
TextEditingController tname = TextEditingController();
TextEditingController tcontact = TextEditingController();

@override
  void initState() {
  super.initState();

  if(widget.m!=null)
    {
      tname.text=widget.m!['name'];
      tcontact.text=widget.m!['contact'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(

      appBar: AppBar(title: Text("Real Time Data Base"),leading: IconButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return viewdata();
        },));
      }, icon: Icon(Icons.arrow_back)),),
      body: Column(
        children: [
          TextField(controller: tname,),
          TextField(controller: tcontact,),
          ElevatedButton(onPressed: () {
            String name = tname.text;
            String contact = tcontact.text;
            if(widget.m==null)
            {
              DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").push();
              String? userid=ref.key;


              Map m = {"userid":userid,"name":name,"contact":contact};
              ref.set(m);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
              {
                return viewdata();
              },));
            }
            else{
              String userid=widget.m!['userid'];
              DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").child(userid);

              Map m = {"userid":userid,"name":name,"contact":contact};
              ref.set(m);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewdata();
              },));


            }


          }, child: Text("Submit"))
        ],
      ),
    ), onWillPop: goback);
  }
  Future<bool>goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewdata();
    },));
    return Future.value();
  }
}


/* only insert*/// code

// class _realtimeState extends State<realtime> {
//   TextEditingController tname = TextEditingController();
//   TextEditingController tcontact = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(title: Text("Real Time Data Base"),),
//       body: Column(
//         children: [
//           TextField(controller: tname,),
//           TextField(controller: tcontact,),
//           ElevatedButton(onPressed: () {
//             //FirebaseDatabase database = FirebaseDatabase.instance;
//             DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").push();
//             String? userid=ref.key;
//             String name = tname.text;
//             String contact = tcontact.text;
//
//             Map m = {"userid":userid,"name":name,"contact":contact};
//             ref.set(m);
//
//           }, child: Text("Submit"))
//         ],
//       ),
//     );
//   }
// }