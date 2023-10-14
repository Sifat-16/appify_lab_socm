class Success{
 int code;
 Object data;
 String? key;
 Success({required this.code, required this.data, required this.key});
}

class Failure{
  int code;
  Object error;
  String? key;
  Failure({required this.code, required this.error, required this.key});
}