import 'package:animate_do/animate_do.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../bottombar/views/bottombar_view.dart';
import '../controllers/personal_info4_controller.dart';

class PersonalInfo4View extends GetView<PersonalInfo4Controller> {
  const PersonalInfo4View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfo4Controller>(
      assignId: true,
      init: PersonalInfo4Controller(),
      builder: (logic) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElasticIn(
                        child: ElasticIn(
                          duration: Duration(seconds: 5),
                          child: Center(
                            child: Image.asset(assetsUrl.success, height: 165, width: 165),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ZoomIn(child: commonWidget.semiBoldText(stringsUtils.thanks, fontsize: 16.0, textAlign: TextAlign.center)),
                      SizedBox(height: 15),
                      Center(child: ZoomIn(child: commonWidget.mediumText(stringsUtils.your_Profile, fontsize: 12.0, textAlign: TextAlign.center))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: commonWidget.customButton(
                  onTap: () {
                    if (controller.flag == 1) {
                      Get.offAll(() => BottombarView());
                    } else {
                      Get.offAll(() => BottombarView(), arguments: 3);
                    }
                  },
                  text: stringsUtils.done,
                ),
              ),
              SizedBox(height: hw.height * 0.025),
            ],
          ),
        );
      },
    );
  }
}
