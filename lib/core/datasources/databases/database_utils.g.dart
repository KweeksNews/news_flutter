// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_utils.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SavedPost extends DataClass implements Insertable<SavedPost> {
  final int id;
  final String title;
  final String category;
  final int catId;
  final String author;
  final String date;
  final String image;
  final bool video;
  SavedPost(
      {required this.id,
      required this.title,
      required this.category,
      required this.catId,
      required this.author,
      required this.date,
      required this.image,
      required this.video});
  factory SavedPost.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SavedPost(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      catId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cat_id'])!,
      author: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author'])!,
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      video: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['cat_id'] = Variable<int>(catId);
    map['author'] = Variable<String>(author);
    map['date'] = Variable<String>(date);
    map['image'] = Variable<String>(image);
    map['video'] = Variable<bool>(video);
    return map;
  }

  SavedPostsCompanion toCompanion(bool nullToAbsent) {
    return SavedPostsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      catId: Value(catId),
      author: Value(author),
      date: Value(date),
      image: Value(image),
      video: Value(video),
    );
  }

  factory SavedPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SavedPost(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      catId: serializer.fromJson<int>(json['catId']),
      author: serializer.fromJson<String>(json['author']),
      date: serializer.fromJson<String>(json['date']),
      image: serializer.fromJson<String>(json['image']),
      video: serializer.fromJson<bool>(json['video']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'catId': serializer.toJson<int>(catId),
      'author': serializer.toJson<String>(author),
      'date': serializer.toJson<String>(date),
      'image': serializer.toJson<String>(image),
      'video': serializer.toJson<bool>(video),
    };
  }

  SavedPost copyWith(
          {int? id,
          String? title,
          String? category,
          int? catId,
          String? author,
          String? date,
          String? image,
          bool? video}) =>
      SavedPost(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        catId: catId ?? this.catId,
        author: author ?? this.author,
        date: date ?? this.date,
        image: image ?? this.image,
        video: video ?? this.video,
      );
  @override
  String toString() {
    return (StringBuffer('SavedPost(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('catId: $catId, ')
          ..write('author: $author, ')
          ..write('date: $date, ')
          ..write('image: $image, ')
          ..write('video: $video')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              category.hashCode,
              $mrjc(
                  catId.hashCode,
                  $mrjc(
                      author.hashCode,
                      $mrjc(date.hashCode,
                          $mrjc(image.hashCode, video.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedPost &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.catId == this.catId &&
          other.author == this.author &&
          other.date == this.date &&
          other.image == this.image &&
          other.video == this.video);
}

class SavedPostsCompanion extends UpdateCompanion<SavedPost> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<int> catId;
  final Value<String> author;
  final Value<String> date;
  final Value<String> image;
  final Value<bool> video;
  const SavedPostsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.catId = const Value.absent(),
    this.author = const Value.absent(),
    this.date = const Value.absent(),
    this.image = const Value.absent(),
    this.video = const Value.absent(),
  });
  SavedPostsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required int catId,
    required String author,
    required String date,
    required String image,
    required bool video,
  })  : title = Value(title),
        category = Value(category),
        catId = Value(catId),
        author = Value(author),
        date = Value(date),
        image = Value(image),
        video = Value(video);
  static Insertable<SavedPost> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<int>? catId,
    Expression<String>? author,
    Expression<String>? date,
    Expression<String>? image,
    Expression<bool>? video,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (catId != null) 'cat_id': catId,
      if (author != null) 'author': author,
      if (date != null) 'date': date,
      if (image != null) 'image': image,
      if (video != null) 'video': video,
    });
  }

  SavedPostsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? category,
      Value<int>? catId,
      Value<String>? author,
      Value<String>? date,
      Value<String>? image,
      Value<bool>? video}) {
    return SavedPostsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      catId: catId ?? this.catId,
      author: author ?? this.author,
      date: date ?? this.date,
      image: image ?? this.image,
      video: video ?? this.video,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (catId.present) {
      map['cat_id'] = Variable<int>(catId.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedPostsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('catId: $catId, ')
          ..write('author: $author, ')
          ..write('date: $date, ')
          ..write('image: $image, ')
          ..write('video: $video')
          ..write(')'))
        .toString();
  }
}

class $SavedPostsTable extends SavedPosts
    with TableInfo<$SavedPostsTable, SavedPost> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SavedPostsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedTextColumn category = _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _catIdMeta = const VerificationMeta('catId');
  @override
  late final GeneratedIntColumn catId = _constructCatId();
  GeneratedIntColumn _constructCatId() {
    return GeneratedIntColumn(
      'cat_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedTextColumn author = _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedTextColumn date = _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedTextColumn image = _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedBoolColumn video = _constructVideo();
  GeneratedBoolColumn _constructVideo() {
    return GeneratedBoolColumn(
      'video',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, category, catId, author, date, image, video];
  @override
  $SavedPostsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'saved_posts';
  @override
  final String actualTableName = 'saved_posts';
  @override
  VerificationContext validateIntegrity(Insertable<SavedPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cat_id')) {
      context.handle(
          _catIdMeta, catId.isAcceptableOrUnknown(data['cat_id']!, _catIdMeta));
    } else if (isInserting) {
      context.missing(_catIdMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video']!, _videoMeta));
    } else if (isInserting) {
      context.missing(_videoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SavedPost.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SavedPostsTable createAlias(String alias) {
    return $SavedPostsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SavedPostsTable savedPosts = $SavedPostsTable(this);
  late final SavedPostsDao savedPostsDao = SavedPostsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedPosts];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SavedPostsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SavedPostsTable get savedPosts => attachedDatabase.savedPosts;
}
