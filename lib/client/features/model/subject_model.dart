import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  final int value; // Use value instead of id
  final String label; // Use label instead of subjectName

  SubjectModel({
    required this.value,
    required this.label,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      value: json['value'],
      label: json['label'] ?? '', // Access the label directly
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }

  @override
  List<Object?> get props => [value, label];
}
