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