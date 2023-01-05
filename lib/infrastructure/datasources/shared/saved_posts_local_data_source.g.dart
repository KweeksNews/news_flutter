// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_posts_local_data_source.dart';

// ignore_for_file: type=lint
mixin _$SavedPostsLocalDataSourceImplMixin on DatabaseAccessor<AppDatabase> {
  SavedPosts get savedPosts => attachedDatabase.savedPosts;
  Selectable<int> countEntry() {
    return customSelect('SELECT COUNT(*) AS _c0 FROM saved_posts',
        variables: [],
        readsFrom: {
          savedPosts,
        }).map((QueryRow row) => row.read<int>('_c0'));
  }

  Future<int> createEntry(int id, DateTime date, String slug, String title,
      String image, String video, User author, List<Category> categories) {
    return customInsert(
      'INSERT INTO saved_posts (id, date, slug, title, image, video, author, categories) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)',
      variables: [
        Variable<int>(id),
        Variable<DateTime>(date),
        Variable<String>(slug),
        Variable<String>(title),
        Variable<String>(image),
        Variable<String>(video),
        Variable<String>(SavedPosts.$converterauthor.toSql(author)),
        Variable<String>(SavedPosts.$convertercategories.toSql(categories))
      ],
      updates: {savedPosts},
    );
  }

  Selectable<SavedPost> readAllEntries(int offset) {
    return customSelect(
        'SELECT * FROM saved_posts ORDER BY id DESC LIMIT 10 OFFSET ?1',
        variables: [
          Variable<int>(offset)
        ],
        readsFrom: {
          savedPosts,
        }).asyncMap(savedPosts.mapFromRow);
  }

  Selectable<SavedPost> readEntry(int id) {
    return customSelect('SELECT * FROM saved_posts WHERE id = ?1', variables: [
      Variable<int>(id)
    ], readsFrom: {
      savedPosts,
    }).asyncMap(savedPosts.mapFromRow);
  }

  Future<int> updateEntry(int id, DateTime date, String slug, String title,
      String image, String video, User author, List<Category> categories) {
    return customUpdate(
      'UPDATE saved_posts SET id = ?1, date = ?2, slug = ?3, title = ?4, image = ?5, video = ?6, author = ?7, categories = ?8 WHERE id = ?1',
      variables: [
        Variable<int>(id),
        Variable<DateTime>(date),
        Variable<String>(slug),
        Variable<String>(title),
        Variable<String>(image),
        Variable<String>(video),
        Variable<String>(SavedPosts.$converterauthor.toSql(author)),
        Variable<String>(SavedPosts.$convertercategories.toSql(categories))
      ],
      updates: {savedPosts},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteEntry(int id) {
    return customUpdate(
      'DELETE FROM saved_posts WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {savedPosts},
      updateKind: UpdateKind.delete,
    );
  }
}
