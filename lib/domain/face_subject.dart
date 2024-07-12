class FakeSubject{
  bool opened;

  FakeSubject(this.opened);

  static List<FakeSubject> listOfOpened = [
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
    FakeSubject(false),
  ];
}

class TempToken{
  static String token = "eyJhbGciOiJIUzUxMiJ9.eyJ0b2tlbl9pZCI6ImE5Y2RlZjY1LTEzNTYtNGViOS05ZjU0LWM1YzVkNTMxZTVmMSIsInRva2VuX3R5cGUiOiJhY2Nlc3NfdG9rZW4iLCJzdWIiOiJzdHVkZW50QGJpbGltLWxhYi5reiIsImlhdCI6MTcyMDc2NDA5MiwiZXhwIjoxNzIwODUwNDkyfQ.BKePCeEf3-7vndGxUTcLSZLQ3mWoZtzR_OLRN7WvXNDSi4TdK-gIsC7GXMX2FYBA1KOyQVxnwa7psMo5J8OKog";
}