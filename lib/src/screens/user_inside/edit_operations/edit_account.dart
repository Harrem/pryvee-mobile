import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pryvee/src/models/user.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomCircularProgressIndicatorWidget.dart';
import 'package:pryvee/src/widgets/modal_bottom_sheet/add_new_photo_sheet.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunTextButtonWidget.dart';
import 'package:pryvee/src/app_delegate_locale.dart/app_localization.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunRawChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CommunChipWidget.dart';
import 'package:pryvee/src/widgets/shared_inside/CustomInkWell.dart';
import 'package:pryvee/src/models/commun_select_model.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/utils/date_utility.dart';
import 'package:pryvee/data/data_source_set.dart';
import 'package:pryvee/config/ui_icons.dart';
import 'package:flutter/material.dart';

import '../../../utils/commun_mix_utility.dart';

// ignore: must_be_immutable
class EditAccountWidget extends StatefulWidget {
  UserData userData;
  EditAccountWidget({Key key, @required this.userData}) : super(key: key);
  @override
  _EditAccountWidget createState() => _EditAccountWidget();
}

class _EditAccountWidget extends State<EditAccountWidget> {
  TextEditingController checkFirstNameController = TextEditingController();
  TextEditingController checkLastNameController = TextEditingController();
  List<CommunSelectModel> maritalStatusList = [
    CommunSelectModel('SINGLE', false),
    CommunSelectModel('ENGAGED', false),
    CommunSelectModel('MARRIED', false),
    CommunSelectModel('IN_RELATIONSHIP', false),
    CommunSelectModel('PREFER_NOT_TO_SAY', false),
    CommunSelectModel('DIVORCED', false),
  ];
  List<CommunSelectModel> genderList = [
    CommunSelectModel('MALE', false),
    CommunSelectModel('FEMALE', false),
    CommunSelectModel('PREFER_NOT_TO_SAY', false),
  ];
  DataSourceSet apiSet = DataSourceSet();
  String checkDateOfBirth;
  String checkFirstName = '';
  String checkLastName = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.checkFirstNameController.text = widget.userData.firstName;
    this.checkLastNameController.text = widget.userData.lastName;
    this.checkFirstName = widget.userData.firstName;
    this.checkLastName = widget.userData.lastName;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
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
          'Edit profile',
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
            'Profile picture',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomInkWell(
                  onTap: () async {
                    await showAddNewPhotoSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    width: 160.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: APP_COLOR, width: 1.0),
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.transparent,
                    ),
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.userData.picture,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: this.isLoading == false,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      height: 26.0,
                      width: 26.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(100.0),
                        color: APP_COLOR,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
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
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: this.checkFirstNameController,
                    style: Theme.of(context).textTheme.bodyText1,
                    onChanged: (String value) =>
                        setState(() => this.checkFirstName = value),
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
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    controller: this.checkLastNameController,
                    style: Theme.of(context).textTheme.bodyText1,
                    onChanged: (String value) =>
                        setState(() => this.checkLastName = value),
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
            'Date of birth',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          CommunChipWidget(
            edgeInsetsGeometry:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            boxBorder: Border.all(color: Colors.grey, width: 1.0),
            borderRadiusGeometry: BorderRadius.circular(100.0),
            color: Colors.transparent,
            onTap: () async {
              var birthDate = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.inputOnly,
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1960),
                  lastDate: DateTime.now());
              if (birthDate != null)
                setState(() => checkDateOfBirth = birthDate.toString());
            },
            child: Text(
              ("${checkDateOfBirth ?? DateFormat.yMMMEd().format(DateTime.now())}"),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Gender',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(this.genderList.length, (index) {
              CommunSelectModel communSelectModel =
                  this.genderList.elementAt(index);
              return CommunRawChipWidget(
                onSelected: (bool value) {
                  this.genderList.map((e) => e.selected = false).toList();
                  communSelectModel.selected = true;
                  user.userData.gender = communSelectModel.name;
                  setState(() {});
                },
                label: AppLocalizations.of(context)
                    .translate(communSelectModel.name),
                selected: user.userData.gender == communSelectModel.name,
              );
            }),
          ),
          SizedBox(height: 8.0),
          Text(
            'Marital status',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(
              this.maritalStatusList.length,
              (index) {
                CommunSelectModel communSelectModel =
                    this.maritalStatusList.elementAt(index);
                return CommunRawChipWidget(
                  onSelected: (bool value) {
                    this
                        .maritalStatusList
                        .map((e) => e.selected = false)
                        .toList();
                    communSelectModel.selected = true;
                    user.userData.maritalStatus = communSelectModel.name;
                    setState(() {});
                  },
                  label: AppLocalizations.of(context)
                      .translate(communSelectModel.name),
                  selected:
                      user.userData.maritalStatus == communSelectModel.name,
                );
              },
            ),
          ),
          SizedBox(height: 8.0),
          (this.isLoading)
              ? CustomCircularProgressIndicatorWidget(
                  alignmentGeometry: Alignment.center,
                  edgeInsetsGeometry: EdgeInsets.all(14.0),
                )
              : CommunTextButtonWidget(
                  onPressed: (this.checkFirstName.isEmpty ||
                          this.checkLastName.isEmpty)
                      ? null
                      : () {
                          setState(() => this.isLoading = !this.isLoading);
                          user
                              .editUserInfoAPI(
                                  email: user.userData.email,
                                  firstName: this.checkFirstName,
                                  lastName: this.checkLastName,
                                  maritalStatus: user.userData.maritalStatus,
                                  gender: user.userData.gender,
                                  picture: user.userData.picture)
                              .then((value) {
                            setState(() => this.isLoading = !this.isLoading);
                            if (value != null) {
                              setState(() => user.userData = value);
                              Navigator.of(context).pop();
                            } else
                              showToast(context,
                                  "An error occurred, please try again later.");
                          }).catchError((onError) => setState(
                                  () => this.isLoading = !this.isLoading));
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
}
