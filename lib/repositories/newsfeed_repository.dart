import 'dart:io';

import 'package:appify_lab_socm/data/remote/responses/api_response.dart';
import 'package:appify_lab_socm/models/comment.dart';
import 'package:appify_lab_socm/models/profile.dart';
import 'package:appify_lab_socm/res/api_constants/firebase_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../models/posts.dart';
import '../utils/toasts/error_toast.dart';

class NewsfeedRepository{
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FirebaseStorage firebaseStorage;

  NewsfeedRepository({required this.firebaseAuth, required this.firebaseFirestore, required this.firebaseStorage});

  Stream<List<Post>> allPosts(){
    CollectionReference posts = firebaseFirestore.collection(FirebaseCollection.post);
    return posts.snapshots().map((event) {

      List<Post> posts = [];
      for (var element in event.docs) {
        Post pst = Post.fromJson(element.data() as Map<String, dynamic>);
        pst.id = element.id;
        posts.add(pst);
      }
      return posts;
    });
  }


  Stream<List<CommentReplyObject>> postComments(Post post){
    CollectionReference posts = firebaseFirestore.collection(FirebaseCollection.comment).doc(post.id).collection('comments');
    return posts.snapshots().map((event) {
      List<CommentReplyObject> result = [];
      List<Comment> posts = [];
      for (var element in event.docs) {
        Comment pst = Comment.fromJson(element.data() as Map<String, dynamic>);
        pst.id = element.id;
        posts.add(pst);
      }
      for(var element in posts){
        if(!element.isReply!){
          result.add(CommentReplyObject(comment: element, reply: []));
        }
      }

      for(var element in posts){
        if(element.isReply!){
          result.firstWhere((e) => e.comment.id==element.parentComment!.id).reply.add(element);
        }
      }
      
      return result;
    });
  }

  Future<Object> createPost(Post post, {File? image})async{

    Object result = Failure(code: 404, error: {}, key: "create-post");
    try{

      if(image!=null){
        print('image is uploading');
        try{
          final fileName = basename(image.path);
          final destination = 'files/$fileName';
          final ref = firebaseStorage.ref(destination).child('file/');
          await ref.putFile(File(image.path));
          String imageUrl = await ref.getDownloadURL();
          print(imageUrl);
          post.imageUrl = imageUrl;
        }catch(e){
          print(e);
          errorToast('Image upload failed');
        }

      }else{

      }

      await firebaseFirestore.collection(FirebaseCollection.post).add(post.toJson());
      result = Success(code: 200, data: {}, key: "post-created");

    }catch(e){
      errorToast("Post creation failed");
    }
    return result;
  }

  Future<Object> delete(Post post)async{

    Object result = Failure(code: 404, error: {}, key: "post-delete");
    try{
      await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).delete();

      result = Success(code: 200, data: {}, key: "post-deleted");
    }catch(e){
      errorToast("Post delete failed");
    }
    return result;
  }


  Future<Object> like(Post post, Profile myProfile)async{
    Object result = Failure(code: 404, error: {}, key: "like");
    try{
      DocumentReference reference = firebaseFirestore.collection(FirebaseCollection.like).doc(post.id).collection(FirebaseCollection.profile).doc(myProfile.uid);
      DocumentSnapshot documentSnapshot = await reference.get();
      if(documentSnapshot.exists){
        await reference.delete();
        if(post.likes!=null){
          int x = post.likes??0;
          post.likes =x-1;
        }
        await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).update(post.toJson());
      }else{
        await reference.set(myProfile.toJson());
        if(post.likes!=null){
          int x = post.likes??0;
          post.likes =x+1;
        }
        await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).update(post.toJson());
      }
      result = Success(code: 200, data: {}, key: "toggle-like");
    }catch(e){
      errorToast("Post delete failed");
    }
    return result;
  }

  Stream<List<Profile>> likeStream(Post post){
    CollectionReference posts = firebaseFirestore.collection(FirebaseCollection.like).doc(post.id).collection(FirebaseCollection.profile);
    return posts.snapshots().map((event) {
      List<Profile> posts = [];
      for (var element in event.docs) {
        Profile pst = Profile.fromJson(element.data() as Map<String, dynamic>);
        posts.add(pst);
      }
      return posts;
    });
  }

  Future<Object> createComment(Post post, Comment comment)async{

    Object result = Failure(code: 404, error: {}, key: "create-comment");
    try{
      await firebaseFirestore.collection(FirebaseCollection.comment).doc(post.id).collection("comments").add(comment.toJson());
      if(post.comments!=null){
        int x = post.comments??0;
        post.comments =x+1;
      }
      await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).update(post.toJson());
      result = Success(code: 200, data: {}, key: "comment-created");

    }catch(e){
      errorToast("Comment creation failed");
    }
    return result;
  }

  Future<Object> deleteComment(Post post, Comment comment)async{
    Object result = Failure(code: 404, error: {}, key: "comment-delete");
    try{
      await firebaseFirestore.collection(FirebaseCollection.comment).doc(post.id).collection("comments").doc(comment.id).delete();
      if(post.comments!=null){
        int x = post.comments??0;
        post.comments =x-1;
      }
      await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).update(post.toJson());
      result = Success(code: 200, data: {}, key: "comment-delete");

    }catch(e){
      errorToast("Comment delete failed");
    }
    return result;
  }

  Future<Object> updatePost(Post post, {File? image}) async{
    Object result = Failure(code: 404, error: {}, key: "update-post");
    try{
      if(image!=null){
        print('image is uploading');
        try{
          final fileName = basename(image.path);
          final destination = 'files/$fileName';
          final ref = firebaseStorage.ref(destination).child('file/');
          await ref.putFile(File(image.path));
          String imageUrl = await ref.getDownloadURL();
          print(imageUrl);
          post.imageUrl = imageUrl;
        }catch(e){
          print(e);
          errorToast('Image upload failed');
        }
      }else{

      }

      await firebaseFirestore.collection(FirebaseCollection.post).doc(post.id).update(post.toJson());

      result = Success(code: 200, data: {}, key: "post-created");

    }catch(e){
      errorToast("Post creation failed");
    }
    return result;
  }

  updateComment(Post post, Comment comment) async{
    Object result = Failure(code: 404, error: {}, key: "update-comment");
    try{
      await firebaseFirestore.collection(FirebaseCollection.comment).doc(post.id).collection("comments").doc(comment.id).update(comment.toJson());
      result = Success(code: 200, data: {}, key: "comment-update");

    }catch(e){
      errorToast("Comment update failed");
    }
    return result;
  }


}