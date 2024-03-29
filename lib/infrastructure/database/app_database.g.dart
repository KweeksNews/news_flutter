// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class SavedPosts extends Table with TableInfo<SavedPosts, SavedPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SavedPosts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _dateMeta = VerificationMeta('date');
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _slugMeta = VerificationMeta('slug');
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _titleMeta = VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _imageMeta = VerificationMeta('image');
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _videoMeta = VerificationMeta('video');
  late final GeneratedColumn<String> video = GeneratedColumn<String>(
      'video', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _authorMeta = VerificationMeta('author');
  late final GeneratedColumnWithTypeConverter<User, String> author =
      GeneratedColumn<String>('author', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL')
          .withConverter<User>(SavedPosts.$converterauthor);
  static const VerificationMeta _categoriesMeta =
      VerificationMeta('categories');
  late final GeneratedColumnWithTypeConverter<List<Category>, String>
      categories = GeneratedColumn<String>('categories', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL')
          .withConverter<List<Category>>(SavedPosts.$convertercategories);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, slug, title, image, video, author, categories];
  @override
  String get aliasedName => _alias ?? 'saved_posts';
  @override
  String get actualTableName => 'saved_posts';
  @override
  VerificationContext validateIntegrity(Insertable<SavedPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    context.handle(_authorMeta, const VerificationResult.success());
    context.handle(_categoriesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedPost(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      video: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video'])!,
      author: SavedPosts.$converterauthor.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!),
      categories: SavedPosts.$convertercategories.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categories'])!),
    );
  }

  @override
  SavedPosts createAlias(String alias) {
    return SavedPosts(attachedDatabase, alias);
  }

  static TypeConverter<User, String> $converterauthor = const UserConverter();
  static TypeConverter<List<Category>, String> $convertercategories =
      const CategoriesConverter();
  @override
  bool get dontWriteConstraints => true;
}

class SavedPost extends DataClass implements Insertable<SavedPost> {
  final int id;
  final DateTime date;
  final String slug;
  final String title;
  final String image;
  final String video;
  final User author;
  final List<Category> categories;
  const SavedPost(
      {required this.id,
      required this.date,
      required this.slug,
      required this.title,
      required this.image,
      required this.video,
      required this.author,
      required this.categories});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['slug'] = Variable<String>(slug);
    map['title'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    map['video'] = Variable<String>(video);
    {
      final converter = SavedPosts.$converterauthor;
      map['author'] = Variable<String>(converter.toSql(author));
    }
    {
      final converter = SavedPosts.$convertercategories;
      map['categories'] = Variable<String>(converter.toSql(categories));
    }
    return map;
  }

  SavedPostsCompanion toCompanion(bool nullToAbsent) {
    return SavedPostsCompanion(
      id: Value(id),
      date: Value(date),
      slug: Value(slug),
      title: Value(title),
      image: Value(image),
      video: Value(video),
      author: Value(author),
      categories: Value(categories),
    );
  }

  factory SavedPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedPost(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      slug: serializer.fromJson<String>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
      video: serializer.fromJson<String>(json['video']),
      author: serializer.fromJson<User>(json['author']),
      categories: serializer.fromJson<List<Category>>(json['categories']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'slug': serializer.toJson<String>(slug),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
      'video': serializer.toJson<String>(video),
      'author': serializer.toJson<User>(author),
      'categories': serializer.toJson<List<Category>>(categories),
    };
  }

  SavedPost copyWith(
          {int? id,
          DateTime? date,
          String? slug,
          String? title,
          String? image,
          String? video,
          User? author,
          List<Category>? categories}) =>
      SavedPost(
        id: id ?? this.id,
        date: date ?? this.date,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        image: image ?? this.image,
        video: video ?? this.video,
        author: author ?? this.author,
        categories: categories ?? this.categories,
      );
  @override
  String toString() {
    return (StringBuffer('SavedPost(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('video: $video, ')
          ..write('author: $author, ')
          ..write('categories: $categories')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, slug, title, image, video, author, categories);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedPost &&
          other.id == this.id &&
          other.date == this.date &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.image == this.image &&
          other.video == this.video &&
          other.author == this.author &&
          other.categories == this.categories);
}

class SavedPostsCompanion extends UpdateCompanion<SavedPost> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> slug;
  final Value<String> title;
  final Value<String> image;
  final Value<String> video;
  final Value<User> author;
  final Value<List<Category>> categories;
  const SavedPostsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.video = const Value.absent(),
    this.author = const Value.absent(),
    this.categories = const Value.absent(),
  });
  SavedPostsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String slug,
    required String title,
    required String image,
    required String video,
    required User author,
    required List<Category> categories,
  })  : date = Value(date),
        slug = Value(slug),
        title = Value(title),
        image = Value(image),
        video = Value(video),
        author = Value(author),
        categories = Value(categories);
  static Insertable<SavedPost> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<String>? image,
    Expression<String>? video,
    Expression<String>? author,
    Expression<String>? categories,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
      if (video != null) 'video': video,
      if (author != null) 'author': author,
      if (categories != null) 'categories': categories,
    });
  }

  SavedPostsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? slug,
      Value<String>? title,
      Value<String>? image,
      Value<String>? video,
      Value<User>? author,
      Value<List<Category>>? categories}) {
    return SavedPostsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      image: image ?? this.image,
      video: video ?? this.video,
      author: author ?? this.author,
      categories: categories ?? this.categories,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (video.present) {
      map['video'] = Variable<String>(video.value);
    }
    if (author.present) {
      final converter = SavedPosts.$converterauthor;
      map['author'] = Variable<String>(converter.toSql(author.value));
    }
    if (categories.present) {
      final converter = SavedPosts.$convertercategories;
      map['categories'] = Variable<String>(converter.toSql(categories.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedPostsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('video: $video, ')
          ..write('author: $author, ')
          ..write('categories: $categories')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final SavedPosts savedPosts = SavedPosts(this);
  late final SavedPostsLocalDataSourceImpl savedPostsLocalDataSourceImpl =
      SavedPostsLocalDataSourceImpl(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedPosts];
}
