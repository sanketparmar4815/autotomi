import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/app/modules/login/views/login_view.dart';
import 'package:autotomi/app/modules/rentcar/views/rentcar_view.dart';
import 'package:autotomi/common/CachedImageContainer.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../common/constant.dart';
import '../../../../common/widgets.dart';
import '../controllers/availability_car_controller.dart';

class AvailabilityCarView extends GetView<AvailabilityCarController> {
  const AvailabilityCarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvailabilityCarController>(
      assignId: true,
      init: AvailabilityCarController(),
      builder: (logic) {
        return Obx(() {
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0,
            progressIndicator: customerIndicator,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: commonWidget.customAppbar(
                leading: SizedBox(),
                backgroundColor: Colors.white,
                titleText: '',
                centerTitle: false,
                actions: InkWell(
                  onTap: () {
                    Get.offAll(() => LoginView());
                  },
                  splashColor: color.transparent,
                  highlightColor: color.transparent,
                  child: Row(
                    children: [
                      commonWidget.mediumText(stringsUtils.skip, fontsize: 16.0, tcolor: color.appColor),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: controller.isLoading.value == true
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            commonWidget.semiBoldText(
                              stringsUtils.Checkthecar,
                              fontsize: 32.0,
                            ),
                            SizedBox(height: 15),
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
                                      } else {
                                        controller.selectRentCar.add(controller.carList[index].categoryId);
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
                            Calendar(),
                            SizedBox(height: 30),
                            commonWidget.customButton(
                              onTap: () async {
                                box.write('user_id', 0);
                                if (validation()) {
                                  await Get.to(() => RentcarView(), arguments: {
                                    'flag': 0,
                                    'categoryId': controller.selectRentCar,
                                  });
                                }
                              },
                              text: stringsUtils.next,
                            ),
                            SizedBox(height: 30),
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

  bool validation() {
    if (controller.selectRentCar.isEmpty) {
      Toasty.showtoast('Please Select car');
      return false;
    } else if (selectedCalenderDate == null) {
      Toasty.showtoast('Please Select first date');
      return false;
    } else if (selectedCalenderDateEndDate == null) {
      Toasty.showtoast('Please Select end date');
      return false;
    } else {
      return true;
    }
  }
}

var selectedCalenderDate;
var selectedCalenderDateEndDate;

class Calendar extends StatefulWidget {
  Calendar({startDate, endDate});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<String> days = [];
  List date = [];
  List currentMonthData = [];
  List nextMonthData = [];
  List prevMonthData = [];
  List finalMonthData = [];

  var lastday = (DateTime.now().month < 12) ? new DateTime(DateTime.now().year, DateTime.now().month + 1, 0) : new DateTime(DateTime.now().year + 1, 1, 0);
  var month = DateTime.now().month;

  Color an(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(context).brightness == Brightness.light ? Colors.blue : Color(0xffE1A6AD);
      }
    }
    return Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent;
  }

  Color js(var ank) {
    for (var i in days) {
      if (i == ank) {
        return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
      }
    }
    return Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white;
  }

  finalStep() {
    int nextMonthFirstMonday = getFirstMonday(nextMonthData);
    finalMonthData = [...finalMonthData, ...currentMonthData];
    for (int i = 0; i < nextMonthFirstMonday; i++) {
      finalMonthData.add(nextMonthData[i]);
    }
  }

  int getFirstMonday(List monthData) {
    int firstMondayAt = 0;
    final index = monthData.indexWhere((element) => element['day'] == 'Monday');
    if (index >= 0) {
      firstMondayAt = index;
    }
    return firstMondayAt;
  }

  letsFun() {
    prevMonthData.clear();
    for (DateTime indexDay = DateTime(month == 1 ? year - 1 : year, month == 1 ? 12 : month - 1, 1); indexDay.month == (month == 1 ? 12 : month - 1); indexDay = indexDay.add(Duration(days: 1))) {
      prevMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    for (DateTime indexDay = DateTime(year, month, 1);
        indexDay.month == month;
        indexDay = indexDay.add(
      Duration(days: 1),
    ),) {
      currentMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }

    // Next Month
    nextMonthData.clear();
    for (DateTime indexDay = DateTime(month == 12 ? year + 1 : year, month == 12 ? 1 : month + 1, 1); indexDay.month == (month == 12 ? 1 : month + 1); indexDay = indexDay.add(Duration(days: 1))) {
      nextMonthData.add({'full_date': DateFormat('yyyy-MM-dd').format(indexDay), 'date': DateFormat('dd').format(indexDay), 'day': DateFormat('EEEE').format(indexDay)});
    }
  }

  getPreviousMonthLeadingDates() async {
    int prevDays = 0;
    int currMonthFirstMonday = getFirstMonday(currentMonthData);
    prevDays = 7 - currMonthFirstMonday;

    for (int i = 0; i < prevMonthData.length; i++) {
      if (currMonthFirstMonday != 0) {
        if (i == prevMonthData.length - prevDays) {
          prevDays--;
          finalMonthData.add(prevMonthData[i]);
        }
      }
    }
  }

  var day;
  final now = DateTime.now();

  hereWeGo() {
    letsFun();
    getPreviousMonthLeadingDates();
    finalStep();
  }

  var CalenderDay;

  @override
  void initState() {
    hereWeGo();
    day = DateTime(
      now.year,
      now.month,
      now.day,
    );
    super.initState();
  }

  var startDate = DateTime(DateTime.now().year, DateTime.now().month + 0, 1);
  var year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      prevMonthData.clear();
                      nextMonthData.clear();
                      currentMonthData.clear();
                      finalMonthData.clear();
                      if (month == 1) {
                        year = year - 1;
                        month = 12;
                      } else {
                        month = month - 1;
                      }
                      await hereWeGo();
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          padding: EdgeInsets.only(left: 10),
                          child: Center(
                            child: Image.asset(
                              assetsUrl.arrowLeftCaleder,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('MMMM,yyyy').format(DateTime.parse('$year-${month < 10 ? '0$month' : month}-01 00:00:00.000000')),
                  ),
                  InkWell(
                    onTap: () async {
                      prevMonthData.clear();
                      nextMonthData.clear();
                      currentMonthData.clear();
                      finalMonthData.clear();
                      if (month == 12) {
                        year = year + 1;
                        month = 1;
                      } else {
                        month = month + 1;
                      }
                      setState(() {});
                      await hereWeGo();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          padding: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            assetsUrl.arrowRightCaleder,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Table(
                children: <TableRow>[
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "M",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "T",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "W",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "T",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "F",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "S",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 7,
                          child: Text(
                            "S",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < finalMonthData.length / 7; i++)
                    TableRow(
                      children: <Widget>[
                        for (int j = 0; j < 7; j++)
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: GestureDetector(
                              onTap: () async {
                                //  print(DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')));
                                if (selectedCalenderDate == null) {
                                  if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                    Toasty.showtoast("you can not select previews date");
                                  } else {
                                    setState(() {
                                      selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
                                    });
                                  }
                                } else if (selectedCalenderDate != finalMonthData[j + 7 * i]['full_date'] && selectedCalenderDateEndDate != null) {
                                  if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                    Toasty.showtoast("you can not select previews date");
                                  } else {
                                    setState(() {
                                      selectedCalenderDateEndDate = null;
                                      selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
                                    });
                                  }
                                } else {
                                  if (DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00').isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                                    Toasty.showtoast("you can not select previews date");
                                  } else {
                                    if (DateTime.parse('${selectedCalenderDate} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00')) == false) {
                                      setState(() {
                                        selectedCalenderDateEndDate = selectedCalenderDate;
                                        selectedCalenderDate = finalMonthData[j + 7 * i]['full_date'];
                                      });
                                    } else {
                                      setState(() {
                                        selectedCalenderDateEndDate = finalMonthData[j + 7 * i]['full_date'];
                                      });
                                    }
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: finalMonthData[j + 7 * i]['full_date'].toString() == DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
                                  //         ? Theme.of(context).brightness == Brightness.light
                                  //             ? Colors.green
                                  //             : Color(0xffE1A6AD)
                                  //         : Colors.transparent),
                                  color: selectedCalenderDate == finalMonthData[j + 7 * i]['full_date'] || selectedCalenderDateEndDate == finalMonthData[j + 7 * i]['full_date']
                                      ? Theme.of(context).brightness == Brightness.light
                                          ? color.appColor
                                          : Color(0xffE1A6AD)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      finalMonthData[j + 7 * i]['date'].toString(),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                commonWidget.mediumText(
                  stringsUtils.StartDate,
                  fontsize: 15.0,
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: color.appColor,
                    ),
                  ),
                  child: Center(
                    child: commonWidget.regularText(
                      selectedCalenderDate == null ? "Select Start Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDate)),
                      fontsize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 20),
            Column(
              children: [
                commonWidget.mediumText(
                  stringsUtils.EndDate,
                  fontsize: 15.0,
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: color.appColor,
                    ),
                  ),
                  child: Center(
                    child: commonWidget.regularText(
                      selectedCalenderDateEndDate == null ? "Select End Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDateEndDate)),
                      fontsize: 14.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),

        // Text('${selectedCalenderDate}  ${selectedCalenderDateEndDate}'),
      ],
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    print((to.difference(from).inHours / 24).round());
    print('utsav satami');
    return (to.difference(from).inHours / 24).round();
  }

  DateTime selectedDate = DateTime.now();
}
