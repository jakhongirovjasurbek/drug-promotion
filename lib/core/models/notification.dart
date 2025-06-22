import 'package:equatable/equatable.dart';

final class NotificationModel extends Equatable {
  final String date;
  final String heading;
  final String text;

  const NotificationModel({
    required this.date,
    required this.heading,
    required this.text,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      date: json['date'],
      heading: json['heading'],
      text: json['text'],
    );
  }

  static List<NotificationModel> buildList(List list) {
    return list.map((json) => NotificationModel.fromJson(json)).toList();
  }

  @override
  List<Object> get props => [date, heading, text];
}
