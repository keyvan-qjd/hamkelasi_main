class Score {
  String teacher;
  String examinetitle;
  String description;
  String className;
  String examineDate;
  String examineType;
  String courseName;
  String grade;

  Score(
      {
      required this.teacher,
      required this.examinetitle,
      required this.description,
      required this.className,
      required this.examineDate,
      required this.examineType,
      required this.courseName,
      required this.grade});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
        teacher: json['teacherFullname'] ?? '',
        examinetitle: json['examineTitle'] ?? '',
        description: json['description'] ?? '',
        className: json['className'] ?? '',
        examineDate: json['examineDate'] ?? '',
        examineType: json['examineType'] ?? '',
        courseName: json['courseName'] ?? '',
        grade: json['grade'] ?? '');
  }
}
