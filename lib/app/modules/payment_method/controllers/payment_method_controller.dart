import 'dart:convert';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/buyMoreTime/views/buy_more_time_view.dart';
import 'package:autotomi/app/modules/payment_successfull/views/payment_successfull_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  TextEditingController applyCoupon = TextEditingController();

  List list = [
    {'name': 'Rented For', 'price': '1 Day'},
    {'name': 'Fare(Unlimited Kms without Fuel)', 'price': '£100'},
    {'name': 'Damage Protection Fee', 'price': '+£30'},
    {'name': 'Convenience Fee', 'price': '+£30'},
    {'name': 'Total Fare', 'price': '£160'},
    {'name': 'Security Deposit', 'price': '+£130'},
    {'name': 'Final Fare', 'price': '£290'},
  ];
  var addCoupon = 0.0, bringCarMe, comePickupCar, totalDay, carID, couponCode, couponID, couponDiscount, percentageAmount, returnOfferFlag, discountAmountOnlShow;
  var isLoading = false.obs, showTotalFare, showFinalFare, extraDay, extraPrice, totalFinalFare, isPayment, returnFlag, customerId, ephemeralKeySecret, chargeID, clientSecretKey;
  var flag, carImage, carName, starCount, reviewCount, startDate, pickUpTime, endDate, dropTime, fareUnlimitedKms, damageProtectionFee, convenienceFee, totalFare, securityDeposit, finalFare, bookingID;
  @override
  void onInit() {
    if (Get.arguments != null) {
      flag = Get.arguments['flag'];

      carID = Get.arguments['car_id'];
      bookingID = Get.arguments['booking_id'];
      carImage = Get.arguments['car_image'];
      carName = Get.arguments['car_name'];
      starCount = Get.arguments['star_count'];
      reviewCount = Get.arguments['review_count'];
      startDate = Get.arguments['start_date'];
      pickUpTime = Get.arguments['pick_time'];
      endDate = Get.arguments['end_date'];
      dropTime = Get.arguments['drop_time'];
      fareUnlimitedKms = Get.arguments['fare_unlimited_kms'];
      damageProtectionFee = Get.arguments['damage_protection_fee'];
      convenienceFee = Get.arguments['convenience_fee'];
      totalFare = Get.arguments['total_fare'];
      securityDeposit = Get.arguments['security_deposit'];
      finalFare = Get.arguments['final_fare'];
      extraDay = Get.arguments['extra_day'];
      extraPrice = Get.arguments['extra_price'];
      isPayment = Get.arguments['is_payment'];
      returnFlag = Get.arguments['return_flag'];
      bringCarMe = Get.arguments['bring_car_me'];
      comePickupCar = Get.arguments['come_pickup_car'];
      discountAmountOnlShow = Get.arguments['discount_amount'];
      couponID = Get.arguments['coupon_id'];
    }

    print(couponID);
    print("bringCarMe");
    showTotalFare = fareUnlimitedKms + damageProtectionFee + convenienceFee + bringCarMe + comePickupCar;
    showFinalFare = showTotalFare + securityDeposit;
    print(showFinalFare);
    print("showFinalFare");

    print(carID);
    print("carID");
    if (flag == 5) {
      totalFinalFare = showFinalFare + extraPrice;
    }
    calculateTotalDays(DateTime.parse(startDate), DateTime.parse(endDate));
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

  Map<String, dynamic>? paymentIntentData;
  createPaymentIntent(String amount, String currency) async {
    final price = int.parse(amount) * 100;
    print(price);
    print('amount');
    try {
      Map<String, dynamic> body = {
        'amount': price.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51NYexcIXNJMZ1R8Q8i2pQWnrKe2CPKTkOmPe8CZlDCvGpDWg5bO5qF4IKs3XX5psOl7f4XV9BBZ6t9v2mWzbLZ4F00sUYt8VQk',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        makePayment_Api();
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: Get.context!,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment() async {
    isLoading.value = true;
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        merchantDisplayName: 'Prospects',
        customerId: customerId,
        allowsDelayedPaymentMethods: false,
        paymentIntentClientSecret: clientSecretKey,
        customerEphemeralKeySecret: ephemeralKeySecret,
      ));
      isLoading.value = false;

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      isLoading.value = false;
      print('exception:$e$s');
    }
    isLoading.value = false;
  }

  makePayment_Api() {
    print(bookingID);
    print("bookingID");
    print(showFinalFare);
    print("showFinalFare");
    print(extraPrice);
    print("extraPrice");
    print(isPayment);
    print("isPayment");
    print(couponID);
    print("couponID");
    print(addCoupon);
    print("addCoupon");
    print(discountAmountOnlShow);
    print("discountAmountOnlShow");
    print(extraDay);
    print("make payment api");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "make_payment",
      method: MethodType.Post,
      params: {
        "booking_id": bookingID,
        'transaction_amount': flag == 5 ? extraPrice : showFinalFare,
        'charge_id': chargeID,
        'is_payment': isPayment,
        'coupon_id': couponID == null ? 0 : couponID,
        'discount_amount': flag == 5 ? discountAmountOnlShow : addCoupon,
        'days': isPayment == 1 ? extraDay : 0,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          flag == 5
              ? addMoreTime_Api()
              : Get.to(() => PaymentSuccessfullView(), arguments: {
                  'final_fare': flag == 5 ? extraPrice : showFinalFare,
                  'return_flag': returnFlag,
                  'booking_id': bookingID,
                });

          Toasty.showtoast(response['Message']);
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

  createPaymentIntent_Api() {
    print("createPaymentIntent_Api start");
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "create_paymentintent",
      method: MethodType.Post,
      params: {
        "amount": flag == 5 ? extraPrice : showFinalFare,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          customerId = response['customer_id'];
          ephemeralKeySecret = response['ephemeralKeySecret'];
          chargeID = response['info']['id'];
          clientSecretKey = response['info']['client_secret'];
          print(chargeID);
          print("chargeID");
          makePayment();
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

  addMoreTime_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "add_more_time",
      method: MethodType.Post,
      params: {
        "end_date": selectedCalenderDateEndDateMoreTime,
        'dropoff_time': dropTime.toString().split(' ').first,
        'booking_id': bookingID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          Get.to(() => PaymentSuccessfullView(), arguments: {
            'final_fare': flag == 5 ? extraPrice : showFinalFare,
            'return_flag': returnFlag,
            'booking_id': bookingID,
          });
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

  applyCouponCode_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "apply_coupon_code",
      method: MethodType.Post,
      params: {
        'booking_id': bookingID,
        'coupon_code': applyCoupon.text,
        'car_id': carID,
      },
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
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

  int calculateTotalDays(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    Duration difference = endDate.difference(startDate);
    totalDay = difference.inDays + 1;
    print(totalDay);
    print("total day");
    return difference.inDays;
  }
}
