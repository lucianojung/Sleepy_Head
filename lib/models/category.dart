class Category {
  var id = -1;
  var categoryName = 'Category';
  var level = 0;
  var progress = 0.0;

  Category({id, categoryName, level, progress}){
    this.id = id ?? this.id;
    this.categoryName = categoryName ?? this.categoryName;
    this.level = level ?? this.level;
    this.progress = progress ?? this.progress;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'level': level,
    'progress': progress,
  };

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryName = json['categoryName'],
        level = json['level'],
        progress = json['progress']
  ;



  static List<Category> categories = [
    Category(
        id: 1,
        categoryName: 'Light'
    ),
    Category(
        id: 2,
        categoryName: 'Noises',
    ),
    Category(
        id: 3,
        categoryName: 'Food',
    ),
    Category(
      id: 4,
      categoryName: 'Routine',
    ),
  ];
}
