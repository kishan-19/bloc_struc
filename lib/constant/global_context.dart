import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> navigatorKeyHome = GlobalKey<NavigatorState>();
  static String notif_type = "";
  static String notif_id = "";
  static String lastInquiredProject = "";
  static bool isForVerifyCP = false;
  static bool isForInvitePopUp = false;
  static bool isPlaceOrder = false;
  static bool isAddressListReload = false;

  static String task_click_type = "";
  static bool isTodoLoad = false;
  static bool isTodoCountDataLoadAfterSave = false;

  // static List<DeveloperList> developerList = List<DeveloperList>.empty(growable: true);
  // static List<InquiryProjectData> projectList = List<InquiryProjectData>.empty(growable: true);
  // static List<InquiryTypes> inquiryTypesList = List<InquiryTypes>.empty(growable: true);
  // static List<AddressListData> addressList = List<AddressListData>.empty(growable: true);
  // static List<ProjectList> listProjectPreview = List<ProjectList>.empty(growable: true);
  // static List<BlogList> listBlogs = List<BlogList>.empty(growable: true);
  // static List<FeedModel> listFeed = List<FeedModel>.empty(growable: true);
  // static List<OtherBusinessItem> listOtherBusiness = List<OtherBusinessItem>.empty(growable: true);
  // static List<TaskListData> listTaskData = [];
  // static VendorData getSetVendor = VendorData();
  // static Data getSet = Data();
  // static InquiryDropDownResponse inquiryDropDownGetSet = InquiryDropDownResponse();
}