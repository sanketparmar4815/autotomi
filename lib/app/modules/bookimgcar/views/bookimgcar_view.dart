import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/Strings.dart';
import '../../../../common/widgets.dart';
import '../controllers/bookimgcar_controller.dart';

class BookimgcarView extends GetView<BookimgcarController> {
  const BookimgcarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookimgcarController controller = Get.put(BookimgcarController());
    return GetBuilder<BookimgcarController>(
        init: BookimgcarController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: commonWidget.customAppbar(
                    arroOnTap: () {
                      selectedCalenderDate = null;
                      selectedCalenderDateEndDate = null;
                      Get.back();
                    },
                    backgroundColor: Colors.white,
                    titleText: stringsUtils.Booking,
                    centerTitle: false,
                    actions: SizedBox(),
                  ),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          commonWidget.regularText(
                            stringsUtils.Country,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: SizedBox(),
                                iconSize: 0,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                // value: controller.countryName.value,
                                items: controller.countyList.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? selectedItem) {
                                  controller.selectCounty = selectedItem;
                                  controller.update();
                                },
                                hint: commonWidget.mediumText(
                                  controller.countryName,
                                  fontsize: 14.0,
                                  tcolor: color.black,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          commonWidget.regularText(
                            "Enter cities you will be roaming with the car",
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                              child: Column(
                                children: [
                                  DropdownButton(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    value: controller.selectCity,
                                    items: controller.cityList.map((item) {
                                      return DropdownMenuItem(
                                        value: item["city_id"],
                                        child: Text(item["city"].toString()),
                                      );
                                    }).toList(),
                                    onChanged: (selectedItem) {
                                      controller.selectCity = selectedItem;
                                      for (var i = 0; i < controller.cityList.length; i++) {
                                        if (controller.cityList[i]['city_id'] == selectedItem) {
                                          if (controller.multiPalCityIDList.contains(controller.cityList[i]['city_id'])) {
                                            Toasty.showtoast("This City Already Selected");
                                          } else {
                                            controller.multiPalCityList.add(controller.cityList[i]['city']);
                                            controller.multiPalCityIDList.add(controller.cityList[i]['city_id']);
                                            print(controller.multiPalCityList);
                                            print(controller.multiPalCityIDList);
                                            print("multiPalCity");
                                          }
                                        }
                                      }
                                      controller.selectCity = null;

                                      controller.update();
                                    },
                                    hint: commonWidget.mediumText(
                                      'Select ',
                                      fontsize: 14.0,
                                      tcolor: color.black,
                                    ),
                                  ),
                                  Obx(() {
                                    return SizedBox(
                                      height: controller.multiPalCityList.length != 0 ? 45 : 0,
                                      width: Get.width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.multiPalCityList.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(.4),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        commonWidget.mediumText(
                                                          controller.multiPalCityList[index],
                                                          fontsize: 14.0,
                                                          tcolor: color.black,
                                                        ),
                                                        // SizedBox(width: 6),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: -7,
                                                    right: -7,
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.multiPalCityList.removeAt(index);
                                                        controller.multiPalCityIDList.removeAt(index);
                                                        print(controller.multiPalCityList);
                                                        print(controller.multiPalCityIDList);
                                                        print("remove city list");
                                                      },
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor: Colors.grey.withOpacity(.4),
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 13)
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          commonWidget.mediumText(
                            stringsUtils.Availability,
                            fontsize: 15.0,
                          ),
                          SizedBox(height: 15),
                          Calendar(bookingList: controller.days),
                          SizedBox(height: 25),
                          commonWidget.regularText(
                            stringsUtils.PickupTime,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              controller.EndTime(context, flag: 1);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonWidget.mediumText(
                                    controller.selectPickupTime == null ? stringsUtils.Select : DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(controller.selectPickupTime.toString())),
                                    fontsize: 14.0,
                                  ),
                                  Icon(
                                    Icons.access_time_rounded,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          commonWidget.regularText(
                            stringsUtils.PickupLocation,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),

                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                value: controller.selectPickupLocation,
                                items: controller.selectPickupLocations.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? selectedItem) {
                                  controller.selectPickupLocation = selectedItem;
                                  if (controller.selectPickupLocation == "Airport") {
                                    controller.PickupAddress.clear();
                                    controller.PickupTelephone.clear();
                                    controller.Pickupinformation.clear();
                                  } else {
                                    controller.selectPickupAirport = null;
                                  }
                                  controller.update();
                                },
                                hint: commonWidget.mediumText(
                                  'Select ',
                                  fontsize: 14.0,
                                  tcolor: color.black,
                                ),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: controller.selectPickupLocation == "Airport" ? true : false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                commonWidget.regularText(
                                  stringsUtils.PickupAirport,
                                  fontsize: 14.0,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                                      value: controller.selectPickupAirport,
                                      items: controller.airportList.map((item) {
                                        return DropdownMenuItem(
                                          value: item["airport_id"],
                                          child: Text(item["airport_text"]),
                                        );
                                      }).toList(),
                                      onChanged: (selectedItem) {
                                        controller.selectPickupAirport = selectedItem;
                                        controller.update();
                                      },
                                      hint: commonWidget.mediumText(
                                        'Select ',
                                        fontsize: 14.0,
                                        tcolor: color.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: controller.selectPickupLocation == "BRING THE CAR TO ME(attract additional cost £10)" ? true : false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                commonWidget.customTextfield(
                                  controller: controller.PickupAddress,
                                  label: stringsUtils.PickupAddress,
                                  hintText: stringsUtils.Enter,
                                ),
                                SizedBox(height: 5),
                                commonWidget.regularText(
                                  stringsUtils.PickupTelephone,
                                  fontsize: 14.0,
                                ),
                                TextField(
                                  controller: controller.PickupTelephone,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  style: TextStyle(
                                    color: color.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Medium',
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          showPhoneCode: true,
                                          showSearch: true,
                                          context: context,
                                          onSelect: (Country country) {
                                            controller.selectedPickupCountryCode = country.phoneCode;
                                            print(controller.selectedCountryCode);
                                            print("rutik");
                                            controller.update();
                                          },
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 67,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 6),
                                            Text(
                                              controller.selectedPickupCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedPickupCountryCode.toString()}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: color.black,
                                              ),
                                            ),
                                            // Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    hintText: "Enter",
                                    counter: SizedBox(),
                                    contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                    hintStyle: TextStyle(
                                      color: color.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Medium',
                                    ),
                                    filled: true,
                                    fillColor: color.fillColor,
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                  ),
                                ),
                                SizedBox(height: 5),
                                commonWidget.customTextfield(
                                  controller: controller.Pickupinformation,
                                  label: stringsUtils.Pickupinformation,
                                  hintText: stringsUtils.Enter,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),

                          SizedBox(height: 15),
                          commonWidget.regularText(
                            stringsUtils.DropoffTime,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),

                          InkWell(
                            onTap: () {
                              controller.EndTime(context, flag: 0);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonWidget.mediumText(
                                    controller.selectDropTime == null ? stringsUtils.Select : DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(controller.selectDropTime.toString())),
                                    fontsize: 14.0,
                                  ),
                                  Icon(
                                    Icons.access_time_rounded,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          commonWidget.regularText(
                            stringsUtils.DropoffLocation,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                value: controller.selectDropOffLocation,
                                items: controller.selectDropOffLocations.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? selectedItem) {
                                  controller.selectDropOffLocation = selectedItem;
                                  if (controller.selectDropOffLocation == "Airport") {
                                    controller.DropoffAddress.clear();
                                    controller.DropoffTelephone.clear();
                                    controller.Dropoffinformation.clear();
                                  } else {
                                    controller.selectDropoffAirport = null;
                                  }
                                  controller.update();
                                },
                                hint: commonWidget.mediumText(
                                  'Select ',
                                  fontsize: 14.0,
                                  tcolor: color.black,
                                ),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: controller.selectDropOffLocation == "Airport" ? true : false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                commonWidget.regularText(
                                  stringsUtils.DropoffAirport,
                                  fontsize: 14.0,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                                      value: controller.selectDropoffAirport,
                                      items: controller.airportList.map((item) {
                                        return DropdownMenuItem(
                                          value: item["airport_id"],
                                          child: Text(item["airport_text"]),
                                        );
                                      }).toList(),
                                      onChanged: (selectedItem) {
                                        controller.selectDropoffAirport = selectedItem;
                                        controller.update();
                                      },
                                      hint: commonWidget.mediumText(
                                        'Select ',
                                        fontsize: 14.0,
                                        tcolor: color.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: controller.selectDropOffLocation == "Come and pick up the car(attract additional cost £10)" ? true : false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                commonWidget.customTextfield(
                                  controller: controller.DropoffAddress,
                                  label: stringsUtils.DropoffAddress,
                                  hintText: stringsUtils.Enter,
                                ),
                                SizedBox(height: 5),
                                commonWidget.regularText(
                                  stringsUtils.DropoffTelephone,
                                  fontsize: 14.0,
                                ),
                                TextField(
                                  controller: controller.DropoffTelephone,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  style: TextStyle(
                                    color: color.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Medium',
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          showPhoneCode: true,
                                          showSearch: true,
                                          context: context,
                                          onSelect: (Country country) {
                                            controller.selectedDropOffCountryCode = country.phoneCode;
                                            print(controller.selectedCountryCode);
                                            controller.update();
                                          },
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 67,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 6),
                                            Text(
                                              controller.selectedDropOffCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedDropOffCountryCode.toString()}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: color.black,
                                              ),
                                            ),
                                            // Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    hintText: "Enter",
                                    counter: SizedBox(),
                                    contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                    hintStyle: TextStyle(
                                      color: color.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Medium',
                                    ),
                                    filled: true,
                                    fillColor: color.fillColor,
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                  ),
                                ),
                                SizedBox(height: 5),
                                commonWidget.customTextfield(
                                  controller: controller.Dropoffinformation,
                                  label: stringsUtils.Dropoffinformation,
                                  hintText: stringsUtils.Enter,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),
                          commonWidget.regularText(
                            stringsUtils.PhoneNumber,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.phoneNumber,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  style: TextStyle(
                                    color: color.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Medium',
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          showPhoneCode: true,
                                          showSearch: true,
                                          context: context,
                                          onSelect: (Country country) {
                                            controller.selectedCountryCode = country.phoneCode;
                                            print(controller.selectedCountryCode);
                                            controller.update();
                                          },
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 67,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 6),
                                            Text(
                                              controller.selectedCountryCode.toString() == 'null' ? "Select" : "+${controller.selectedCountryCode.toString()}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: color.black,
                                              ),
                                            ),
                                            // Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    hintText: "Enter",
                                    counter: SizedBox(),
                                    contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                    hintStyle: TextStyle(
                                      color: color.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Medium',
                                    ),
                                    filled: true,
                                    fillColor: color.fillColor,
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // commonWidget.intlPhoneField(
                          //   controller: controller.phoneNumber,
                          //   hintText: "Phone No.",
                          //   initialCountryCode: controller.isoCode,
                          //   onCountryChanged: (country) {
                          //     controller.isoCode = country.code;
                          //     controller.selectedCountryCode = country.dialCode;
                          //   },
                          // ),
                          SizedBox(height: 15),
                          commonWidget.regularText(
                            stringsUtils.OtherPhoneNumber,
                            fontsize: 14.0,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.otherPhoneNumber,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 15,
                                  style: TextStyle(
                                    color: color.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Medium',
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          showPhoneCode: true,
                                          showSearch: true,
                                          context: context,
                                          onSelect: (Country country) {
                                            controller.selectedCountryCodeOther = country.phoneCode;
                                            print(controller.selectedCountryCode);
                                            controller.update();
                                          },
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            searchTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 67,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 6),
                                            Text(
                                              controller.selectedCountryCodeOther.toString() == 'null' ? "Select" : "+${controller.selectedCountryCodeOther.toString()}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: color.black,
                                              ),
                                            ),
                                            // Spacer(),
                                            Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    hintText: "Enter",
                                    counter: SizedBox(),
                                    contentPadding: EdgeInsets.only(top: 17, bottom: 17, left: 10, right: 10),
                                    hintStyle: TextStyle(
                                      color: color.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Medium',
                                    ),
                                    filled: true,
                                    fillColor: color.fillColor,
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // commonWidget.intlPhoneField(
                          //   controller: controller.otherPhoneNumber,
                          //   hintText: "Phone No.",
                          //   initialCountryCode: controller.isoCodeOther,
                          //   onCountryChanged: (country) {
                          //     controller.isoCodeOther = country.code;
                          //     controller.selectedCountryCodeOther = country.dialCode;
                          //   },
                          // ),
                          SizedBox(height: 30),
                          commonWidget.customButton(
                            onTap: () async {
                              if (validation()) {
                                if (totalDay == 7) {
                                  controller.totalAmount = controller.perWeekPrice;
                                  print(controller.totalAmount);
                                  print(totalDay);
                                  print("sanku");
                                } else if (totalDay < 7) {
                                  controller.totalAmount = totalDay * controller.perDayPrice;
                                  print(controller.totalAmount);
                                  print(totalDay);
                                  print("nemil");
                                } else {
                                  controller.totalWeek = (totalDay / 7).toString().split("").first;
                                  print("TOTAL WEEK ==>>${controller.totalWeek}");
                                  controller.totalWeekAmount = controller.perWeekPrice * int.parse(controller.totalWeek);
                                  print(controller.totalWeekAmount);
                                  print("total week");
                                  controller.totalDay = (totalDay % 7);
                                  print(controller.totalDay);
                                  print("controller.totalDay");
                                  controller.totalDayAmount = controller.totalDay * controller.perDayPrice;
                                  print(controller.totalDayAmount);
                                  print("controller.totalDayAmount");
                                  controller.totalAmount = controller.totalWeekAmount + controller.totalDayAmount;
                                  print(controller.totalAmount);
                                  // controller.percentage = (controller.totalAmount / 100) * 20;
                                  // print(controller.percentage);
                                  // print("percenat amount");
                                  // controller.totalAmount = controller.totalAmount - controller.percentage;
                                  // print(controller.totalAmount);
                                  print(totalDay);
                                  print("rutik");
                                }
                                print("Api Call start");
                                await controller.bookingCar_Api();
                              }
                            },
                            height: 48.0,
                            text: stringsUtils.BookNow,
                            textfontsize: 16.0,
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                  )),
            );
          });
        });
  }

  bool pickupvalidation() {
    if (controller.selectPickupLocation == "Airport") {
      if (controller.selectPickupAirport == null) {
        Toasty.showtoast("Please Select the pickup Airport");
        return false;
      } else {
        return true;
      }
    } else {
      if (controller.PickupAddress.text.isEmpty) {
        Toasty.showtoast("Please Enter the pickup Address");
        return false;
      } else if (controller.PickupTelephone.text.isEmpty) {
        Toasty.showtoast("Please Enter the pickup TelePhone");
        return false;
      } else if (controller.Pickupinformation.text.isEmpty) {
        Toasty.showtoast("Please Enter the pickup Additional Information");
        return false;
      } else {
        return true;
      }
    }
  }

  bool dropoffvalidation() {
    if (controller.selectDropOffLocation == "Airport") {
      if (controller.selectDropoffAirport == null) {
        Toasty.showtoast("Please Select the Drop Off Airport");
        return false;
      } else {
        return true;
      }
    } else {
      if (controller.DropoffAddress.text.isEmpty) {
        Toasty.showtoast("Please Enter the Drop Off Address");
        return false;
      } else if (controller.DropoffTelephone.text.isEmpty) {
        Toasty.showtoast("Please Enter the picDrop Offkup TelePhone");
        return false;
      } else if (controller.Dropoffinformation.text.isEmpty) {
        Toasty.showtoast("Please Enter the Drop Off Additional Inforrmation");
        return false;
      } else {
        return true;
      }
    }
  }

  bool validation() {
    if (controller.multiPalCityList.length == 0) {
      Toasty.showtoast("Please Select City");
      return false;
    } else if (selectedCalenderDate == null) {
      Toasty.showtoast("Please Select Start Date");
      return false;
    } else if (selectedCalenderDateEndDate == null) {
      Toasty.showtoast("Please Select End Date");
      return false;
    } else if (controller.selectPickupTime == null) {
      Toasty.showtoast("Please Select Pick Up Time");
      return false;
    } else if (controller.selectPickupLocation == null) {
      Toasty.showtoast("Please Enter Pick Up Location");
      return false;
    } else if (pickupvalidation() == false) {
      // Toasty.showtoast("Please Enter Pick Up Location");
      return false;
    } else if (controller.selectDropTime == null) {
      Toasty.showtoast("Please Select Drop Off Time");
      return false;
    } else if (controller.selectDropOffLocation == null) {
      Toasty.showtoast("Please Enter Drop Off Location");
      return false;
    } else if (dropoffvalidation() == false) {
      // Toasty.showtoast("Please Enter Pick Up Location");
      return false;
    } else if (controller.phoneNumber.text.isEmpty) {
      Toasty.showtoast("Please Enter Phone Number");
      return false;
    } else if (controller.otherPhoneNumber.text.isEmpty) {
      Toasty.showtoast("Please Enter Other Phone Number");
      return false;
    } else {
      return true;
    }
  }
}

var totalDay;

var selectedCalenderDate;
var selectedCalenderDateEndDate;
// DateTime? selectStartDate;
// DateTime? selectEndDate;

class Calendar extends StatefulWidget {
  final pickUpTime, dropUpTime, bookingList;

  Calendar({
    startDate,
    endDate,
    this.pickUpTime,
    this.dropUpTime,
    this.bookingList,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<String> days = [];
  List date = [];
  List currentMonthData = [];
  List nextMonthData = [];
  List prevMonthData = [];
  List finalMonthData = [];
  List availabaleDate = [];

  var lastday = (DateTime.now().month < 12) ? new DateTime(DateTime.now().year, DateTime.now().month + 1, 0) : new DateTime(DateTime.now().year + 1, 1, 0);
  var month = DateTime.now().month;

  Color an(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(context).brightness == Brightness.light ? Colors.blue : Color(0xffE1A6AD);
      }
    }
    return Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent;
  }

  Color js(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
      }
    }
    return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
  }

  finalStep() {
    int nextMonthFirstMonday = getFirstMonday(nextMonthData);
    finalMonthData = [...finalMonthData, ...currentMonthData];
    for (int i = 0; i < nextMonthFirstMonday; i++) {
      finalMonthData.add(nextMonthData[i]);
    }
  }

  int getFirstMonday(List monthData) {
    int firstMondayAt = 0;
    final index = monthData.indexWhere((element) => element['day'] == 'Monday');
    if (index >= 0) {
      firstMondayAt = index;
    }
    return firstMondayAt;
  }

  letsFun() {
    prevMonthData.clear();
    for (DateTime indexDay = DateTime(month == 1 ? year - 1 : year, month == 1 ? 12 : month - 1, 1); indexDay.month == (month == 1 ? 12 : month - 1); indexDay = indexDay.add(Duration(days: 1))) {
      prevMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    for (DateTime indexDay = DateTime(year, month, 1);
        indexDay.month == month;
        indexDay = indexDay.add(
      Duration(days: 1),
    ),) {
      currentMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    // Next Month
    nextMonthData.clear();
    for (DateTime indexDay = DateTime(month == 12 ? year + 1 : year, month == 12 ? 1 : month + 1, 1); indexDay.month == (month == 12 ? 1 : month + 1); indexDay = indexDay.add(Duration(days: 1))) {
      nextMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }
  }

  getPreviousMonthLeadingDates() async {
    int prevDays = 0;
    int currMonthFirstMonday = getFirstMonday(currentMonthData);
    prevDays = 7 - currMonthFirstMonday;

    for (int i = 0; i < prevMonthData.length; i++) {
      if (currMonthFirstMonday != 0) {
        if (i == prevMonthData.length - prevDays) {
          prevDays--;
          finalMonthData.add(prevMonthData[i]);
        }
      }
    }
  }

  var day;
  final now = DateTime.now();

  hereWeGo() {
    letsFun();
    getPreviousMonthLeadingDates();
    finalStep();
  }

  int calculateTotalDays(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    print("on date is");
    Duration difference = endDate.difference(startDate);
    totalDay = difference.inDays + 1;
    print(totalDay);

    return difference.inDays;
  }

  @override
  void initState() {
    print(widget.bookingList);
    print("widget.bookingList");
    hereWeGo();
    day = DateTime(
      now.year,
      now.month,
      now.day,
    );
    super.initState();
  }

  var startDate = DateTime(DateTime.now().year, DateTime.now().month + 0, 1);
  var year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      prevMonthData.clear();
                      nextMonthData.clear();
                      currentMonthData.clear();
                      finalMonthData.clear();
                      if (month == 1) {
                        year = year - 1;
                        month = 12;
                      } else {
                        month = month - 1;
                      }
                      await hereWeGo();
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          child: Center(
                            child: Image.asset(
                              assetsUrl.arrowLeftCaleder,
                              scale: 3.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('MMMM,yyyy').format(DateTime.parse('$year-${month < 10 ? '0$month' : month}-01 00:00:00.000000')),
                  ),
                  InkWell(
                    onTap: () async {
                      prevMonthData.clear();
                      nextMonthData.clear();
                      currentMonthData.clear();
                      finalMonthData.clear();
                      if (month == 12) {
                        year = year + 1;
                        month = 1;
                      } else {
                        month = month + 1;
                      }
                      setState(() {});
                      await hereWeGo();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          child: Image.asset(
                            assetsUrl.arrowRightCaleder,
                            scale: 3.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Table(
                children: <TableRow>[
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "M",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "T",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "W",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "T",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "F",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "S",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "S",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < finalMonthData.length / 7; i++)
                    TableRow(
                      children: <Widget>[
                        for (int j = 0; j < 7; j++)
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: GestureDetector(
                              onTap: () async {
                                print(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00'));
                                if (widget.bookingList.contains(DateTime.parse("${finalMonthData[j + 7 * i]['full_date']}T00:00:00.000Z")) || DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) > 0) {
                                  print("enter");
                                } else {
                                  if (selectedCalenderDate == null) {
                                    print("iff");
                                    if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                      Toasty.showtoast("you can not select previews date");
                                    } else {
                                      setState(() {
                                        selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
                                      });
                                    }
                                  } else if (selectedCalenderDate != finalMonthData[j + 7 * i]['full_date'] && selectedCalenderDateEndDate != null) {
                                    if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                      Toasty.showtoast("you can not select previews date");
                                    } else {
                                      setState(() {
                                        selectedCalenderDateEndDate = null;
                                        selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'].toString();
                                      });
                                    }
                                  } else {
                                    print('utsav satani');
                                    if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                      Toasty.showtoast("you can not select previews date");
                                    } else {
                                      if (DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')) == false) {
                                        var startDate = "${finalMonthData[j + 7 * i]['full_date']} 00:00:00.000Z";
                                        var endDate = "${selectedCalenderDate} 00:00:00.000Z";
                                        print(endDate);
                                        print(startDate);
                                        var days = [];
                                        for (int i = 0; i <= DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays; i++) {
                                          if (days.contains(DateTime.parse(startDate).add(Duration(days: i)))) {
                                          } else {
                                            days.add(DateTime.parse(startDate).add(Duration(days: i)));
                                          }
                                        }
                                        bool containDays = false;

                                        for (var day in days) {
                                          print('day');
                                          if (widget.bookingList.contains(day)) {
                                            print('if');
                                            containDays = true;
                                            break;
                                          }
                                        }
                                        if (containDays == true) {
                                          Toasty.showtoast('This car already booked for this days.');
                                        } else {
                                          print("already booked else part ");
                                          setState(() {
                                            selectedCalenderDateEndDate = selectedCalenderDate;
                                            selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
                                          });
                                          calculateTotalDays(DateTime.parse(selectedCalenderDate), DateTime.parse(selectedCalenderDateEndDate));
                                        }
                                      } else {
                                        var endDate = "${finalMonthData[j + 7 * i]['full_date']} 00:00:00.000Z";
                                        var startDate = "${selectedCalenderDate} 00:00:00.000Z";
                                        var days = [];
                                        for (int i = 0; i <= DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays; i++) {
                                          if (days.contains(DateTime.parse(startDate).add(Duration(days: i)))) {
                                          } else {
                                            days.add(DateTime.parse(startDate).add(Duration(days: i)));
                                          }
                                        }
                                        bool containDays = false;

                                        for (var day in days) {
                                          print('day');
                                          if (widget.bookingList.contains(day)) {
                                            print('if');
                                            containDays = true;
                                            break;
                                          }
                                        }
                                        if (containDays == true) {
                                          Toasty.showtoast('This car already booked for this days.');
                                        } else {
                                          print("this else part");
                                          setState(() {
                                            selectedCalenderDateEndDate = finalMonthData[j + 7 * i]['full_date'];
                                            calculateTotalDays(DateTime.parse(selectedCalenderDate), DateTime.parse(selectedCalenderDateEndDate));
                                          });
                                        }
                                      }
                                    }
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: selectedCalenderDate == finalMonthData[j + 7 * i]['full_date'] || selectedCalenderDateEndDate == finalMonthData[j + 7 * i]['full_date']
                                      ? Theme.of(context).brightness == Brightness.light
                                          ? color.appColor
                                          : Color(0xffE1A6AD)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      finalMonthData[j + 7 * i]['date'].toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) > 0
                                              ? Colors.grey
                                              : widget.bookingList.contains(DateTime.parse("${finalMonthData[j + 7 * i]['full_date']}T00:00:00.000Z")) == true
                                                  ? Colors.red
                                                  : Colors.black),
                                      //style: TextStyle(color: DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) < 0 ? Colors.black : Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                commonWidget.mediumText(
                  stringsUtils.StartDate,
                  fontsize: 15.0,
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: color.appColor,
                    ),
                  ),
                  child: Center(
                    child: commonWidget.regularText(
                      selectedCalenderDate == null ? "Select Start Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDate)),
                      fontsize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 20),
            Column(
              children: [
                commonWidget.mediumText(
                  stringsUtils.EndDate,
                  fontsize: 15.0,
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: color.appColor,
                    ),
                  ),
                  child: Center(
                    child: commonWidget.regularText(
                      selectedCalenderDateEndDate == null ? "Select End Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDateEndDate)),
                      fontsize: 14.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),

        // Text('${selectedCalenderDate}  ${selectedCalenderDateEndDate}'),
      ],
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    print((to.difference(from).inHours / 24).round());
    print('utsav satami');
    return (to.difference(from).inHours / 24).round();
  }

  DateTime selectedDate = DateTime.now();
}

// class Calendar extends StatefulWidget {
//   const Calendar({Key? key}) : super(key: key);
//
//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   List<String> days = [];
//   List date = [];
//   List currentMonthData = [];
//   List nextMonthData = [];
//   List prevMonthData = [];
//   List finalMonthData = [];
//   List totalDayList = [];
//
//   var lastday = (DateTime.now().month < 12) ? new DateTime(DateTime.now().year, DateTime.now().month + 1, 0) : new DateTime(DateTime.now().year + 1, 1, 0);
//   var month = DateTime.now().month;
//
//   Color an(var ank) {
//     for (var i in days) {
//       if (i == ank) {
//         return Theme.of(context).brightness == Brightness.light ? Colors.blue : Color(0xffE1A6AD);
//       }
//     }
//     return Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent;
//   }
//
//   Color js(var ank) {
//     for (var i in days) {
//       if (i == ank) {
//         return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
//       }
//     }
//     return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
//   }
//
//   finalStep() {
//     int nextMonthFirstMonday = getFirstMonday(nextMonthData);
//     finalMonthData = [...finalMonthData, ...currentMonthData];
//     for (int i = 0; i < nextMonthFirstMonday; i++) {
//       finalMonthData.add(nextMonthData[i]);
//     }
//   }
//
//   int getFirstMonday(List monthData) {
//     int firstMondayAt = 0;
//     final index = monthData.indexWhere((element) => element['day'] == 'Monday');
//     if (index >= 0) {
//       firstMondayAt = index;
//     }
//     return firstMondayAt;
//   }
//
//   letsFun() {
//     prevMonthData.clear();
//     for (DateTime indexDay = DateTime(month == 1 ? year - 1 : year, month == 1 ? 12 : month - 1, 1); indexDay.month == (month == 1 ? 12 : month - 1); indexDay = indexDay.add(Duration(days: 1))) {
//       prevMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
//     }
//
//     for (DateTime indexDay = DateTime(year, month, 1);
//         indexDay.month == month;
//         indexDay = indexDay.add(
//       Duration(days: 1),
//     ),) {
//       currentMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
//     }
//
//     // Next Month
//     nextMonthData.clear();
//     for (DateTime indexDay = DateTime(month == 12 ? year + 1 : year, month == 12 ? 1 : month + 1, 1); indexDay.month == (month == 12 ? 1 : month + 1); indexDay = indexDay.add(Duration(days: 1))) {
//       nextMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
//     }
//   }
//
//   getPreviousMonthLeadingDates() async {
//     int prevDays = 0;
//     int currMonthFirstMonday = getFirstMonday(currentMonthData);
//     prevDays = 7 - currMonthFirstMonday;
//
//     for (int i = 0; i < prevMonthData.length; i++) {
//       if (currMonthFirstMonday != 0) {
//         if (i == prevMonthData.length - prevDays) {
//           prevDays--;
//           finalMonthData.add(prevMonthData[i]);
//         }
//       }
//     }
//   }
//
//   var day;
//   final now = DateTime.now();
//
//   hereWeGo() {
//     letsFun();
//     getPreviousMonthLeadingDates();
//     finalStep();
//   }
//
//   var CalenderDay;
//
//   @override
//   void initState() {
//     hereWeGo();
//     day = DateTime(
//       now.year,
//       now.month,
//       now.day,
//     );
//     super.initState();
//   }
//
//   var startDate = DateTime(DateTime.now().year, DateTime.now().month + 0, 1);
//   var year = DateTime.now().year;
//
//   int calculateTotalDays(DateTime startDate, DateTime endDate) {
//     // Calculate the difference between end date and start date
//     Duration difference = endDate.difference(startDate);
//
//     print(difference.inDays);
//     // Return the total days as an integer
//     return difference.inDays;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Container(
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       prevMonthData.clear();
//                       nextMonthData.clear();
//                       currentMonthData.clear();
//                       finalMonthData.clear();
//                       if (month == 1) {
//                         year = year - 1;
//                         month = 12;
//                       } else {
//                         month = month - 1;
//                       }
//                       await hereWeGo();
//                       setState(() {});
//                     },
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 25,
//                           width: 25,
//                           padding: EdgeInsets.only(left: 10),
//                           child: Center(
//                             child: Image.asset(
//                               assetsUrl.arrowLeftCaleder,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     DateFormat('MMMM,yyyy').format(DateTime.parse('$year-${month < 10 ? '0$month' : month}-01 00:00:00.000000')),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       prevMonthData.clear();
//                       nextMonthData.clear();
//                       currentMonthData.clear();
//                       finalMonthData.clear();
//                       if (month == 12) {
//                         year = year + 1;
//                         month = 1;
//                       } else {
//                         month = month + 1;
//                       }
//                       setState(() {});
//                       await hereWeGo();
//                     },
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 25,
//                           width: 25,
//                           padding: EdgeInsets.only(right: 10),
//                           child: Image.asset(
//                             assetsUrl.arrowRightCaleder,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Table(
//                 children: <TableRow>[
//                   TableRow(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.transparent),
//                     ),
//                     children: <Widget>[
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "M",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "T",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "W",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "T",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "F",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "S",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         verticalAlignment: TableCellVerticalAlignment.top,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           width: MediaQuery.of(context).size.width / 7,
//                           child: Text(
//                             "S",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   for (int i = 0; i < finalMonthData.length / 7; i++)
//                     TableRow(
//                       children: <Widget>[
//                         for (int j = 0; j < 7; j++)
//                           TableCell(
//                             verticalAlignment: TableCellVerticalAlignment.top,
//                             child: GestureDetector(
//                               onTap: () async {
//                                 // print(DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00') ));
//                                 if (selectedCalenderDate == null) {
//                                   setState(() {
//                                     selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
//                                   });
//                                 } else if (selectedCalenderDate != finalMonthData[j + 7 * i]['full_date'] && selectedCalenderDateEndDate != null) {
//                                   setState(() {
//                                     selectedCalenderDateEndDate = null;
//                                     selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
//                                   });
//                                 } else {
//                                   print(DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')));
//                                   if (DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')) == false) {
//                                     setState(() {
//                                       selectedCalenderDateEndDate = selectedCalenderDate;
//                                       selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
//                                     });
//                                     if (daysBetween(DateTime.parse('${selectedCalenderDate} 00:00:00'), DateTime.parse('${selectedCalenderDateEndDate} 00:00:00')) > 7) {
//                                       setState(() {
//                                         selectedCalenderDate = null;
//                                       });
//                                     }
//                                   } else {
//                                     if (daysBetween(DateTime.parse('${selectedCalenderDate} 00:00:00'), DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')) > 7) {
//                                       // Toasty.showtoast("you cannot select car more then 7 days");
//                                       showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return Dialog(
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
//                                                 child: Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     SizedBox(height: 5),
//                                                     commonWidget.semiBoldText(
//                                                       "You can Rent a car for a maximum of Seven days",
//                                                       fontsize: 16.0,
//                                                       textAlign: TextAlign.center,
//                                                     ),
//                                                     SizedBox(height: 12),
//                                                     Divider(
//                                                       color: Colors.grey.withOpacity(.4),
//                                                       thickness: 1.0,
//                                                     ),
//                                                     SizedBox(height: 12),
//                                                     commonWidget.customButton(
//                                                       onTap: () {
//                                                         Get.back();
//                                                       },
//                                                       height: 48.0,
//                                                       textfontsize: 16.0,
//                                                       text: "Ok",
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                     } else {
//                                       setState(() {
//                                         selectedCalenderDateEndDate = finalMonthData[j + 7 * i]['full_date'];
//                                         print(selectedCalenderDate);
//                                         print(selectedCalenderDateEndDate);
//
//                                         calculateTotalDays(selectedCalenderDate, selectedCalenderDateEndDate);
//                                       });
//                                     }
//                                   }
//                                 }
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
//                                 width: MediaQuery.of(context).size.width / 7,
//                                 height: MediaQuery.of(context).size.height * 0.05,
//                                 decoration: BoxDecoration(
//                                   // border: Border.all(
//                                   //     color: finalMonthData[j + 7 * i]['full_date'].toString() == DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
//                                   //         ? Theme.of(context).brightness == Brightness.light
//                                   //             ? Colors.green
//                                   //             : Color(0xffE1A6AD)
//                                   //         : Colors.transparent),
//                                   color: selectedCalenderDate == finalMonthData[j + 7 * i]['full_date'] || selectedCalenderDateEndDate == finalMonthData[j + 7 * i]['full_date']
//                                       ? Theme.of(context).brightness == Brightness.light
//                                           ? color.appColor
//                                           : Color(0xffE1A6AD)
//                                       : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       finalMonthData[j + 7 * i]['date'].toString(),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                 ],
//               ),
//             ],
//           ),
//           margin: EdgeInsets.only(left: 15, right: 15),
//           decoration: BoxDecoration(
//             color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 commonWidget.mediumText(
//                   stringsUtils.StartDate,
//                   fontsize: 15.0,
//                 ),
//                 SizedBox(height: 7),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(
//                       color: color.appColor,
//                     ),
//                   ),
//                   child: Center(
//                     child: commonWidget.regularText(
//                       selectedCalenderDate == null ? "Select Start Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDate)),
//                       fontsize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(width: 20),
//             Column(
//               children: [
//                 commonWidget.mediumText(
//                   stringsUtils.EndDate,
//                   fontsize: 15.0,
//                 ),
//                 SizedBox(height: 7),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     border: Border.all(
//                       color: color.appColor,
//                     ),
//                   ),
//                   child: Center(
//                     child: commonWidget.regularText(
//                       selectedCalenderDateEndDate == null ? "Select End Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDateEndDate)),
//                       fontsize: 14.0,
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   int daysBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     print((to.difference(from).inHours / 24).round());
//     print('utsav satami');
//     return (to.difference(from).inHours / 24).round();
//   }
//
//   DateTime selectedDate = DateTime.now();
// }
