import 'package:autotomi/app/modules/bookimgcar/views/bookimgcar_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../controllers/buy_more_time_controller.dart';
import 'package:autotomi/app/routes/app_pages.dart';
import 'package:autotomi/common/constant.dart';
import 'package:autotomi/common/widgets.dart';
import 'package:autotomi/common/Strings.dart';
import 'package:autotomi/common/asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BuyMoreTimeView extends GetView<BuyMoreTimeController> {
  const BuyMoreTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuyMoreTimeController controller = Get.put(BuyMoreTimeController());
    return GetBuilder<BuyMoreTimeController>(
        init: BuyMoreTimeController(),
        assignId: true,
        builder: (logic) {
          return Obx(() {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              opacity: 0,
              progressIndicator: customerIndicator,
              child: Scaffold(
                  backgroundColor: color.white,
                  appBar: commonWidget.customAppbar(
                    fontsize: 20.0,
                    arroOnTap: () {
                      Get.back();
                    },
                    titleText: controller.flag == 1 ? stringsUtils.AddMoreTime : "Buy More Time",
                    actions: SizedBox(),
                    centerTitle: false,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Calendar(startDateIn: controller.startDate1, endDateIn: controller.endDate, bookingList: controller.days1),
                              SizedBox(height: 20),
                              commonWidget.mediumText(
                                stringsUtils.DropoffTime,
                                fontsize: 14.0,
                              ),
                              SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  controller.EndTime(context);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      commonWidget.mediumText(
                                        controller.selectDropTime == null ? stringsUtils.Select : DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(controller.selectDropTime.toString())),
                                        fontsize: 14.0,
                                      ),
                                      Icon(
                                        Icons.access_time_rounded,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),
                        commonWidget.customButton(
                          height: 48.0,
                          width: Get.width,
                          onTap: () async {
                            if (validation()) {
                              print(totalDayMore);
                              if (totalDayMore == 7) {
                                controller.totalAmount = controller.perWeekPrice;
                                print(controller.totalAmount);
                                print("sanku");
                              } else if (totalDayMore < 7) {
                                print(controller.perDayPrice);
                                controller.totalAmount = totalDayMore * controller.perDayPrice;
                                print(controller.totalAmount);
                                print("nemil");
                              } else {
                                controller.totalWeek = (totalDay / 7).toString().split("").first;
                                print("TOTAL WEEK ==>>${controller.totalWeek}");
                                controller.totalWeekAmount = controller.perWeekPrice * int.parse(controller.totalWeek);
                                print(controller.totalWeekAmount);
                                print("total week");
                                controller.totalDay = (totalDay % 7);
                                print(controller.totalDay);
                                print("controller.totalDay");
                                controller.totalDayAmount = controller.totalDay * controller.perDayPrice;
                                print(controller.totalDayAmount);
                                print("controller.totalDayAmount");
                                controller.totalAmount = controller.totalWeekAmount + controller.totalDayAmount;
                                print(controller.totalAmount);

                                print(totalDay);
                                print("rutik");
                              }
                              print("rutik");
                              print(selectedCalenderDateEndDateMoreTime);
                              print(controller.selectDropTime);
                              Get.toNamed(Routes.PAYMENT_METHOD, arguments: {
                                'flag': 5,
                                'booking_id': controller.bookingID,
                                'car_image': controller.carImage,
                                'car_name': controller.carName,
                                'start_date': controller.startDate1,
                                'pick_time': controller.pickUpTime,
                                'end_date': selectedCalenderDateEndDateMoreTime,
                                'drop_time': controller.selectDropTime,
                                'fare_unlimited_kms': controller.totalFare,
                                'damage_protection_fee': controller.damageProtectionFee,
                                'convenience_fee': controller.convenienceFee,
                                'total_fare': controller.totalFare,
                                'security_deposit': controller.securityDeposit,
                                'final_fare': controller.finalFare,
                                'extra_day': totalDayMore,
                                'extra_price': controller.totalAmount,
                                'is_payment': 1,
                                'return_flag': controller.flag,
                                'bring_car_me': controller.bringCarMe,
                                'come_pickup_car': controller.comePickupCar,
                                'car_id': controller.carID,
                                'discount_amount': controller.discountAmount,
                                'coupon_id': controller.couponId,
                              });
                              // await controller.addMoreTime_Api();
                            }
                          },
                          text: stringsUtils.AddTime,
                          textfontsize: 16.0,
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  )),
            );
          });
        });
  }

  bool validation() {
    if (selectedCalenderDateEndDateMoreTime == null) {
      Toasty.showtoast("please select end date");
      return false;
    } else if (controller.selectDropTime == null) {
      Toasty.showtoast("please select drop time");
      return false;
    } else if (selectedCalenderDateEndDateMoreTime == controller.endDate.toString().split('T').first) {
      Toasty.showtoast("selected end date same please select different date");
      return false;
    } else {
      return true;
    }
  }
}

var selectedCalenderDateEndDateMoreTime, totalDayMore;

class Calendar extends StatefulWidget {
  final startDateIn, endDateIn, bookingList;

  const Calendar({Key? key, this.startDateIn, this.bookingList, this.endDateIn}) : super(key: key);

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
  var selectedCalenderDate;
  var selectedCalenderDateEndDate;

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

  int calculateTotalDays(DateTime startDate, DateTime endDate) {
    print(startDate);
    print(endDate);
    Duration difference = endDate.difference(startDate);
    totalDayMore = difference.inDays + 1;
    print(totalDayMore);
    print("total More day");
    return difference.inDays;
  }

  var CalenderDay;

  @override
  void initState() {
    hereWeGo();
    // selectedCalenderDateEndDateMoreTime = widget.endDateIn;
    print("dwbwbd==${widget.startDateIn}");
    day = DateTime(
      now.year,
      now.month,
      now.day,
    );
    selectedCalenderDateEndDateMoreTime = widget.endDateIn.split('T').first;
    selectedCalenderDate = widget.startDateIn.split('T').first;
    print(selectedCalenderDateEndDate);
    print('selectedCalenderDateEndDate');
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
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          child: Center(
                            child: Image.asset(
                              assetsUrl.arrowLeftCaleder,
                              scale: 3.5,
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
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          child: Image.asset(
                            assetsUrl.arrowRightCaleder,
                            scale: 3.5,
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
                                print(finalMonthData[j + 7 * i]['full_date'].toString() == DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.startDateIn.toString())).toString());

                                if (widget.bookingList.contains(DateTime.parse("${finalMonthData[j + 7 * i]['full_date']}T00:00:00.000Z")) || DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) > 0) {
                                  print("you can not select previews date");
                                } else {
                                  if (DateTime.parse('${selectedCalenderDateEndDateMoreTime} 00:00:00').isBefore(DateTime.parse('${finalMonthData[j + 7 * i]['full_date']} 00:00:00'))) {
                                    var endDate = "${finalMonthData[j + 7 * i]['full_date']} 00:00:00.000Z";
                                    var startDate = "${selectedCalenderDate} 00:00:00.000Z";
                                    var days = [];
                                    for (int i = 0; i <= DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays; i++) {
                                      if (days.contains(DateTime.parse(startDate).add(Duration(days: i)))) {
                                      } else {
                                        days.add(DateTime.parse(startDate).add(Duration(days: i)));
                                      }
                                    }
                                    bool containDays = false;

                                    for (var day in days) {
                                      print('day');
                                      if (widget.bookingList.contains(day)) {
                                        print('if');
                                        containDays = true;
                                        break;
                                      }
                                    }
                                    if (containDays == true) {
                                      Toasty.showtoast('This car already booked for this days.');
                                    } else {
                                      setState(() {
                                        selectedCalenderDateEndDateMoreTime = finalMonthData[j + 7 * i]['full_date'];
                                        calculateTotalDays(DateTime.parse(selectedCalenderDate), DateTime.parse(selectedCalenderDateEndDateMoreTime));
                                      });
                                    }

                                    // setState(() {
                                    //   selectedCalenderDateEndDateMoreTime = finalMonthData[j + 7 * i]['full_date'];
                                    // });
                                    calculateTotalDays(DateTime.parse(widget.endDateIn.toString()), DateTime.parse(selectedCalenderDateEndDateMoreTime));
                                  } else {
                                    setState(() {
                                      selectedCalenderDateEndDateMoreTime = finalMonthData[j + 7 * i]['full_date'];
                                    });
                                    calculateTotalDays(DateTime.parse(widget.endDateIn.toString()), DateTime.parse(selectedCalenderDateEndDateMoreTime));
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: finalMonthData[j + 7 * i]['full_date'].toString() == DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.startDateIn.toString())).toString()
                                          ? Theme.of(context).brightness == Brightness.light
                                              ? Colors.green
                                              : Color(0xffE1A6AD)
                                          : Colors.transparent),
                                  color: selectedCalenderDateEndDateMoreTime == finalMonthData[j + 7 * i]['full_date']
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
                                      style: TextStyle(
                                          color: DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) > 0
                                              ? Colors.grey
                                              : widget.bookingList.contains(DateTime.parse("${finalMonthData[j + 7 * i]['full_date']}T00:00:00.000Z"))
                                                  ? Colors.red
                                                  : Colors.black),
                                      // style: TextStyle(color: DateTime.now().add(Duration(days: -1)).compareTo(DateTime.parse(finalMonthData[j + 7 * i]['full_date'])) < 0 ? Colors.black : Colors.grey),
                                    ),
                                    // Text(
                                    //   finalMonthData[j + 7 * i]['date'].toString(),
                                    //   textAlign: TextAlign.right,
                                    // ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                      selectedCalenderDateEndDateMoreTime == null ? "Select End Date" : DateFormat("dd,MMM yyyy").format(DateTime.parse(selectedCalenderDateEndDateMoreTime)),
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
