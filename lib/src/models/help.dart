class FAQModel {
  String title;
  String description;

  FAQModel({this.title, this.description});
}

class FAQModelList {
  List<FAQModel> _list;

  List<FAQModel> get list => _list;

  FAQModelList() {
    _list = [
      FAQModel(
        title: ' ',
        description: '',
      ),
      FAQModel(
        title: ' ',
        description: '',
      ),
      FAQModel(
        title: ' ',
        description: '',
      ),
    ];
  }
}

class TermsAndConditionsModel {
  String title;
  String description;

  TermsAndConditionsModel({this.title, this.description});
}

class TermsAndConditionsModelList {
  List<TermsAndConditionsModel> _list;

  List<TermsAndConditionsModel> get list => _list;

  TermsAndConditionsModelList() {
    _list = [
      TermsAndConditionsModel(
        title: 'Terms & Conditions',
        description: '',
      ),
      TermsAndConditionsModel(
        title: 'Contact Information',
        description: '',
      ),
      TermsAndConditionsModel(
        title: 'Resale Policy',
        description: '',
      ),
    ];
  }
}

class ShippingAndReturns {
  String title;
  String description;

  ShippingAndReturns({this.title, this.description});
}

class ShippingAndReturnsList {
  List<ShippingAndReturns> _list;

  List<ShippingAndReturns> get list => _list;

  ShippingAndReturnsList() {
    _list = [
      ShippingAndReturns(
        title: 'General Information',
        description: ' ',
      ),
      ShippingAndReturns(
        title: 'Privacy Policy',
        description: ' ',
      ),
      ShippingAndReturns(
        title: 'USA',
        description: ' ',
      ),
    ];
  }
}

class PrivacyPolicy {
  String title;
  String description;

  PrivacyPolicy({this.title, this.description});
}

class PrivacyPolicyList {
  List<PrivacyPolicy> _list;

  List<PrivacyPolicy> get list => _list;

  PrivacyPolicyList() {
    _list = [
      PrivacyPolicy(
        title: 'Privacy Policy',
        description: ' ',
      ),
      PrivacyPolicy(
        title: 'Who we are',
        description: ' ',
      ),
      PrivacyPolicy(
        title: 'What we collect and why',
        description: ' ',
      ),
    ];
  }
}
