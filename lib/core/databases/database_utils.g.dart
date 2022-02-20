// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_utils.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SavedPost extends DataClass implements Insertable<SavedPost> {
  final int id;
  final DateTime date;
  final String slug;
  final String link;
  final String title;
  final String image;
  final String video;
  final List<Category> categories;
  final Author author;
  SavedPost(
      {required this.id,
      required this.date,
      required this.slug,
      required this.link,
      required this.title,
      required this.image,
      required this.video,
      required this.categories,
      required this.author});
  factory SavedPost.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SavedPost(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      slug: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}slug'])!,
      link: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}link'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      video: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video'])!,
      categories: $SavedPostsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}categories']))!,
      author: $SavedPostsTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['slug'] = Variable<String>(slug);
    map['link'] = Variable<String>(link);
    map['title'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    map['video'] = Variable<String>(video);
    {
      final converter = $SavedPostsTable.$converter0;
      map['categories'] = Variable<String>(converter.mapToSql(categories)!);
    }
    {
      final converter = $SavedPostsTable.$converter1;
      map['author'] = Variable<String>(converter.mapToSql(author)!);
    }
    return map;
  }

  SavedPostsCompanion toCompanion(bool nullToAbsent) {
    return SavedPostsCompanion(
      id: Value(id),
      date: Value(date),
      slug: Value(slug),
      link: Value(link),
      title: Value(title),
      image: Value(image),
      video: Value(video),
      categories: Value(categories),
      author: Value(author),
    );
  }

  factory SavedPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedPost(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      slug: serializer.fromJson<String>(json['slug']),
      link: serializer.fromJson<String>(json['link']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
      video: serializer.fromJson<String>(json['video']),
      categories: serializer.fromJson<List<Category>>(json['categories']),
      author: serializer.fromJson<Author>(json['author']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'slug': serializer.toJson<String>(slug),
      'link': serializer.toJson<String>(link),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
      'video': serializer.toJson<String>(video),
      'categories': serializer.toJson<List<Category>>(categories),
      'author': serializer.toJson<Author>(author),
    };
  }

  SavedPost copyWith(
          {int? id,
          DateTime? date,
          String? slug,
          String? link,
          String? title,
          String? image,
          String? video,
          List<Category>? categories,
          Author? author}) =>
      SavedPost(
        id: id ?? this.id,
        date: date ?? this.date,
        slug: slug ?? this.slug,
        link: link ?? this.link,
        title: title ?? this.title,
        image: image ?? this.image,
        video: video ?? this.video,
        categories: categories ?? this.categories,
        author: author ?? this.author,
      );
  @override
  String toString() {
    return (StringBuffer('SavedPost(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slug: $slug, ')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('video: $video, ')
          ..write('categories: $categories, ')
          ..write('author: $author')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, slug, link, title, image, video, categories, author);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedPost &&
          other.id == this.id &&
          other.date == this.date &&
          other.slug == this.slug &&
          other.link == this.link &&
          other.title == this.title &&
          other.image == this.image &&
          other.video == this.video &&
          other.categories == this.categories &&
          other.author == this.author);
}

class SavedPostsCompanion extends UpdateCompanion<SavedPost> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> slug;
  final Value<String> link;
  final Value<String> title;
  final Value<String> image;
  final Value<String> video;
  final Value<List<Category>> categories;
  final Value<Author> author;
  const SavedPostsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.slug = const Value.absent(),
    this.link = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.video = const Value.absent(),
    this.categories = const Value.absent(),
    this.author = const Value.absent(),
  });
  SavedPostsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String slug,
    required String link,
    required String title,
    required String image,
    required String video,
    required List<Category> categories,
    required Author author,
  })  : date = Value(date),
        slug = Value(slug),
        link = Value(link),
        title = Value(title),
        image = Value(image),
        video = Value(video),
        categories = Value(categories),
        author = Value(author);
  static Insertable<SavedPost> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? slug,
    Expression<String>? link,
    Expression<String>? title,
    Expression<String>? image,
    Expression<String>? video,
    Expression<List<Category>>? categories,
    Expression<Author>? author,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (slug != null) 'slug': slug,
      if (link != null) 'link': link,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
      if (video != null) 'video': video,
      if (categories != null) 'categories': categories,
      if (author != null) 'author': author,
    });
  }

  SavedPostsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? slug,
      Value<String>? link,
      Value<String>? title,
      Value<String>? image,
      Value<String>? video,
      Value<List<Category>>? categories,
      Value<Author>? author}) {
    return SavedPostsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      slug: slug ?? this.slug,
      link: link ?? this.link,
      title: title ?? this.title,
      image: image ?? this.image,
      video: video ?? this.video,
      categories: categories ?? this.categories,
      author: author ?? this.author,
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
    if (link.present) {
      map['link'] = Variable<String>(link.value);
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
    if (categories.present) {
      final converter = $SavedPostsTable.$converter0;
      map['categories'] =
          Variable<String>(converter.mapToSql(categories.value)!);
    }
    if (author.present) {
      final converter = $SavedPostsTable.$converter1;
      map['author'] = Variable<String>(converter.mapToSql(author.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedPostsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slug: $slug, ')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('video: $video, ')
          ..write('categories: $categories, ')
          ..write('author: $author')
          ..write(')'))
        .toString();
  }
}

class $SavedPostsTable extends SavedPosts
    with TableInfo<$SavedPostsTable, SavedPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedPostsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String?> slug = GeneratedColumn<String?>(
      'slug', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String?> link = GeneratedColumn<String?>(
      'link', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<String?> video = GeneratedColumn<String?>(
      'video', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _categoriesMeta = const VerificationMeta('categories');
  @override
  late final GeneratedColumnWithTypeConverter<List<Category>, String?>
      categories = GeneratedColumn<String?>('categories', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<Category>>($SavedPostsTable.$converter0);
  final VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumnWithTypeConverter<Author, String?> author =
      GeneratedColumn<String?>('author', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<Author>($SavedPostsTable.$converter1);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, slug, link, title, image, video, categories, author];
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
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
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
    context.handle(_categoriesMeta, const VerificationResult.success());
    context.handle(_authorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SavedPost.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SavedPostsTable createAlias(String alias) {
    return $SavedPostsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Category>, String> $converter0 =
      const CategoriesConverter();
  static TypeConverter<Author, String> $converter1 = const AuthorConverter();
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
