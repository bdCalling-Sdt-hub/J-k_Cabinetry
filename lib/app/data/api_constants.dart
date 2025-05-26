class ApiConstants{
/// google maps

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String estimatedTimeUrl="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";

  static String baseUrl = "https://s3000.sobhoy.com";
  static String imageBaseUrl = "https://s3000.sobhoy.com";
  static String socketUrl = "https://s3000.sobhoy.com";

  static String googleApiKey="AIzaSyBFi80uuJIWkkLCpodFa8oXmD8XD_h8LMc";



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> User Auth>>>>>>>>>>>>>>>>>>>---FAHIM

  static String logInUrl= '$baseUrl/auth/login';
  static String signUpUrl= '$baseUrl/auth/register';
  static String profileViewUrl= '$baseUrl/auth/get-single-user/';
  static String updateProfileUrl= '$baseUrl/auth/update';

  // password reset
  static String emailVerificationUrl= '$baseUrl/reset-password/send-verification';
  static String verifyEmailWithOtpUrl= '$baseUrl/reset-password/proses-verification';
  static String resetPasswordUrl(String email)=> '$baseUrl/auth/change-passs/$email';

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> User Auth>>>>>>>>>>>>>>>>>>>-- SHUVO VAI
  static String registerUrl= '/auth/register';
static String categoryUrl= '/users/category';
static String emailSendUrl= '$baseUrl/auth/forgot-password';
//static String logInUrl= '/auth/login';
static String resetPasswordNoneUrl= '/auth/reset-password/none';
static String branchUrl= '$baseUrl/branch/read-branch/open';


/// ==================================>>>> Chatting <<<<============================ ///
  static String getMyMessagesUrl(String chatroomId)=> '$baseUrl/message/$chatroomId';
  static String getMyChatsUrl = '$baseUrl/chat';
  static String sendMessageUrl = '$baseUrl/message';

/// Cabinet
static String cabinetPartsUrl= '$baseUrl/parts/get-parts-by-categories'; // postman- StockItemProductDetails
  static String cabinetPartsDetailsUrl(String partId)=> '$baseUrl/parts/get-single-part/$partId'; // postman- get-single-part
static String cabinetDetailsUrl(String cabinetId)=> '$baseUrl/cabinetry/get-cabinetry-by-id/$cabinetId';


static String  cabinetryUrl (String branchId)=> '$baseUrl/cabinetry/read-cabinetry-without-login/$branchId';
static String  searchNameUrl (String name)=> '$baseUrl/users?fullName=$name';
///check
static String  searchNameaslkjdUrl (String name)=> '$baseUrl/useasdbhmnsars?fullName=$name';

// Order
  static String createOrderUrl= '$baseUrl/order/create-order';

}