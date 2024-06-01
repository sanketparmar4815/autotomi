import '../controllers/add_card_controller.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardView extends GetView<AddCardController> {
  const AddCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.white,
      appBar: commonWidget.customAppbar(
        fontsize: 20.0,
        arroOnTap: () {
          Get.back();
        },
        titleText: 'Add Card',
        actions: SizedBox(),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: hw.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonWidget.mediumText('Enter card Details', fontsize: 15.0),
                        Image.asset(assetsUrl.shield, height: 36, width: 36),
                      ],
                    ),
                    SizedBox(height: hw.height * 0.025),
                    commonWidget.customTextfield(
                      hintText: 'Card Number',
                      label: 'Card Holder Name',
                    ),
                    SizedBox(height: hw.height * 0.016),
                    commonWidget.customTextfield(
                      hintText: '0000 0000 0000 0000',
                      label: 'Card Number',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: hw.height * 0.016),
                    Row(
                      children: [
                        Expanded(
                          child: commonWidget.customTextfield(
                            hintText: 'MM/YY',
                            label: 'Expiry',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: commonWidget.customTextfield(
                            hintText: 'CVV',
                            label: 'CVV',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: commonWidget.customButton(
              onTap: () {
                Get.back();
              },
              text: stringsUtils.save,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
