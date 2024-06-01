import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../../rentcardetails/views/rentcardetails_view.dart';
import '../controllers/favoritecar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritecarView extends GetView<FavoritecarController> {
  const FavoritecarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritecarController>(
        init: FavoritecarController(),
        builder: (logic) {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: commonWidget.customAppbar(
                leading: SizedBox(),
                titleText: stringsUtils.favorite,
                actions: SizedBox(),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          if (controller.searchText.text.length >= 1) {
                            controller.page = 1;
                            controller.hasNextPage.value = false;
                            controller.favoriteCar_Api();
                          } else if (controller.searchText.text.length == 0) {
                            controller.page = 1;
                            controller.hasNextPage.value = false;
                            controller.favoriteCar_Api();
                          }
                        },
                        controller: controller.searchText,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset(
                            assetsUrl.search,
                            scale: 3.5,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color(0xffBFBFBF),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller.favoriteCarList.length == 0 ? SizedBox(height: Get.height * 0.35) : SizedBox(height: 0),
                  controller.favoriteCarList.length == 0 && controller.isLoading.value == false
                      ? commonWidget.semiBoldText(
                          "No Data Found",
                          tcolor: Colors.black,
                          fontsize: 20.0,
                        )
                      : Expanded(
                          child: ListView.builder(
                            controller: controller.scroll_controller,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.favoriteCarList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => RentcardetailsView(), arguments: {
                                    'flag': 1,
                                    'car_id': controller.favoriteCarList[index].carId,
                                  })!
                                      .then((value) {
                                    if (value != null) {
                                      controller.page = 1;
                                      controller.hasNextPage.value = true;
                                      controller.update();
                                      controller.favoriteCar_Api();
                                    }
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  height: 250,
                                  width: Get.width,
                                  margin: EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 10),
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
                                              autoplay: false,
                                              itemBuilder: (BuildContext context, int index1) {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight: Radius.circular(8),
                                                  ),
                                                  child: CachedImageContainer(
                                                    image: "$BaseUrl${controller.favoriteCarList[index].carImage![index1].image}",
                                                    fit: BoxFit.cover,
                                                    placeholder: assetsUrl.plashHolderFullCard,
                                                    // flag: 1,
                                                  ),
                                                );
                                              },
                                              itemCount: controller.favoriteCarList[index].carImage!.length,
                                              pagination: SwiperPagination(
                                                builder: DotSwiperPaginationBuilder(
                                                  size: 7,
                                                  activeSize: 7,
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
                                              onTap: () async {
                                                controller.page = 1;
                                                controller.hasNextPage.value = true;
                                                await controller.likeUnlikeCar_Api(carID: controller.favoriteCarList[index].carId);

                                                await controller.favoriteCar_Api();

                                                controller.update();
                                              },
                                              highlightColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              child: CircleAvatar(
                                                radius: 17,
                                                backgroundColor: color.white,
                                                child: Icon(
                                                  Icons.favorite_outlined,
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
                                                  controller.favoriteCarList[index].carName.toString(),
                                                  fontsize: 20.0,
                                                ),
                                                SizedBox(height: 9),
                                                Row(
                                                  children: [
                                                    commonWidget.regularText(
                                                      controller.favoriteCarList[index].fuelType.toString(),
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
                                                      "£${controller.favoriteCarList[index].pricePerWeek ?? ""}/Per Week",
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
                                                height: 40.0,
                                                width: 105.0,
                                                cornerRadius: 20.0,
                                                text: stringsUtils.BookNow,
                                                textfontsize: 15.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  Obx(
                    () {
                      return controller.isLoadMoreRunning.value == true ? Center(child: customerIndicator) : SizedBox();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
