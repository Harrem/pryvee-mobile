import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/models/user.dart';

class DataSourceGet {
  CollectionReference trustedContacts =
      FirebaseFirestore.instance.collection('trustedContacts');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference post = FirebaseFirestore.instance.collection('posts');

  Future<UserData> getCurrentUserAPI() async {
    DocumentSnapshot<Object> documentSnapshot =
        await users.doc(await getLocalEmailFromSP()).get();
    if (documentSnapshot == null || documentSnapshot.exists == false)
      return null;
    else
      return UserData.fromJson(documentSnapshot.data());
  }

  Future<List<Post>> getCurrentUserPostsAPI() async {
    List<Post> temp = [];
    // DocumentSnapshot<Object> documentSnapshot = await post.doc(await getLocalEmailFromSP()).get();
    // final responseJson = json.decode();
    // List rest = (documentSnapshot == null || documentSnapshot.exists == false) ? [] : (responseJson['objects'].toList());
    // rest.map((e) => temp.add(Post.fromJson(e))).toList();
    return temp;
  }

  Future<UserData> getTrustedContactsAPI() async {
    DocumentSnapshot<Object> documentSnapshot =
        await trustedContacts.doc(await getLocalEmailFromSP()).get();
    if (documentSnapshot == null || documentSnapshot.exists == false)
      return null;
    else
      return UserData.fromJson(documentSnapshot.data());
  }
}
