import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';

class AddNewContactWidget extends StatefulWidget {
  AddNewContactWidget({Key key}) : super(key: key);

  @override
  State<AddNewContactWidget> createState() => _AddNewContactWidgetState();
}

class _AddNewContactWidgetState extends State<AddNewContactWidget> {
  List<Contact> contacts = [];
  bool isLoading = true;
  Future<List<Contact>> getContacts() async {
    contacts = await ContactsService.getContacts();
    return contacts;
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
      await getContacts();
      setState(() {
        isLoading = false;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _askPermissions(null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(Icons.arrow_back),
          ),
          foregroundColor: Colors.black,
          title: Text("Add New Contact")),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 80,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder<List<UserData>>(
                    future: getAvaliableUsers(contacts),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: snapshot.data.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (userProvider.userData.contacts
                                  .contains(snapshot.data[index])) {
                                //TODO: fix showing self contact
                                // if (userProvider.userData.uid !=
                                //     snapshot.data[index].uid) {
                                //   debugPrint(
                                //       "${userProvider.userData.uid != snapshot.data[index].uid}");
                                //   return SizedBox();
                                // }
                                return SizedBox();
                              }
                              return ListTile(
                                leading: Icon(Icons.person),
                                title: Text(snapshot.data[index].fullName),
                                trailing: IconButton(
                                  onPressed: () async {
                                    if (!userProvider.userData.contacts
                                        .contains(snapshot.data[index])) {
                                      if (userProvider.userData.uid !=
                                          snapshot.data[index].uid) {
                                        userProvider.userData.contacts
                                            .add(snapshot.data[index]);
                                        debugPrint(userProvider
                                            .userData.contacts.first
                                            .toString());
                                        await userProvider
                                            .uploadUserData()
                                            .then((value) => showToast(context,
                                                "Added to trusted contacts"))
                                            .catchError((e) => showToast(
                                                context,
                                                "error while adding contact!"));
                                      } else {
                                        showToast(context, "This is you!");
                                      }
                                    } else {
                                      showToast(context, "Already Added");
                                    }
                                  },
                                  icon:
                                      Icon(Icons.add_circle, color: Colors.red),
                                ),
                              );
                            });
                      }
                      return Text("Loading Data");
                    },
                  ),
          ),
        ]),
      ),
    );
  }

  Future<List<UserData>> getAvaliableUsers(List<Contact> contacts) async {
    List<UserData> list = [];

    var docs = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.docs);

    contacts.forEach((contact) {
      if (contact.phones.isNotEmpty) {
        var phoneNo = contact.phones.first.value;
        docs.forEach((element) {
          if (element.data()['phone'] == phoneNo) {
            list.add(UserData.fromJson(element.data()));
          }
        });
      }
    });
    return list;
  }
}
