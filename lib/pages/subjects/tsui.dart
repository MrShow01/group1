import 'package:flutter/material.dart';
import 'package:g1/pages/subjects/controller/liststd.dart';
import 'package:provider/provider.dart';

class Tsui extends StatelessWidget {
  const Tsui({super.key});

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Liststdnotifier>(context);
    
    if (usr.i) {
      usr.fetch();
      usr.i = false;
    }
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),

        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: usr.userlist.length,
              itemBuilder: (context, index) {
                
                return Container(
                  //width: 95,
                  //height: 25,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    // color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Container(
                    padding: const EdgeInsets.symmetric( horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:usr.userlist[index].ts > 50 ? Color.fromARGB(255, 80, 177, 60): Color.fromARGB(255, 160, 38, 38),
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        '${usr.userlist[index].name}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:usr.userlist[index].ts > 50 ? Color.fromARGB(255, 80, 177, 60): Color.fromARGB(255, 160, 38, 38),
                        ),
                      ),
                      subtitle: Text(
                        'Ts degrees: ts=${usr.userlist[index].ts}',
                        style: TextStyle(
                          color: usr.userlist[index].ts > 50 ? Color.fromARGB(255, 133, 168, 126): Color.fromARGB(209, 202, 125, 125),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          
                        ),
                      ),
                      trailing: usr.userlist[index].ts > 50 ? Icon(Icons.thumb_up_alt_rounded,size: 30,color: Color.fromARGB(255, 80, 177, 60),): Icon(Icons.thumb_down,size: 30,color: Color.fromARGB(255, 160, 38, 38),),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}