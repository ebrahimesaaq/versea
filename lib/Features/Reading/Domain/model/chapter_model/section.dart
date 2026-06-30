class Section {
  String? title;
  int? from;
  int? to;

  Section({this.title, this.from, this.to});

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    title: json['title'] as String?,
    from: json['from'] as int?,
    to: json['to'] as int?,
  );

  Map<String, dynamic> toJson() => {'title': title, 'from': from, 'to': to};
}
