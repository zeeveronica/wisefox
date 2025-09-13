import 'package:equatable/equatable.dart';

class TutorList extends Equatable {
  final int value;
  final String label;
  final int userId;

  TutorList({
    required this.value,
    required this.label,
    required this.userId,
  });

  factory TutorList.fromJson(Map<String, dynamic> json) {
    return TutorList(
      value: json['value'],
      label: json['label'],
      userId: json['user_id'],
    );
  }

  @override
  List<Object?> get props => [value, label, userId];
}
