import 'package:autotomi/app/modules/payment_method/views/payment_method_view.dart';
import '../controllers/card_details_controller.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailsView extends GetView<CardDetailsController> {
  const CardDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardDetailsController controller = Get.put(CardDetailsController());
    return GetBuilder<CardDetailsController>(
      assignId: true,
      init: CardDetailsController(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: color.white,
          appBar: commonWidget.customAppbar(
            fontsize: 20.0,
            arroOnTap: () {
              Get.back();
            },
            titleText: 'Terms & Conditions',
            actions: SizedBox(),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        commonWidget.regularText('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', fontsize: 14.0, height: 2.0),
                        SizedBox(height: hw.height * 0.05),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: color.appColor,
                                value: controller.isChecked.value,
                                onChanged: (value) {
                                  controller.toggleCheckbox(value!);
                                },
                              ),
                            ),
                            commonWidget.mediumText('Agreement Policy', fontsize: 15.0),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: commonWidget.regularText('I hereby agree to the terms and condition of the Lease Agreement with Host.', overflow: TextOverflow.ellipsis, fontsize: 12.0, maxLines: 2),
                        ),
                        SizedBox(height: Get.height * 0.1),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                commonWidget.customButton(
                  onTap: () {
                    if (controller.isChecked.value == true) {
                      Get.to(
                        () => PaymentMethodView(),
                        arguments: {
                          'flag': controller.flag,
                          'car_id': controller.carID,
                          'booking_id': controller.bookingID,
                          'car_image': controller.carImage,
                          'car_name': controller.carName,
                          'start_date': controller.startDate,
                          'pick_time': controller.pickUpTime,
                          'end_date': controller.endDate,
                          'drop_time': controller.dropTime,
                          'fare_unlimited_kms': controller.totalFare,
                          'damage_protection_fee': controller.damageProtectionFee,
                          'convenience_fee': controller.convenienceFee,
                          'total_fare': controller.totalFare,
                          'security_deposit': controller.securityDeposit,
                          'final_fare': controller.finalFare,
                          'is_payment': 0,
                          'bring_car_me': controller.bringCarMe,
                          'come_pickup_car': controller.comePickupCar,
                        },
                      );
                    } else {
                      Toasty.showtoast("please check Agreement Policy");
                    }
                  },
                  text: 'Continue',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
