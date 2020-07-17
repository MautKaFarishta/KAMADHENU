import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HELP CENTER')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:Colors.blue.shade50,
                ),
                child: Text(
                  ' \nWelcome to kamadhenu App.In a case of any query you can refer this steps\n\n\t1. If you are new user so create your new account.\n\n\t2. If you have account so continue by logging in.\n\n\t3. You can Register Your Cattle in Kamadhenu.\n\n\t4. In a case you entered wrong information Contact AHD office near you.\n\n\t5. The cattle information will be verified by Livestock Development Officer.\n\n\t6. LDO will verify the data of cattle by assigning the unique identity using RFID Tag.\n\n\t7. As verification is completed so cattle owner will be allowed to use the feature of buying and selling of cattle.\n\n\t8. During sales, animal information will be sent to near buyers and after confirmation by livestock owner sale will be done.\n\n\t9. After verification by LDO ownership data will be updated.\n\n\t\t\tFor any problem feel free to contact....',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}