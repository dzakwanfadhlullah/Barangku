class ItemModel {
  final String id;
  final String name;
  final String? sku;
  final String? category;
  final int initialStock;
  final String? unit;
  final double price;
  final String? description;
  final String? statusStock;
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.name,
    this.sku,
    this.category,
    required this.initialStock,
    this.unit,
    required this.price,
    this.description,
    this.statusStock,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'initial_stock': initialStock,
      'unit': unit,
      'price': price,
      'description': description,
      'status_stock': statusStock,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      category: map['category'],
      initialStock: map['initial_stock'],
      unit: map['unit'],
      price: map['price'],
      description: map['description'],
      statusStock: map['status_stock'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  ItemModel copyWith({
    String? id,
    String? name,
    String? sku,
    String? category,
    int? initialStock,
    String? unit,
    double? price,
    String? description,
    String? statusStock,
    DateTime? createdAt,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      initialStock: initialStock ?? this.initialStock,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      description: description ?? this.description,
      statusStock: statusStock ?? this.statusStock,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
