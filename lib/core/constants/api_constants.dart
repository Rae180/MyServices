class ApiConstants {
  static const String baseAppUrl = "http://10.0.2.2:8000/api/";
  static const String STORAGE_URL = "http://10.0.2.2:8000";
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

  static const String getdetailsorder =
      "${ApiConstants.baseAppUrl}order/detalise/";
  static const String acceptorder = "${ApiConstants.baseAppUrl}order/accept/";
  static const String rejectorder = "${ApiConstants.baseAppUrl}order/refuse/";
  static const String rescheduleorder =
      "${ApiConstants.baseAppUrl}order/reschedule/";
  static const String acceptrescgeduleorder =
      "${ApiConstants.baseAppUrl}order/accept-reschedule/";
  static const String rejectrescgeduleorder =
      "${ApiConstants.baseAppUrl}order/refuse-reschedule/";

  static const String getProvidersService =
      "${ApiConstants.baseAppUrl}provider/service/";
  static const String arriveorder =
      "${ApiConstants.baseAppUrl}completedorder/providerarrived/";
  static const String startWork =
      "${ApiConstants.baseAppUrl}completedorder/startwork/";
  static const String pausework =
      "${ApiConstants.baseAppUrl}completedorder/pausework/";
  static const String resumework =
      "${ApiConstants.baseAppUrl}completedorder/resumework/";
  static const String endwork =
      "${ApiConstants.baseAppUrl}completedorder/endwork/";
  static const String postpomentorder =
      "${ApiConstants.baseAppUrl}order/postponement/";
  static const String additem =
      "${ApiConstants.baseAppUrl}completedorder/additems/";
  static const String paid =
      "${ApiConstants.baseAppUrl}completedorder/cash/";

  static const String PostOrder = "${ApiConstants.baseAppUrl}order";

  static const test = "";
  static const test2 = "";
  static const String GetOrderDetailsDefualt =
      "${ApiConstants.baseAppUrl}order/status/pending";
  static const String GetOrderDetails =
      "${ApiConstants.baseAppUrl}order/status";
  static const String CancelOrder = "${ApiConstants.baseAppUrl}order/cancel/";
  static const String ProviderDetails = "${ApiConstants.baseAppUrl}provider/detalise/";
  static const String profile = "${ApiConstants.baseAppUrl}profile";
  static const String post = "${ApiConstants.baseAppUrl}post";
}
