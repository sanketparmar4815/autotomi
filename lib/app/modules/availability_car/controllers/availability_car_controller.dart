import 'package:autotomi/app/Model/list_car_model.dart';
import 'package:autotomi/app/data/NetworkClint.dart';
import 'package:autotomi/common/asset.dart';
import 'package:autotomi/common/constant.dart';
import 'package:get/get.dart';

class AvailabilityCarController extends GetxController {
  List selectRentCar = [];

  List rentCarImageList = [
    {
      "image": assetsUrl.SadenCarImage,
      "name": "Sedan",
    },
    {
      "image": assetsUrl.SuvCarImage,
      "name": "SUV",
    },
    {
      "image": assetsUrl.CrossoveCarImage,
      "name": "Crossover",
    },
    {
      "image": assetsUrl.pickUpCarImage,
      "name": "Pickup",
    },
    {
      "image": assetsUrl.SadenCarImage,
      "name": "Sedan",
    },
    {
      "image": assetsUrl.SuvCarImage,
      "name": "SUV",
    },
    {
      "image": assetsUrl.CrossoveCarImage,
      "name": "Crossover",
    },
  ];
  List<car> carList = [];

  var isLoading = false.obs;

  @override
  void onInit() {
    listCar_Api();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  listCar_Api() {
    isLoading.value = true;
    return NetworkClient.getInstance.callApi(
      baseUrl: BaseUrl + "list_category",
      method: MethodType.Post,
      params: {},
      successCallback: (response, message) {
        print(response);
        if (response['Status'] == 1) {
          list_car_model data = list_car_model.fromJson(response);
          carList = data.info!;
        } else {
          print(response['Message']);
        }
        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print(message.toString());
        print(statusCode);

        isLoading.value = false;
      },
      timeOutCallback: () {
        Toasty.showtoast('something is wrong please try again');
        isLoading.value = false;
      },
    );
  }
}
