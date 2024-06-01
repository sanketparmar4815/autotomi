import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bookimgsuccess_controller.dart';

class BookimgsuccessView extends GetView<BookimgsuccessController> {
  const BookimgsuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookimgsuccessController>(
        init: BookimgsuccessController(),
        builder: (logic) {
          return Scaffold(
              body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        assetsUrl.bookingSuccesssIcon,
                        height: 115,
                        width: 115,
                      ),
                      SizedBox(height: 25),
                      commonWidget.semiBoldText(
                        stringsUtils.BookingSuccessfully,
                        fontsize: 24.0,
                      ),
                      SizedBox(height: 20),
                      commonWidget.mediumText(
                        stringsUtils.Yourbookinghas,
                        fontsize: 16.0,
                      ),
                      SizedBox(height: 20),
                      commonWidget.semiBoldText(
                        "${stringsUtils.Bookingid} : ${controller.bookingID}",
                        fontsize: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: commonWidget.customButton(
                    onTap: () {
                      Get.offAllNamed(Routes.BOTTOMBAR, arguments: 1);
                    },
                    height: 48.0,
                    text: stringsUtils.Done,
                    textfontsize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ));
        });
  }
}
