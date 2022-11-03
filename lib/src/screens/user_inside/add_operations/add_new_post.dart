import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/screens/user_inside/pick_location_from_map.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunRawChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/GoogleMapWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomInkWell.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pryvee/src/models/commun_select_model.dart';
import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/models/address_model.dart';
import 'package:pryvee/src/utils/dotted_border.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/data/data_source_get.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// ignore: must_be_immutable
class AddNewPosWidget extends StatefulWidget {
  AddNewPosWidget({Key key}) : super(key: key);

  @override
  _AddNewPosWidget createState() => _AddNewPosWidget();
}

class _AddNewPosWidget extends State<AddNewPosWidget> {
  List<CommunSelectModel> intervalList = [
    new CommunSelectModel('20', true),
    new CommunSelectModel('40', false),
    new CommunSelectModel('60', false),
    new CommunSelectModel('80', false),
    new CommunSelectModel('120', false),
    new CommunSelectModel('140', false),
    new CommunSelectModel('160', false),
    new CommunSelectModel('180', false),
    new CommunSelectModel('200', false),
  ];
  TextEditingController checkDatingUserPhoneNumberController =
      new TextEditingController();
  TextEditingController checkDatingUserFirstnameController =
      new TextEditingController();
  TextEditingController checkDatingUserLastnameController =
      new TextEditingController();
  TextEditingController checkCarPlateNumberController =
      new TextEditingController();
  TextEditingController checkDatingAddressController =
      new TextEditingController();
  TextEditingController checkDatingCountryController =
      new TextEditingController();
  TextEditingController checkDatingCityController = new TextEditingController();
  TextEditingController checkTransportController = new TextEditingController();
  DateTime checkDatingDate = DateTime.now();
  String checkDatingUserPhoneNumber = '';
  DataSourceGet apiGet = DataSourceGet();
  DataSourceSet apiSet = DataSourceSet();
  String checkDatingUserFirstname = '';
  String checkDatingUserLastname = '';
  String checkCarPlateNumber = '';
  String checkDatingPostcode = '';
  String checkDatingAddress = '';
  String checkDatingCountry = '';
  String checkInterval = '20';
  File checkDatingUserPicture;
  String checkDatingCity = '';
  String checkTransport = '';
  LatLng checkDatingLatLng;
  bool isLoading = false;
  UserData checkTrustedUser;
  UserData user;

  String getIntervalFormatted(String string) {
    int value = getIntFromString(string);
    if (value > 60)
      return '${value ~/ 60} Hours${value % 60 > 0 ? ' And ${value % 60} Minutes' : ''}';
    return '$string Minutes';
  }

  Future<void> getCurrentUserAPI() => apiGet
      .getCurrentUserAPI()
      .then((value) => setState(() => this.user = value));

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getCurrentUserAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.checkDatingUserPicture == null);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            UiIcons.return_icon,
            color: Theme.of(context).hintColor,
            size: 20.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Add new post',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shrinkWrap: true,
        primary: false,
        children: [
          Text(
            "The person you go out with or visit".toUpperCase(),
            style: Theme.of(context).textTheme.headline2.merge(
                  TextStyle(
                    fontSize: 12.0,
                  ),
                ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Picture',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Center(
            child: CustomInkWell(
              onTap: () => ImagePicker()
                  .pickImage(source: ImageSource.gallery)
                  .then((value) => value == null
                      ? {}
                      : setState(() =>
                          this.checkDatingUserPicture = File(value.path))),
              child: this.checkDatingUserPicture == null
                  ? Container(
                      padding: EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      height: 100.0,
                      width: 100.0,
                      decoration: DottedBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.grey,
                        shape: Shape.box,
                        strokeWidth: 0.6,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommunChipWidget(
                            borderRadiusGeometry: BorderRadius.circular(100.0),
                            edgeInsetsGeometry: EdgeInsets.all(6.0),
                            color: Theme.of(context).focusColor,
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Téléchargez',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(2.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: APP_COLOR, width: 1.0),
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.transparent,
                      ),
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: CircleAvatar(
                          backgroundImage: FileImage(
                            this.checkDatingUserPicture,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Full name',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkDatingUserFirstname = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: this.checkDatingUserFirstnameController,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'First name',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkDatingUserLastname = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: this.checkDatingUserLastnameController,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'Last name',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Phone number',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.transparent,
            ),
            height: 44.0,
            child: TextField(
              onChanged: (String value) =>
                  setState(() => this.checkDatingUserPhoneNumber = value),
              controller: this.checkDatingUserPhoneNumberController,
              cursorColor: Theme.of(context).colorScheme.secondary,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 6.0),
                hintText: 'Phone number',
                hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                    TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4))),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "My trusted contact".toUpperCase(),
            style: Theme.of(context).textTheme.headline2.merge(
                  TextStyle(
                    fontSize: 12.0,
                  ),
                ),
          ),
          SizedBox(height: 8.0),
          this.checkTrustedUser == null
              ? Text(
                  "You didn't select any trusted contact yet.".toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1.merge(
                        TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.6),
                        ),
                      ),
                )
              : SizedBox(),
          SizedBox(height: 8.0),
          CommunChipWidget(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewPosWidget())),
            edgeInsetsGeometry:
                EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            boxBorder: Border.all(color: APP_COLOR, width: 1.0),
            borderRadiusGeometry: BorderRadius.circular(8.0),
            color: Colors.transparent,
            width: double.infinity,
            child: Text(
              'Choose a contact',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.merge(
                    TextStyle(
                      color: APP_COLOR,
                      fontSize: 12.0,
                    ),
                  ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Place of visit".toUpperCase(),
            style: Theme.of(context).textTheme.headline2.merge(
                  TextStyle(
                    fontSize: 12.0,
                  ),
                ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Full address',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(100.0),
              color: Colors.transparent,
            ),
            height: 44.0,
            child: TextField(
              onChanged: (String value) =>
                  setState(() => this.checkDatingCountry = value),
              cursorColor: Theme.of(context).colorScheme.secondary,
              controller: this.checkDatingCountryController,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 6.0),
                hintText: 'Country',
                hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                    TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4))),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkDatingCity = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: this.checkDatingCityController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'City',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkDatingAddress = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: this.checkDatingAddressController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'Address',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
          this.checkDatingLatLng == null
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 200.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMapWidget(
                        initialCameraPosition: CameraPosition(
                            target: this.checkDatingLatLng, zoom: 16.0),
                        initialLatLng: this.checkDatingLatLng,
                        onCameraMove: (value) {},
                        onTap: (value) {},
                        circleSet: {},
                        markerSet: {},
                        zoom: 16.0,
                      ),
                      getUserMarkerWidget(),
                    ],
                  ),
                ),
          SizedBox(height: 8.0),
          CommunChipWidget(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PickLocationFromMapWidget(
                        user: this.user,
                        refreshTheView: (value) =>
                            setState(() => this.checkDatingLatLng = value)))),
            edgeInsetsGeometry:
                EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            boxBorder: Border.all(color: APP_COLOR, width: 1.0),
            borderRadiusGeometry: BorderRadius.circular(8.0),
            color: Colors.transparent,
            width: double.infinity,
            child: Text(
              'Pick the location from map',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.merge(
                    TextStyle(
                      color: APP_COLOR,
                      fontSize: 12.0,
                    ),
                  ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "I will use".toUpperCase(),
            style: Theme.of(context).textTheme.headline2.merge(
                  TextStyle(
                    fontSize: 12.0,
                  ),
                ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkTransport = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: this.checkTransportController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'Transport',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent,
                  ),
                  height: 44.0,
                  child: TextField(
                    onChanged: (String value) =>
                        setState(() => this.checkCarPlateNumber = value),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: this.checkCarPlateNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 6.0),
                      hintText: 'Car Plate Number',
                      hintStyle: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4))),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            "Check on me every".toUpperCase(),
            style: Theme.of(context).textTheme.headline2.merge(
                  TextStyle(
                    fontSize: 12.0,
                  ),
                ),
          ),
          SizedBox(height: 8.0),
          Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(this.intervalList.length, (index) {
                CommunSelectModel csm = this.intervalList.elementAt(index);
                return CommunRawChipWidget(
                  onSelected: (bool value) {
                    this.intervalList.map((e) => e.selected = false).toList();
                    this.checkInterval = csm.name;
                    csm.selected = true;
                    setState(() {});
                  },
                  selected: csm.selected,
                  label: getIntervalFormatted(csm.name),
                );
              })),
          SizedBox(height: 8.0),
          // (this.isLoading)
          //     ? CustomCircularProgressIndicatorWidget(
          //         alignmentGeometry: Alignment.center,
          //         edgeInsetsGeometry: EdgeInsets.all(14.0),
          //       )
          //     :
          CommunTextButtonWidget(
            onPressed: () {
              // apiSet
              //     .uploadImageToCloudinary(this.checkDatingUserPicture, 'dating-users', 'USERID_${this.user.userId}')
              //     .then((CloudinaryResponse cloudinaryResponse) =>
              apiSet
                  .addNewPostAPI(
                AddressModel(
                  postCode: this.checkDatingPostcode,
                  address: this.checkDatingAddress,
                  country: this.checkDatingCountry,
                  city: this.checkDatingCity,
                ),
                this.user.email,
                this.checkCarPlateNumber,
                this.checkDatingDate,
                getIntFromString(this.checkInterval),
                '2234234',
                this.checkTransport,
                UserData(
                  firstName: this.checkDatingUserFirstname,
                  lastName: this.checkDatingUserLastname,
                  phone: this.checkDatingUserPhoneNumber,
                  picture: 'cloudinaryResponse.public_id',
                ),
              )
                  .then((Post post) {
                print('a');
              }).catchError((onError) => this.isLoading = !this.isLoading);
              // .catchError((onError) => this.isLoading = !this.isLoading);
            },
            color: APP_COLOR,
            shape: StadiumBorder(),
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getUserMarkerWidget() => Stack(
        alignment: Alignment.center,
        children: [
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.2),
            height: 100.0,
            width: 100.0,
            child: SizedBox(),
          ),
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.3),
            height: 80.0,
            width: 80.0,
            child: SizedBox(),
          ),
          CommunChipWidget(
            borderRadiusGeometry: BorderRadius.circular(100.0),
            edgeInsetsGeometry: EdgeInsets.zero,
            color: APP_COLOR.withOpacity(0.4),
            height: 60.0,
            width: 60.0,
            child: SizedBox(),
          ),
          SizedBox(
            height: 40.0,
            width: 40.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).focusColor,
              backgroundImage: NetworkImage(
                this.user.picture,
              ),
            ),
          ),
        ],
      );
}
