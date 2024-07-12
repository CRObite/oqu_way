class AppApiEndpoints {
  static String url = 'https://api.oquway.kz';

  static String api = '$url/api';
  static String userLogin = '$api/user-login';
  static String getMe = '$api/universal-get-me';
  static String registration = '$api/user-registration';


  // post endpoints
  static String getAllPost = '$api/post/get-all';
  static String getPostById = '$api/post/get-by-id/'; // + post id


  // media endpoints
  static String uploadFile = '$api/media/upload-file';
  static String getVideo = '$api/media/video/'; // + video id
  static String getContent = '$api/media/get-content/'; // + media id

  //university
  static String getAllUniversity = '$api/university/get-all';
  static String getUniversityById = '$api/university/get-by-id/'; // + university id


  //dictionary
  static String getAllCities = '$api/dictionary/cities';

}

