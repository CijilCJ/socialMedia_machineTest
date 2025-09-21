class Post {
  String id;
  String imagePath; // local path
  String caption;
  int likes;

  Post({required this.id, required this.imagePath, required this.caption, this.likes = 0});

  Map<String, dynamic> toMap() => {
    'id': id,
    'imagePath': imagePath,
    'caption': caption,
    'likes': likes,
  };

  factory Post.fromMap(Map<String, dynamic> map) => Post(
    id: map['id'],
    imagePath: map['imagePath'],
    caption: map['caption'],
    likes: map['likes'],
  );
}
