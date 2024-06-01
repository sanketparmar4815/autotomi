import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/all_car_rating_review_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarRatingReviewView extends GetView<AllCarRatingReviewController> {
  const AllCarRatingReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllCarRatingReviewController controller = Get.put(AllCarRatingReviewController());
    return GetBuilder<AllCarRatingReviewController>(
        init: AllCarRatingReviewController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: commonWidget.customAppbar(
                  centerTitle: true,
                  arroOnTap: () {
                    Get.back();
                  },
                  backgroundColor: Colors.white,
                  titleText: "Review & Rating",
                  actions: SizedBox(),
                ),
                body: Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0, top: 20),
                  child: controller.allRatingReviewList.length == 0 && controller.isLoading.value == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height * 0.35,
                            ),
                            Center(
                              child: commonWidget.mediumText(
                                "No Data Found",
                                fontsize: 18.0,
                                tcolor: Colors.black,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          controller: controller.scroll_controller,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.allRatingReviewList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(0xffFAFBFC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonWidget.regularText(
                                    "${controller.allRatingReviewList[index].reviewText ?? ""}",
                                    fontsize: 14.0,
                                  ),
                                  SizedBox(height: 8),
                                  commonWidget.regularText(
                                    "Booking id: ${controller.allRatingReviewList[index].bookingId ?? ""}",
                                    fontsize: 14.0,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      RatingBar(
                                        ignoreGestures: true,
                                        ratingWidget: RatingWidget(
                                          // full: Icon(Icons.star, color: Colors.amber),
                                          full: Image.asset(assetsUrl.starRatingImage),
                                          half: Image.asset(assetsUrl.starRatingBlank),
                                          empty: Image.asset(assetsUrl.starRatingBlank),
                                        ),
                                        initialRating: controller.allRatingReviewList[index].noOfStar!.toDouble(),
                                        minRating: 0,
                                        itemSize: 14,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        updateOnDrag: false,
                                        itemCount: 5,
                                        unratedColor: color.white,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 2),
                                        onRatingUpdate: (double value) {},
                                      ),
                                      SizedBox(width: 5),
                                      CachedImageContainer(
                                        image: "$BaseUrl${controller.allRatingReviewList[index].profilePic}",
                                        fit: BoxFit.cover,
                                        circular: 90.0,
                                        topCorner: 90.0,
                                        bottomCorner: 90.0,
                                        height: 22,
                                        width: 22,
                                        placeholder: assetsUrl.plashHolder,
                                        // flag: 1,
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: Get.width * 0.25,
                                        child: commonWidget.regularText(
                                          "${controller.allRatingReviewList[index].firstName ?? ""} ${controller.allRatingReviewList[index].lastName ?? ""}",
                                          fontsize: 12.0,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Spacer(),
                                      // SizedBox(width: 2),
                                      Container(
                                        width: Get.width * 0.25,
                                        child: commonWidget.regularText(
                                          timeago.format(DateTime.parse(controller.allRatingReviewList[index].createdAt.toString())),
                                          fontsize: 12.0,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() {
                                    return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
                                  }),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            );
          });
        });
  }
}
