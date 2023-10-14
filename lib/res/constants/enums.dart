enum FileType{
  Image('image'),
  Video('video');
  final String value;
  const FileType(this.value);
}

enum PostType{
  Text('text'),
  TextWithImage('textwithimage'),
  Image('image'),
  Background('background');
  final String value;
  const PostType(this.value);
}


enum CreatePostType{
  Create('Create'),
  Update('Update');
  final String value;
  const CreatePostType(this.value);
}

enum Reaction { like, laugh, love, none }