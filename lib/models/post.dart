
class Reaction {
  final int likes;
  final int dislikes;

  const Reaction({required this.likes, required this.dislikes});

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
    );
  }
}

class Post {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final Reaction reaction;
  final int views;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reaction,
    required this.views,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      reaction: Reaction.fromJson(json['reactions']),
      views: json['views'] as int,
    );
  }

  factory Post.local({
    required String title,
    required String body,
    int userId =
        0, 
  }) {
    return Post(
      id: DateTime.now().millisecondsSinceEpoch, 
      title: title,
      body: body,
      userId: userId,
      tags: [],
      reaction: const Reaction(likes: 0, dislikes: 0),
      views: 0,
    );
  }
}
