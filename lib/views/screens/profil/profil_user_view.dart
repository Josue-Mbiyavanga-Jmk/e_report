import 'package:flutter/material.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/views/widgets/profil_widget/constant_profil_widget.dart';

class ProfilUserView extends StatefulWidget {
  const ProfilUserView({Key? key}) : super(key: key);

  @override
  _ProfilUserViewState createState() => _ProfilUserViewState();
}

class _ProfilUserViewState extends State<ProfilUserView> {
  String userName = '';
  String userEmail = '';
  String userRole = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName =  UserSimplePreference.getUserName() ?? '';
    userEmail =  UserSimplePreference.getUserEmail() ?? '';
    userRole =  UserSimplePreference.getUserRole() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon Profil',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20, right: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: Image.asset("assets/image/user.png").image,
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128,
                        child: InkWell(onTap: (){}),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: buildEditIcon(Colors.blueGrey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nom  : ',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(height: 2, color: Colors.blueGrey,),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email  : ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      userEmail,
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(height: 2, color: Colors.blueGrey,),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Role  : ',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      userRole,
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(height: 2, color: Colors.blueGrey,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
