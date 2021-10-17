import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/views/widgets/user_widget/item_user_widget.dart';


class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}



class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    //on recupere la liste des cars depuis le parent (user_list_view)
    final users = Provider.of<List<AppUserData>>(context) ?? [];
    //on exclut l'utilisateur actif lui-meme
    users.removeWhere((item) => item.uid == UserSimplePreference.getUserUID());

    return users.length == 0 ?
        EmptyUserList(context) :
        ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              return UserItemWidget(user:users[index]);
            }
        );
  }

  Widget EmptyUserList (BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 80, bottom: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        'Aucun utilisateur enregistré pour le moment!',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blueGrey),
      ),
    ),
  );
}

