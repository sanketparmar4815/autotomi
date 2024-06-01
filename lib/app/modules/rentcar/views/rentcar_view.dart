import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/bottombar/views/bottombar_view.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/app/modules/rentcardetails/views/rentcardetails_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/rentcar_controller.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentcarView extends GetView<RentcarController> {
  const RentcarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RentcarController controller = Get.put(RentcarController());
    return GetBuilder<RentcarController>(
        init: RentcarController(),
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: WillPopScope(
                onWillPop: () {
                  return controller.onWillPopScope();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            if (controller.notificationFlag == 5) {
                              Get.offAll(BottombarView(), arguments: 0);
                            } else {
                              Get.back();
                            }
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              assetsUrl.ArrowbackIcon,
                              scale: 3.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    titleSpacing: 0.0,
                    title: commonWidget.semiBoldText(
                      stringsUtils.RentaCar,
                      fontsize: 20.0,
                    ),
                    centerTitle: false,
                  ),
                  body: SingleChildScrollView(
                    controller: controller.scroll_controller,
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 85,
                            width: Get.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.carList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (controller.selectRentCar.contains(controller.carList[index].categoryId)) {
                                      controller.selectRentCar.remove(controller.carList[index].categoryId);
                                      controller.page = 1;
                                      controller.hasNextPage.value = true;
                                      controller.availableCar_Api();
                                    } else {
                                      controller.selectRentCar.add(controller.carList[index].categoryId);
                                      controller.page = 1;
                                      controller.hasNextPage.value = true;
                                      controller.availableCar_Api();
                                    }
                                    controller.update();

                                    print(controller.selectRentCar);
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    // height: Get.height * 0.050,
                                    width: Get.height * 0.090,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 1.5,
                                        color: controller.selectRentCar.contains(controller.carList[index].categoryId) ? color.appColor : Color(0xffD4D4D4),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CachedImageContainer(
                                          // image: "http://138.68.188.126:8000/uploads/images/SUV.png",
                                          image: "$BaseUrl${controller.carList[index].categoryImage}",
                                          fit: BoxFit.fill,
                                          height: 50,
                                          width: 50,
                                          placeholder: assetsUrl.plashHolderCar,
                                          // flag: 1,
                                        ),
                                        Container(
                                          width: Get.height * 0.090,
                                          alignment: Alignment.center,
                                          child: commonWidget.semiBoldText(
                                            controller.carList[index].categoryName.toString(),
                                            fontsize: 12.0,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonWidget.semiBoldText(
                                stringsUtils.Availablecars,
                                fontsize: 16.0,
                              ),
                              Container(
                                width: Get.width / 2.8,
                                decoration: BoxDecoration(color: color.fillColor, borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    value: controller.selectedCountry,
                                    items: controller.countryList.map((item) {
                                      return DropdownMenuItem(
                                        value: item["country_id"],
                                        child: Text(item['country']),
                                      );
                                    }).toList(),
                                    onChanged: (selectedItem) {
                                      print("selectedItem=====>>${selectedItem}");

                                      controller.selectedCountry = selectedItem;
                                      controller.page = 1;
                                      for (int i = 0; i < controller.countryList.length; i++) {
                                        if (controller.countryList[i]['country_id'].toString() == controller.selectedCountry.toString()) {
                                          controller.countryId = controller.countryList[i]['country_id'];
                                          box.write('country_visiting_code_filter', controller.countryList[i]['code']);
                                          box.write('country_name_filter', controller.countryList[i]['country']);
                                          box.write('country_id_filter', controller.countryList[i]['country_id']);
                                          controller.availableCar_Api();
                                          print(controller.countryList[i]['country_id']);
                                          print("controller.countryCode");
                                        }
                                      }

                                      controller.update();
                                    },
                                    hint: commonWidget.mediumText(
                                      "${controller.countryName ?? "Nigeria"}",
                                      //"${controller.countryList[0]['country']}",
                                      fontsize: 14.0,
                                      tcolor: color.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          controller.availabaleCarList.length == 0 ? SizedBox(height: Get.height * 0.25) : SizedBox(height: 10),
                          controller.availabaleCarList.length == 0 && controller.isLoading.value == false
                              ? Center(
                                  child: commonWidget.semiBoldText(
                                    "No Available Car in Your Country",
                                    fontsize: 20.0,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.availabaleCarList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => RentcardetailsView(), arguments: {
                                          'flag': controller.flag,
                                          'car_id': controller.availabaleCarList[index].carId,
                                        })!
                                            .then((value) {
                                          if (value != null) {
                                            controller.page = 1;
                                            controller.hasNextPage.value = true;
                                            controller.availableCar_Api();
                                            controller.update();
                                          }
                                        });
                                        print(controller.availabaleCarList[index].carId);
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: 250,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: color.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(.5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 170,
                                                  child: Swiper(
                                                    loop: false,
                                                    physics: BouncingScrollPhysics(),
                                                    autoplay: false,
                                                    itemBuilder: (BuildContext context, int index1) {
                                                      return ClipRRect(
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(8),
                                                          topRight: Radius.circular(8),
                                                        ),
                                                        child: CachedImageContainer(
                                                          image: "$BaseUrl${controller.availabaleCarList[index].carImage![index1].image}",
                                                          fit: BoxFit.cover,
                                                          placeholder: assetsUrl.plashHolderFullCard,
                                                          // flag: 1,
                                                        ),
                                                      );
                                                    },
                                                    itemCount: controller.availabaleCarList[index].carImage!.length,
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
                                                        if (controller.availabaleCarList[index].isLikeByMe == 0) {
                                                          controller.availabaleCarList[index].isLikeByMe = 1;
                                                        } else {
                                                          controller.availabaleCarList[index].isLikeByMe = 0;
                                                        }
                                                        controller.update();
                                                        controller.likeUnlikeCar_Api(carID: controller.availabaleCarList[index].carId);
                                                      }
                                                    },
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    child: CircleAvatar(
                                                      radius: 17,
                                                      backgroundColor: color.white,
                                                      child: Icon(
                                                        controller.availabaleCarList[index].isLikeByMe == 0 ? Icons.favorite_outline_rounded : Icons.favorite_outlined,
                                                        color: color.appColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 13),
                                                      commonWidget.semiBoldText(
                                                        controller.availabaleCarList[index].carName.toString(),
                                                        fontsize: 20.0,
                                                      ),
                                                      SizedBox(height: 9),
                                                      Row(
                                                        children: [
                                                          commonWidget.regularText(
                                                            controller.availabaleCarList[index].fuelType.toString(),
                                                            fontsize: 13.0,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                            child: CircleAvatar(
                                                              radius: 3,
                                                              backgroundColor: Colors.grey.withOpacity(.4),
                                                            ),
                                                          ),
                                                          commonWidget.semiBoldText(
                                                            "£${controller.availabaleCarList[index].pricePerWeek.toString()}/Per Week",
                                                            fontsize: 14.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 11.0),
                                                    child: commonWidget.customButton(
                                                      // onTap: () {
                                                      //   Get.toNamed(Routes.RENTCARDETAILS, arguments: {'flag': controller.flag});
                                                      // },
                                                      height: 40.0,
                                                      width: 105.0,
                                                      cornerRadius: 20.0,
                                                      text: stringsUtils.BookNow,
                                                      textfontsize: 15.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                          Obx(() {
                            return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : Container();
                          }),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
