import 'package:autotomi/common/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';

class PersonalInfoController extends GetxController {
  var selectedCountryCode = "1";
  var isoCode = "1", flag;

  TextEditingController guarantor = TextEditingController();
  TextEditingController emailGuarantor = TextEditingController();
  TextEditingController guarantorAddress = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ukAddress = TextEditingController();
  TextEditingController flatNo = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController previousAddress = TextEditingController();
  TextEditingController previousAddressPostCode = TextEditingController();
  TextEditingController proofID = TextEditingController();
  TextEditingController proofResidance = TextEditingController();

  String? proofOfIDTypeItem;
  List<String> proofofIDList = ['Residence Permit', 'International Passport'];

  String? residenceTypeItem;
  List<String> residenceList = ['BRP', 'British Passport', 'ILR'];

  String? howLongHaveLiving;
  List<String> howLongHaveLivingList = ['6 Month', '1 Year', '2 Year', '3 Year', '4 Year'];

  var image, image2, image3, profilePic, ukPhone;
  String? imagePath;
  String? imagePath2;
  String? imagePath3;
  final _picker = ImagePicker();
  fromCamera({argument}) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      argument == 1
          ? imagePath = pickedFile.path
          : argument == 2
              ? imagePath2 = pickedFile.path
              : imagePath3 = pickedFile.path;
      argument == 1
          ? image = File(pickedFile.path)
          : argument == 2
              ? image2 = File(pickedFile.path)
              : image3 = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];
      ukPhone = box.read('country_visiting');
      print(flag);
      print(ukPhone);
    }
    print(flag);
    print("object");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
