import 'package:equatable/equatable.dart';

class ExamBoardModel extends Equatable {
  final int value;
  final String label;

  ExamBoardModel({
    required this.value,
    required this.label,
  });

  factory ExamBoardModel.fromJson(Map<String, dynamic> json) {
    return ExamBoardModel(
      value: json['value'],
      label: json['label'] ?? '',
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
