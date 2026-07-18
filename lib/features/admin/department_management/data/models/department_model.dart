enum DepartmentStatus {
  active,
  inactive,
}

class DepartmentModel {
  String id;
  String name;
  String code;
  String hodName;
  String email;
  String phone;
  String description;
  DepartmentStatus status;
  DateTime? createdAt;
  DateTime? updatedAt;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.code,
    required this.hodName,
    required this.email,
    required this.phone,
    required this.description,
    this.status = DepartmentStatus.active,
    this.createdAt,
    this.updatedAt,
  });

  factory DepartmentModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return DepartmentModel(
      id: id,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      hodName: map['hodName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] == 'inactive'
          ? DepartmentStatus.inactive
          : DepartmentStatus.active,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'hodName': hodName,
      'email': email,
      'phone': phone,
      'description': description,
      'status': status.name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  DepartmentModel copyWith({
    String? id,
    String? name,
    String? code,
    String? hodName,
    String? email,
    String? phone,
    String? description,
    DepartmentStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      hodName: hodName ?? this.hodName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}