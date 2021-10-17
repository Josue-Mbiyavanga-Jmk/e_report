import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/services/user_firebase_database.dart';
import 'package:rapport_app/views/widgets/user_widget/list_user_widget.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AppUserData>>.value(
      value: DatabaseService(uid: '').users, //on a pas besoin de uid (chercher comment l'enlever)
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Les Utilisateurs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
          centerTitle: false,
          backgroundColor: Colors.blueGrey, //le titre depend d'où on doit partir.

        ),
        //etant le fils, il aura accès à le liste du parent
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 20.0,
            ),
            child: UserList(),
          ),
        ),
        //
      ),
    );
  }
}
