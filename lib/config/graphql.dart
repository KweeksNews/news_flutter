mixin GqlDocument {
  static const String userQuery = r'''
  query User($id: ID!, $idType: UserNodeIdTypeEnum) {
    user(id: $id, idType: $idType) {
      databaseId
      slug
      name
      description
      avatar {
        url
      }
    }
  }
  ''';

  static const String categoryQuery = r'''
  query Category($id: ID!, $idType: CategoryIdType) {
    category(id: $id, idType: $idType) {
      databaseId
      slug
      name
      description
      children {
        nodes {
          databaseId
          slug
          name
        }
      }
    }
  }
  ''';

  static const String tagQuery = r'''
  query Tag($id: ID!, $idType: TagIdType) {
    tag(id: $id, idType: $idType) {
      databaseId
      slug
      name
      description
    }
  }
  ''';

  static const String postsQuery = r'''
  query Posts(
    $first: Int
    $after: String
    $last: Int
    $before: String
    $search: String
    $notIn: [ID]
    $authorIn: [ID]
    $categoryIn: [ID]
    $categoryNotIn: [ID]
    $tagIn: [ID]
    $tagNotIn: [ID]
  ) {
    posts(
      first: $first
      after: $after
      last: $last
      before: $before
      where: {
        search: $search
        notIn: $notIn
        authorIn: $authorIn
        categoryIn: $categoryIn
        categoryNotIn: $categoryNotIn
        tagIn: $tagIn
        tagNotIn: $tagNotIn
      }
    ) {
      nodes {
        databaseId
        date
        slug
        title(format: RENDERED)
        featuredImage {
          node {
            sourceUrl(size: MEDIUM_LARGE)
          }
        }
        featuredVideo
        author {
          node {
            databaseId
            slug
            name
            avatar {
              url
            }
          }
        }
        categories {
          nodes {
            databaseId
            slug
            name
          }
        }
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }
  }
  ''';

  static const String postQuery = r'''
  query Post($id: ID!, $idType: PostIdType) {
    post(id: $id, idType: $idType) {
      databaseId
      date
      slug
      title(format: RENDERED)
      content(format: RENDERED)
      featuredImage {
        node {
          sourceUrl(size: LARGE)
        }
      }
      featuredVideo
      author {
        node {
          databaseId
          slug
          name
          avatar {
            url
          }
        }
      }
      categories {
        nodes {
          databaseId
          slug
          name
        }
      }
      tags {
        nodes {
          databaseId
          slug
          name
        }
      }
    }
  }
  ''';
}
