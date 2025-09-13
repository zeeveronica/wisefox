class Result {
  final int value;
  final String label;
  final int userId;

  Result({
    required this.value,
    required this.label,
    required this.userId,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      value: json['value'],
      label: json['label'],
      userId: json['user_id'],
    );
  }
}

class StudentListing {
  final List<Result> results;

  StudentListing({required this.results});

  factory StudentListing.fromJson(Map<String, dynamic> json) {
    // Safely extract the 'results' field, defaulting to an empty list if null
    var list = json['results'] as List<dynamic>?;

    // Use the null-aware operator and map to convert each item to a Result
    List<Result> resultList = (list ?? [])
        .map((i) => Result.fromJson(i as Map<String, dynamic>))
        .toList();

    return StudentListing(results: resultList);
  }
}
