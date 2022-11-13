import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/screens/user_inside/add_operations/add_new_contact.dart';
import 'package:pryvee/src/screens/user_inside/add_operations/add_new_post.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomSearchBarWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TrustedContacts extends StatefulWidget {
  TrustedContacts({Key key}) : super(key: key);
  @override
  _TrustedContactsState createState() => _TrustedContactsState();
}

class _TrustedContactsState extends State<TrustedContacts> {
  TextEditingController searchTextEditingController = TextEditingController();
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Trusted Contacts")),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          CustomSearchBarWidget(
              searchTextEditingController: this.searchTextEditingController),
          SizedBox(height: 8.0),
          // CommunChipWidget(
          //   onTap: () => Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => AddNewPosWidget())),
          //   edgeInsetsGeometry:
          //       EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          //   borderRadiusGeometry: BorderRadius.circular(8.0),
          //   width: double.infinity,
          //   color: APP_COLOR,
          //   child: Text(
          //     'Add Contact',
          //     textAlign: TextAlign.center,
          //     style: Theme.of(context).textTheme.bodyText1.merge(
          //           TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //   ),
          // ),
          SizedBox(height: 8.0),
          SizedBox(
            height: MediaQuery.of(context).size.height - 30,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: userProvider.userData.contacts.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title:
                      Text(userProvider.userData.contacts[index].displayName),
                  trailing: IconButton(
                      onPressed: () {
                        userProvider.userData.contacts.removeAt(index);
                        userProvider.uploadUserData().then((value) {
                          showToast(context, "Removed from trusted contacts");
                          setState(() {});
                        }).catchError((e) {
                          showToast(context, "$e");
                        });
                      },
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewContactWidget()));
        },
        child: Icon(Icons.add),
        tooltip: "Add Contact",
      ),
    );
  }
}
