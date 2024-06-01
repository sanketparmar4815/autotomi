import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/rating_review_controller.dart';

class RatingReviewView extends GetView<RatingReviewController> {
  const RatingReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RatingReviewController controller = Get.put(RatingReviewController());
    return Obx(() {
      return ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        opacity: 0,
        progressIndicator: customerIndicator,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: commonWidget.customAppbar(
            centerTitle: false,
            leadingWidth: 0.0,
            leading: SizedBox(),
            backgroundColor: Colors.white,
            titleText: "Review & Rating",
            actions: Padding(
              padding: EdgeInsets.only(top: 14.0, right: 16),
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(Routes.BOTTOMBAR);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: commonWidget.mediumText(
                  stringsUtils.skip,
                  fontsize: 16.0,
                  tcolor: color.appColor,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: controller.info != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.withOpacity(.4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedImageContainer(
                                        image: "$BaseUrl${controller.info!.carImage![0].image}",
                                        fit: BoxFit.cover,
                                        height: 57,
                                        width: 85,
                                        placeholder: assetsUrl.plashHolderFullCard,
                                        // flag: 1,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        commonWidget.semiBoldText(
                                          controller.info!.carName.toString() ?? '',
                                          fontsize: 20.0,
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Image.asset(
                                              assetsUrl.starRatingImage,
                                              scale: 3.5,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 6),
                                            commonWidget.regularText(
                                              "${controller.info!.starCount ?? ""}(${controller.info!.reviewCount ?? ""} Reviews)",
                                              fontsize: 12.0,
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),
                                commonWidget.semiBoldText(
                                  "Your completed Ride",
                                  fontsize: 14.0,
                                ),
                                SizedBox(height: 10),
                                commonWidget.mediumText(
                                  "${DateFormat('EE, dd MMM,').format(
                                    DateTime.parse(controller.info!.startDate.toString()),
                                  )} ${DateFormat('h:mma').format(
                                    DateFormat('HH:mm').parse(controller.info!.pickupTime.toString()),
                                  )} - ${DateFormat('EE, dd MMM,').format(
                                    DateTime.parse(controller.info!.endDate.toString()),
                                  )} ${DateFormat('h:mma').format(
                                    DateFormat('HH:mm').parse(controller.info!.dropoffTime.toString()),
                                  )}",
                                  fontsize: 12.0,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    commonWidget.regularText(
                                      "Your Boking id is: ",
                                      fontsize: 14.0,
                                    ),
                                    commonWidget.mediumText(
                                      "${controller.info!.bookingId ?? ""}",
                                      fontsize: 14.0,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Divider(
                                  height: 1,
                                  color: Colors.grey.withOpacity(.8),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonWidget.regularText(
                                      "Total Fare",
                                      fontsize: 14.0,
                                    ),
                                    commonWidget.semiBoldText(
                                      "£${controller.info!.finalFare ?? ""} Total ",
                                      fontsize: 14.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          commonWidget.mediumText(
                            "Rate this Car",
                            fontsize: 16.0,
                          ),
                          SizedBox(height: 10),
                          RatingBar(
                            ratingWidget: RatingWidget(
                              // full: Icon(Icons.star, color: Colors.amber),
                              full: Image.asset(assetsUrl.starRatingImage),
                              half: Image.asset(assetsUrl.starRatingBlank),
                              empty: Image.asset(assetsUrl.starRatingBlank),
                            ),

                            initialRating: controller.rate,
                            minRating: 0,
                            itemSize: 44,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            updateOnDrag: true,
                            itemCount: 5,
                            unratedColor: color.white,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2),
                            // itemBuilder: (context, _) => Icon(
                            //   Icons.star,
                            //   color: Colors.amber,
                            // ),
                            onRatingUpdate: (rating) {
                              controller.rate = rating;
                              controller.update();
                              print(controller.rate);
                            },
                          ),
                          SizedBox(height: 20),
                          commonWidget.mediumText(
                            "Write a review",
                            fontsize: 16.0,
                          ),
                          commonWidget.customTextfield(
                            controller: controller.reviewDescribe,
                            hintText: "Describe your experience(optional)",
                            maxLines: 6,
                            hintTextColor: Colors.black.withOpacity(.5),
                            label: "",
                          ),
                          SizedBox(height: 50),
                          commonWidget.customButton(
                            onTap: () async {
                              if (validation()) {
                                await controller.addReviewRating_Api();
                                // await Get.offAllNamed(Routes.BOTTOMBAR);
                              }
                            },
                            height: 48.0,
                            width: Get.width,
                            textfontsize: 16.0,
                            text: "Save",
                          )
                        ],
                      )
                    : SizedBox()),
          ),
        ),
      );
    });
  }

  bool validation() {
    if (controller.reviewDescribe.text.isEmpty) {
      Toasty.showtoast("Please Write a review & rating");
      return false;
    } else {
      return true;
    }
  }
}
