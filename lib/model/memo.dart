class Memo {
  String title;
  String detail;
  DateTime? createdTime;
  DateTime? updateDate;

  Memo(
      {required this.title,
      required this.detail,
      this.createdTime,
      this.updateDate});
}
