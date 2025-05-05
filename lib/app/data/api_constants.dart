class ApiConstants{
/// google maps

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String estimatedTimeUrl="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";

    static String baseUrl="https://s3000.sobhoy.com";
    static String  imageBaseUrl="https://s3000.sobhoy.com";
    static String socketUrl="http://206.81.15.114:5000";

  static String googleApiKey="AIzaSyBFi80uuJIWkkLCpodFa8oXmD8XD_h8LMc";

///>>>>>>>>>>>>>>>>>>>>>>>>>>> User Auth>>>>>>>>>>>>>>>>>>>

static String registerUrl= '/auth/register';
static String categoryUrl= '/users/category';
static String emailSendUrl= '$baseUrl/auth/forgot-password';
static String verifyEmailWithOtpUrl= '/auth/verify-email';
static String logInUrl= '/auth/login';
static String resetPasswordUrl= '/auth/reset-password';
static String resetPasswordNoneUrl= '/auth/reset-password/none';
static String branchUrl= '$baseUrl/branch/read-branch/open';
static String cabinetDetailsUrl= '$baseUrl/parts/get-parts-by-categories';

static String  cabinetryUrl (String branchId)=> '$baseUrl/cabinetry/read-cabinetry-without-login/$branchId';
static String  searchNameUrl (String name)=> '$baseUrl/users?fullName=$name';
///check
static String  searchNameaslkjdUrl (String name)=> '$baseUrl/useasdbhmnsars?fullName=$name';

}