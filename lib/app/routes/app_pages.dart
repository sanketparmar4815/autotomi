import 'package:get/get.dart';

import '../modules/add_card/bindings/add_card_binding.dart';
import '../modules/add_card/views/add_card_view.dart';
import '../modules/allCarRatingReview/bindings/all_car_rating_review_binding.dart';
import '../modules/allCarRatingReview/views/all_car_rating_review_view.dart';
import '../modules/availability_car/bindings/availability_car_binding.dart';
import '../modules/availability_car/views/availability_car_view.dart';
import '../modules/bookimgcar/bindings/bookimgcar_binding.dart';
import '../modules/bookimgcar/views/bookimgcar_view.dart';
import '../modules/bookimgsuccess/bindings/bookimgsuccess_binding.dart';
import '../modules/bookimgsuccess/views/bookimgsuccess_view.dart';
import '../modules/bottombar/bindings/bottombar_binding.dart';
import '../modules/bottombar/views/bottombar_view.dart';
import '../modules/buyMoreTime/bindings/buy_more_time_binding.dart';
import '../modules/buyMoreTime/views/buy_more_time_view.dart';
import '../modules/card_details/bindings/card_details_binding.dart';
import '../modules/card_details/views/card_details_view.dart';
import '../modules/changeRide/bindings/change_ride_binding.dart';
import '../modules/changeRide/views/change_ride_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/chat_support/bindings/chat_support_binding.dart';
import '../modules/chat_support/views/chat_support_view.dart';
import '../modules/completed_ride/bindings/completed_ride_binding.dart';
import '../modules/completed_ride/views/completed_ride_view.dart';
import '../modules/completed_ride_details/bindings/completed_ride_details_binding.dart';
import '../modules/completed_ride_details/views/completed_ride_details_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/create_account/bindings/create_account_binding.dart';
import '../modules/create_account/views/create_account_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/favoritecar/bindings/favoritecar_binding.dart';
import '../modules/favoritecar/views/favoritecar_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/howItsWork/bindings/how_its_work_binding.dart';
import '../modules/howItsWork/views/how_its_work_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_offer/bindings/my_offer_binding.dart';
import '../modules/my_offer/views/my_offer_view.dart';
import '../modules/mycar/bindings/mycar_binding.dart';
import '../modules/mycar/views/mycar_view.dart';
import '../modules/mycar_details/bindings/mycar_details_binding.dart';
import '../modules/mycar_details/views/mycar_details_view.dart';
import '../modules/new_condition_report/bindings/new_condition_report_binding.dart';
import '../modules/new_condition_report/views/new_condition_report_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/payment_method/bindings/payment_method_binding.dart';
import '../modules/payment_method/views/payment_method_view.dart';
import '../modules/payment_successfull/bindings/payment_successfull_binding.dart';
import '../modules/payment_successfull/views/payment_successfull_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/personal_info1/bindings/personal_info1_binding.dart';
import '../modules/personal_info1/views/personal_info1_view.dart';
import '../modules/personal_info2/bindings/personal_info2_binding.dart';
import '../modules/personal_info2/views/personal_info2_view.dart';
import '../modules/personal_info3/bindings/personal_info3_binding.dart';
import '../modules/personal_info3/views/personal_info3_view.dart';
import '../modules/personal_info4/bindings/personal_info4_binding.dart';
import '../modules/personal_info4/views/personal_info4_view.dart';
import '../modules/pick_up_inspection/bindings/pick_up_inspection_binding.dart';
import '../modules/pick_up_inspection/views/pick_up_inspection_view.dart';
import '../modules/pickup_successful/bindings/pickup_successful_binding.dart';
import '../modules/pickup_successful/views/pickup_successful_view.dart';
import '../modules/pin/bindings/pin_binding.dart';
import '../modules/pin/views/pin_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/ratingReview/bindings/rating_review_binding.dart';
import '../modules/ratingReview/views/rating_review_view.dart';
import '../modules/rentcar/bindings/rentcar_binding.dart';
import '../modules/rentcar/views/rentcar_view.dart';
import '../modules/rentcardetails/bindings/rentcardetails_binding.dart';
import '../modules/rentcardetails/views/rentcardetails_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/send_request_admin/bindings/send_request_admin_binding.dart';
import '../modules/send_request_admin/views/send_request_admin_view.dart';
import '../modules/send_support/bindings/send_support_binding.dart';
import '../modules/send_support/views/send_support_view.dart';
import '../modules/show_inspection_video/bindings/show_inspection_video_binding.dart';
import '../modules/show_inspection_video/views/show_inspection_video_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';
import '../modules/verification/bindings/verification_binding.dart';
import '../modules/verification/views/verification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => const CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO1,
      page: () => const PersonalInfo1View(),
      binding: PersonalInfo1Binding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO2,
      page: () => const PersonalInfo2View(),
      binding: PersonalInfo2Binding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO3,
      page: () => const PersonalInfo3View(),
      binding: PersonalInfo3Binding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO4,
      page: () => const PersonalInfo4View(),
      binding: PersonalInfo4Binding(),
    ),
    GetPage(
      name: _Paths.BOTTOMBAR,
      page: () => const BottombarView(),
      binding: BottombarBinding(),
    ),
    GetPage(
      name: _Paths.MYCAR,
      page: () => const MycarView(),
      binding: MycarBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITECAR,
      page: () => const FavoritecarView(),
      binding: FavoritecarBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RENTCAR,
      page: () => const RentcarView(),
      binding: RentcarBinding(),
    ),
    GetPage(
      name: _Paths.RENTCARDETAILS,
      page: () => const RentcardetailsView(),
      binding: RentcardetailsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKIMGCAR,
      page: () => const BookimgcarView(),
      binding: BookimgcarBinding(),
    ),
    GetPage(
      name: _Paths.BOOKIMGSUCCESS,
      page: () => const BookimgsuccessView(),
      binding: BookimgsuccessBinding(),
    ),
    GetPage(
      name: _Paths.HOW_ITS_WORK,
      page: () => const HowItsWorkView(),
      binding: HowItsWorkBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_RIDE,
      page: () => const CompletedRideView(),
      binding: CompletedRideBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_RIDE_DETAILS,
      page: () => const CompletedRideDetailsView(),
      binding: CompletedRideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MYCAR_DETAILS,
      page: () => const MycarDetailsView(),
      binding: MycarDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CARD_DETAILS,
      page: () => const CardDetailsView(),
      binding: CardDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CARD,
      page: () => const AddCardView(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESSFULL,
      page: () => const PaymentSuccessfullView(),
      binding: PaymentSuccessfullBinding(),
    ),
    GetPage(
      name: _Paths.PICK_UP_INSPECTION,
      page: () => const PickUpInspectionView(),
      binding: PickUpInspectionBinding(),
    ),
    GetPage(
      name: _Paths.NEW_CONDITION_REPORT,
      page: () => const NewConditionReportView(),
      binding: NewConditionReportBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => const PinView(),
      binding: PinBinding(),
    ),
    GetPage(
      name: _Paths.PICKUP_SUCCESSFUL,
      page: () => const PickupSuccessfulView(),
      binding: PickupSuccessfulBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_RIDE,
      page: () => const ChangeRideView(),
      binding: ChangeRideBinding(),
    ),
    GetPage(
      name: _Paths.BUY_MORE_TIME,
      page: () => const BuyMoreTimeView(),
      binding: BuyMoreTimeBinding(),
    ),
    GetPage(
      name: _Paths.AVAILABILITY_CAR,
      page: () => const AvailabilityCarView(),
      binding: AvailabilityCarBinding(),
    ),
    GetPage(
      name: _Paths.RATING_REVIEW,
      page: () => const RatingReviewView(),
      binding: RatingReviewBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CAR_RATING_REVIEW,
      page: () => const AllCarRatingReviewView(),
      binding: AllCarRatingReviewBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_INSPECTION_VIDEO,
      page: () => const ShowInspectionVideoView(),
      binding: ShowInspectionVideoBinding(),
    ),
    GetPage(
      name: _Paths.SEND_SUPPORT,
      page: () => const SendSupportView(),
      binding: SendSupportBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SUPPORT,
      page: () => const ChatSupportView(),
      binding: ChatSupportBinding(),
    ),
    GetPage(
      name: _Paths.MY_OFFER,
      page: () => const MyOfferView(),
      binding: MyOfferBinding(),
    ),
    GetPage(
      name: _Paths.SEND_REQUEST_ADMIN,
      page: () => const SendRequestAdminView(),
      binding: SendRequestAdminBinding(),
    ),
  ];
}
