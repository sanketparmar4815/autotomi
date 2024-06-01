import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bookimgcar/views/bookimgcar_view.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookimgcarController extends GetxController {
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController PickupAddress = TextEditingController();
  TextEditingController PickupTelephone = TextEditingController();
  TextEditingController Pickupinformation = TextEditingController();
  TextEditingController dropOffLocation = TextEditingController();
  TextEditingController Dropoffinformation = TextEditingController();
  TextEditingController DropoffTelephone = TextEditingController();
  TextEditingController DropoffAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otherPhoneNumber = TextEditingController();

  var selectedCountryCodeOther = "234", selectedCountryCode = "234";
  var selectedPickupCountryCode = "234", selectedDropOffCountryCode = "234";
  var isoCodeOther = "1", isoCode = "1";

  var selectedDateRange, finalDate, totalPrice;

  var time2, carID, perDayPrice, perWeekPrice, totalAmount, percentage, countWeek, totalWeek, totalDay, totalDayAmount, totalWeekAmount, currentDate;
  var selectPickupTime, selectDropTime, isLoading = false.obs;
  List multiPalCityList = [].obs;
  List multiPalCityIDList = [].obs;

  var countryId;
  var countryName;
  String? selectCounty;
  List<String> countyList = [];

  String? selectPickupLocation;
  List<String> selectPickupLocations = [
    'Airport',
    'BRING THE CAR TO ME(attract additional cost £10)',
  ];
  String? selectDropOffLocation;
  List<String> selectDropOffLocations = [
    'Airport',
    'Come and pick up the car(attract additional cost £10)',
  ];

  var selectCity;
  var selectPickupAirport;
  var selectDropoffAirport, securityDeposite;

  RxList cityList = [].obs;
  RxList airportList = [].obs;
  @override
  Future<void> onInit() async {
    print(box.read('country_name_filter'));
    print(box.read('country_name'));
    print("vp");
    if (box.read('country_name_filter') != null) {
      countryName = box.read('country_name_filter');
      countryId = box.read('country_id_filter');
      selectedCountryCode = box.read('country_visiting_code_filter');
      selectedCountryCodeOther = box.read('country_visiting_code_filter');
      selectedPickupCountryCode = box.read('country_visiting_code_filter');
      selectedDropOffCountryCode = box.read('country_visiting_code_filter');
    } else {
      countryName = box.read('country_visiting');
      countryId = box.read('country_id');
      selectedCountryCode = box.read('country_visiting_code');
      selectedCountryCodeOther = box.read('country_visiting_code');
      selectedPickupCountryCode = box.read('country_visiting_code');
      selectedDropOffCountryCode = box.read('country_visiting_code');
      print(countryName);
      print(countryId);
      print(selectedCountryCode);
      print(box.read('country_visiting_code'));
      print("code_home");
      print("how are you");
    }

    if (Get.arguments != null) {
      carID = Get.arguments['car_id'];
      perDayPrice = Get.arguments['price_day'];
      perWeekPrice = Get.arguments['price_week'];
      securityDeposite = Get.arguments['security_deposite'];

      print(carID);
      print("carID");
      print(perDayPrice);
      print(perWeekPrice);
    }

    await list_userwise_city();
    await list_airport();
    await checkBookingAvailability();
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

  bookingCar_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_booking",
      method: MethodType.Post,
      params: {
        'car_id': carID,
        'start_date': selectedCalenderDate,
        'end_date': selectedCalenderDateEndDate,
        'pickup_time': selectPickupTime.toString().split(' ').first,
        'pickup_location': selectPickupLocation,
        'bring_car_me': selectPickupLocation == "BRING THE CAR TO ME(attract additional cost £10)" ? 10 : 0,
        'pickup_lat': -103.231018,
        'pickup_long': -103.231018,
        'dropoff_time': selectDropTime.toString().split(' ').first,
        'dropoff_location': selectDropOffLocation,
        'come_pickup_car': selectDropOffLocation == "Come and pick up the car(attract additional cost £10)" ? 10 : 0,
        'dropoff_lat': 21.170240,
        'dropoff_long': 72.831062,
        'country_code': selectedCountryCode.toString(),
        'phone_number': phoneNumber.text,
        'other_country_code': selectedCountryCodeOther.toString(),
        'other_phone_number': otherPhoneNumber.text,
        'total_fare': totalAmount,
        "city_id": multiPalCityIDList.join(","),
        "country_id": countryId,
        "pickup_airport_id": selectPickupAirport ?? 0,
        "pickup_address": PickupAddress.text,
        "pickup_phone_number": PickupTelephone.text,
        "pickup_country_code": selectedPickupCountryCode,
        "pickup_additional_info": Pickupinformation.text,
        "dropoff_airport_id": selectDropoffAirport ?? 0,
        "dropoff_address": DropoffAddress.text,
        "dropoff_phone_number": DropoffTelephone.text,
        "dropoff_country_code": selectedDropOffCountryCode,
        "dropoff_additional_info": Dropoffinformation.text,
        "security_deposit": securityDeposite,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.toNamed(Routes.BOOKIMGSUCCESS, arguments: response['booking_id']);
        } else {
          Toasty.showtoast(response['Message']);
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  list_userwise_city() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_userwise_city",
      method: MethodType.Post,
      params: {
        'country_id': countryId,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          // countruId = response['country_id'];
          // countryName = response['country'];
          cityList.value = response['info'];
          // Get.toNamed(Routes.BOOKIMGSUCCESS, arguments: response['booking_id']);
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  list_airport() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_airport",
      method: MethodType.Post,
      params: {
        'country_id': countryId,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          airportList.value = response['info'];

          // Get.toNamed(Routes.BOOKIMGSUCCESS, arguments: response['booking_id']);
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  List bookingCarList = [];
  List<DateTime> days = [];

  checkBookingAvailability() {
    print(carID);
    print("carID");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "check_booking_availability",
      method: MethodType.Post,
      params: {
        'car_id': carID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          bookingCarList = response['info'];
          print(bookingCarList);

          for (var j = 0; j < bookingCarList.length; j++) {
            print(bookingCarList[j]['end_date']);
            print(bookingCarList[j]['start_date']);
            for (int i = 0; i <= DateTime.parse(bookingCarList[j]['end_date']).difference(DateTime.parse(bookingCarList[j]['start_date'])).inDays; i++) {
              if (days.contains(DateTime.parse(bookingCarList[j]['start_date']).add(Duration(days: i)))) {
              } else {
                days.add(DateTime.parse(bookingCarList[j]['start_date']).add(Duration(days: i)));
              }
            }
            print(days);
            print('days');
          }

          print("avalubaler Date");
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);
        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }

  EndTime(BuildContext context, {flag}) async {
    time2 = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.light
              ? ThemeData.from(colorScheme: ColorScheme.light())
              : ThemeData.from(
                  colorScheme: ColorScheme.dark(),
                ),
          child: child!,
        );
      },
    );
    if (flag == 1) {
      selectPickupTime = DateFormat('HH:mm:ss').format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time2.hour,
          time2.minute,
        ),
      );
      print(selectPickupTime);
      print('selectPickupTime');
    } else {
      selectDropTime = DateFormat('HH:mm:ss').format(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          time2.hour,
          time2.minute,
        ),
      );
    }

    update();
  }

// var latitude;
// var longitude;
// Future<void> getLatLngFromAddress() async {
//   if (pickUpLocation.text.isNotEmpty) {
//     print(pickUpLocation.text);
//     List<Location> locations = await locationFromAddress(pickUpLocation.text);
//     print("location lenght ${locations.length}");
//     if (locations.isNotEmpty) {
//       latitude = locations[0].latitude.toString();
//       longitude = locations[0].longitude.toString();
//
//       print('Latitude: $latitude');
//       print('Longitude: $longitude');
//     } else {
//       print('No coordinates found for the given address.');
//       longitude = 0.0;
//       longitude = 0.0;
//     }
//   } else {
//     print("pick up Addres  is Empty");
//   }
// }
}
