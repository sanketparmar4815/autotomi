import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/allCarRatingReview/views/all_car_rating_review_view.dart';
import 'package:autotomi/app/modules/bookimgcar/views/bookimgcar_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../login/views/login_view.dart';
import '../controllers/rentcardetails_controller.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentcardetailsView extends GetView<RentcardetailsController> {
  const RentcardetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RentcardetailsController controller = Get.put(RentcardetailsController());
    return GetBuilder<RentcardetailsController>(
      init: RentcardetailsController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: WillPopScope(
              onWillPop: () {
                return controller.willPopScope();
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: controller.info == null
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeArea(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 280,
                                    child: Swiper(
                                      loop: false,
                                      autoplay: false,
                                      itemBuilder: (BuildContext context, int index) {
                                        return CachedImageContainer(
                                          image: "$BaseUrl${controller.info!.carImage![index].image}",
                                          fit: BoxFit.fill,
                                          width: Get.width,
                                          placeholder: assetsUrl.plashHolderFullCard,
                                          // flag: 1,
                                        );
                                      },
                                      itemCount: controller.info!.carImage!.length,
                                      pagination: SwiperPagination(
                                        builder: DotSwiperPaginationBuilder(
                                          size: 7,
                                          color: color.white,
                                          activeColor: color.appColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 7,
                                    child: InkWell(
                                      onTap: () {
                                        Get.back(
                                          result: 1,
                                        );
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: color.white,
                                        child: Image.asset(
                                          assetsUrl.ArrowbackIcon,
                                          scale: 3.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 7,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.flag == 0 || box.read('user_id') == 0) {
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
                                          if (controller.info!.isLikeByMe == 0) {
                                            controller.info!.isLikeByMe = 1;
                                          } else {
                                            controller.info!.isLikeByMe = 0;
                                          }
                                          controller.update();
                                          controller.likeUnlikeCar_Api();
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: color.white,
                                        child: Icon(
                                          controller.info!.isLikeByMe == 0 ? Icons.favorite_outline_rounded : Icons.favorite_outlined,
                                          color: color.appColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  commonWidget.semiBoldText(
                                    controller.info!.carName.toString(),
                                    fontsize: 20.0,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => AllCarRatingReviewView(), arguments: {
                                            'car_id': controller.carID.toString(),
                                          });
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Image.asset(
                                          assetsUrl.starRatingImage,
                                          scale: 3.5,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => AllCarRatingReviewView(), arguments: {
                                            'car_id': controller.carID.toString(),
                                          });
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: commonWidget.regularText(
                                          "${controller.info!.starCount}(${controller.info!.reviewCount} Reviews)",
                                          fontsize: 14.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                                          decoration: BoxDecoration(
                                            color: Color(0xffFAFBFC),
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xffE1EEE5),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              commonWidget.mediumText(
                                                stringsUtils.Price,
                                                fontsize: 14.0,
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  commonWidget.semiBoldText(
                                                    "£${controller.info!.pricePerDay}",
                                                    fontsize: 20.0,
                                                  ),
                                                  SizedBox(width: 5),
                                                  commonWidget.mediumText(
                                                    stringsUtils.PerDay,
                                                    fontsize: 14.0,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 21),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                                          decoration: BoxDecoration(
                                            color: Color(0xffFAFBFC),
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(0xffE1EEE5),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              commonWidget.mediumText(
                                                stringsUtils.Price,
                                                fontsize: 14.0,
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  commonWidget.semiBoldText(
                                                    "£${controller.info!.pricePerWeek}",
                                                    fontsize: 20.0,
                                                  ),
                                                  SizedBox(width: 5),
                                                  commonWidget.mediumText(
                                                    stringsUtils.PerWeek,
                                                    fontsize: 14.0,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          "Damage Protection Fee",
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          "£${controller.info!.securityDeposite}",
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Divider(
                                    height: 1,
                                    thickness: 1.0,
                                    color: Color(0xffE9E9E9),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            commonWidget.mediumText(
                                              stringsUtils.Exterior,
                                              fontsize: 18.0,
                                            ),
                                            SizedBox(height: 7),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.HOW_ITS_WORK, arguments: controller.info!.exteriorVideo)?.then((value) {
                                                  Future.delayed(Duration(milliseconds: 300), () {
                                                    SystemChrome.setSystemUIOverlayStyle(
                                                      SystemUiOverlayStyle(
                                                        statusBarColor: Colors.transparent,
                                                        statusBarIconBrightness: Brightness.dark,
                                                        statusBarBrightness: Brightness.dark,
                                                      ),
                                                    );
                                                  });
                                                });
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(6),
                                                    child: Container(
                                                      height: 100,
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: CachedImageContainer(
                                                        image: "$BaseUrl${controller.info!.exteriorThumbnail}",
                                                        fit: BoxFit.cover,
                                                        placeholder: assetsUrl.plashHolderCar,
                                                        // flag: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Center(
                                                      child: Image.asset(
                                                        assetsUrl.playIcon,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            commonWidget.mediumText(
                                              stringsUtils.Interior,
                                              fontsize: 18.0,
                                            ),
                                            SizedBox(height: 7),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.HOW_ITS_WORK, arguments: controller.info!.interiorVideo)!.then((value) {
                                                  Future.delayed(Duration(milliseconds: 300), () {
                                                    SystemChrome.setSystemUIOverlayStyle(
                                                      SystemUiOverlayStyle(
                                                        statusBarColor: Colors.transparent,
                                                        statusBarIconBrightness: Brightness.dark,
                                                        statusBarBrightness: Brightness.dark,
                                                      ),
                                                    );
                                                  });
                                                });
                                              },
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(6),
                                                    child: Container(
                                                      height: 100,
                                                      width: Get.width,
                                                      decoration: BoxDecoration(),
                                                      child: CachedImageContainer(
                                                        image: "$BaseUrl${controller.info!.interiorThumbnail}",
                                                        fit: BoxFit.cover,
                                                        placeholder: assetsUrl.plashHolderCar,
                                                        // flag: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Center(
                                                      child: Image.asset(
                                                        assetsUrl.playIcon,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  commonWidget.mediumText(
                                    stringsUtils.Specification,
                                    fontsize: 18.0,
                                  ),
                                  SizedBox(height: 11),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.CarType,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.categoryName.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.Engine,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.engine.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.Seats,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.seats.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.FuelType,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.fuelType.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.ExteriorColour,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.exteriorColor.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.InteriorColour,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.interiorColor.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.AirConditioner,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.isAc.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.ReverseCamera,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.isReverseCamera.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.PushtoStartKeys,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.isPushToStartKey.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffE1EEE5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonWidget.mediumText(
                                          stringsUtils.InfotainmentDisplay,
                                          fontsize: 13.0,
                                        ),
                                        commonWidget.semiBoldText(
                                          controller.info!.isInfotainmentDisplay.toString(),
                                          fontsize: 16.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  controller.info!.carBenefit!.length != 0
                                      ? commonWidget.mediumText(
                                          stringsUtils.AddedBenefits,
                                          fontsize: 18.0,
                                        )
                                      : SizedBox(),
                                  SizedBox(height: 10),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.info!.carBenefit!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: Get.width,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF8F8F8),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CachedImageContainer(
                                              image: "$BaseUrl${controller.info!.carBenefit![index].benefitImage}",
                                              fit: BoxFit.cover,
                                              height: 30,
                                              width: 30,
                                              placeholder: assetsUrl.plashHolderCar,
                                              // flag: 1,
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                commonWidget.semiBoldText(
                                                  controller.info!.carBenefit![index].benefitText.toString(),
                                                  fontsize: 16.0,
                                                ),
                                                Container(
                                                  width: Get.width / 1.4,
                                                  child: commonWidget.mediumText(
                                                    controller.info!.carBenefit![index].benefitDescription.toString(),
                                                    fontsize: 13.0,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  commonWidget.customButton(
                                    onTap: () {
                                      if (controller.flag == 0 || box.read('user_id') == 0) {
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
                                        selectedCalenderDateEndDate = null;
                                        selectedCalenderDate = null;
                                        Get.toNamed(Routes.BOOKIMGCAR, arguments: {
                                          'car_id': controller.carID,
                                          'price_day': controller.info!.pricePerDay,
                                          'price_week': controller.info!.pricePerWeek,
                                          'security_deposite': controller.info!.securityDeposite,
                                        });
                                      }
                                    },
                                    height: 48.0,
                                    textfontsize: 16.0,
                                    text: controller.flag == 1 ? stringsUtils.BookNow : stringsUtils.Ilikeit,
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
