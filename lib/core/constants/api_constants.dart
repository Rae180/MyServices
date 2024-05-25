class ApiConstants {
  static const String baseAppUrl = "http://192.168.1.106:8000/api/";
  static const String STORAGE_URL = "http://192.168.1.106:8000/";

  static const String getCategory = "${baseAppUrl}category";
  static const String getServices = "${baseAppUrl}service/";
  static const String login = "${baseAppUrl}login";
  static const String signupprovider = "${baseAppUrl}registerasprovider";
  static const String signupuser = "${baseAppUrl}regascustomer";
  static const String checkactiveaccountprovider =
      "${ApiConstants.baseAppUrl}provider/check_acc";
  static const String logout = "${ApiConstants.baseAppUrl}logout";

  static const String changestatusprovicer =
      "${ApiConstants.baseAppUrl}provider/status";
  static const String updatelocationprovider =
      "${ApiConstants.baseAppUrl}provider/update_location";
}
