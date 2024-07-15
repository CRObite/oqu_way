class AppApiEndpoints {
  static String url = 'https://api.oquway.kz';

  static String api = '$url/api';
  static String userLogin = '$api/user-login';
  static String refresh = '$api/refresh-token';
  static String getMe = '$api/universal-get-me';
  static String registration = '$api/user-registration';

  // post endpoints
  static String getAllPost = '$api/post/get-all';
  static String getPostById = '$api/post/get-by-id/'; // + post id

  // media endpoints
  static String uploadFile = '$api/media/upload-file';
  static String getVideo = '$api/media/video/'; // + video id
  static String getContent = '$api/media/get-content/'; // + media id

  //university endpoints
  static String getAllUniversity = '$api/university/get-all';
  static String getUniversityById = '$api/university/get-by-id/'; // + specialization id

  //specialization endpoints
  static String getAllSpecialization= '$api/specialization/get-all';
  static String getSpecializationById = '$api/specialization/get-by-id/'; // + university id

  //dictionary endpoints
  static String getAllCities = '$api/dictionary/cities';

  //course endpoints    subjects почему то
  static String getSubjectById = '$api/subject/get-one/'; // ХЗ ВОООПШЕ ПОЧЕМУ ГЕТ УАН, НУ ПОХОЖЕ ТУТ ID НАДО ПИХАТЬ
  static String getAllSubjects = '$api/subject/get-all';

  //comments endpoints
  static String getAllUniversityComments = '$api/comment/get-all-by-university/'; // + university id
  static String getAllSpecializationComments = '$api/comment/get-all-by-specialization/'; // + specialization id
  static String getAllPostComments = '$api/comment/get-all-by-post/'; // + post id
  static String saveComments = '$api/comment/save';

}

