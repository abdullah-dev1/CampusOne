class TeachingAssignment {
  final String course;
  final String section;

  const TeachingAssignment({
    required this.course,
    required this.section,
  });

  factory TeachingAssignment.fromMap(
    Map<String, dynamic> map,
  ) {
    return TeachingAssignment(
      course: map['course'] as String? ?? '',
      section: map['section'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'course': course,
      'section': section,
    };
  }

  TeachingAssignment copyWith({
    String? course,
    String? section,
  }) {
    return TeachingAssignment(
      course: course ?? this.course,
      section: section ?? this.section,
    );
  }
}