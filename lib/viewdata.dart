import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/realtime.dart';

class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  State<viewdata> createState() => _viewdataState();
}
// view,update,delete// code
class _viewdataState extends State<viewdata> {
List l = [];
  @override
  void initState() {
  super.initState();
  loaddata();
  }
  loaddata()
  async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");
    DatabaseEvent de = await ref.once();
    DataSnapshot ds = de.snapshot;
    print(ds.value);
    
    Map map = ds.value as Map;
    map.forEach((key, value) { 
      l.add(value);
    });
    setState(() {
      print(l);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("viewdata"),),
      body: l.length>0?ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        Map m = l[index];
        return ListTile(onTap: () {
          showDialog(builder: (context1) {
            return SimpleDialog(
              title: Text("Select Choice"),
              children: [
                ListTile(onTap: () {
                  Navigator.pop(context1);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return realtime(m: m,);
                  },));
                },title: Text("Update"),),
                ListTile(onTap: () async {
                  Navigator.pop(context1);
                  String userid=m['userid'];
                  DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").child(userid);

                  await ref.remove();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return viewdata();
                  },));

                },title: Text("Delete"),),
              ],
            );
          }, context: context,);
        },
          title: Text("${m['name']}"),
          subtitle: Text("${m['contact']}"),
        );
      },):Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return realtime();
        },));
      },),
    );
  }


}


// only veiw //code

/*//class _viewdataState extends State<viewdata> {
  List l = [];
  @override
  void initState() {
    super.initState();
    loaddata();
  }
  loaddata()
  async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");
    DatabaseEvent de = await ref.once();
    DataSnapshot ds = de.snapshot;
    print(ds.value);

    Map map = ds.value as Map;
    map.forEach((key, value) {
      l.add(value);
    });
    setState(() {
      print(l);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("viewdata"),),
      body: l.length>0?ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        Map m = l[index];
        return ListTile(
          title: Text("${m['name']}"),
          subtitle: Text("${m['contact']}"),
        );
      },):Center(child: CircularProgressIndicator()),
    );
  }


}*/
