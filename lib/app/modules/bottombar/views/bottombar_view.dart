import 'package:autotomi/app/modules/home/views/home_view.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottombar_controller.dart';

class BottombarView extends GetView<BottombarController> {
  const BottombarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottombarController controller = Get.put(BottombarController());
    return GetBuilder<BottombarController>(
      assignId: true,
      init: BottombarController(),
      builder: (logic) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 58,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    controller.bottomItems.length,
                    (index) => Obx(() {
                      return Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (box.read('user_id') == 0) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: hw.height * 0.016),
                                            commonWidget.semiBoldText('Whoops, you need an account to do that', fontsize: 16.0, textAlign: TextAlign.center, height: 1.5),
                                            SizedBox(height: hw.height * 0.016),
                                            Divider(),
                                            SizedBox(height: hw.height * 0.016),
                                            commonWidget.customButton(
                                              onTap: () {
                                                Get.offAll(() => LoginView());
                                              },
                                              height: 48.0,
                                              text: "Signup or Signin",
                                              textfontsize: 16.0,
                                            ),
                                            SizedBox(height: hw.height * 0.030),
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              splashColor: color.transparent,
                                              highlightColor: color.transparent,
                                              child: Container(
                                                width: hw.width,
                                                height: 30.0,
                                                child: Center(child: commonWidget.semiBoldText('Later', fontsize: 16.0)),
                                              ),
                                            ),
                                            SizedBox(height: hw.height * 0.020),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              isReturnCar = 0;
                              controller.pageSelected.value = index;
                              controller.update();
                            }
                          },
                          child: Image.asset(
                            controller.bottomItems[index],
                            height: 23,
                            width: 23,
                            color: controller.pageSelected.value == index ? Color(0xff41975D) : Color(0xffC9C9C9),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          body: Obx(() {
            return controller.bottomBarWidget[controller.pageSelected.value];
          }),
        );
      },
    );
  }
}
