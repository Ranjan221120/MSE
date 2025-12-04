class PullRequestModel {
 final String? title; 
 final String? body;
 final String? author;
 final String? createdAt;

 PullRequestModel({
   this.title,
   this.body,
   this.author,
   this.createdAt,
 });

 factory PullRequestModel.fromJson(Map<String, dynamic> json) {
   return PullRequestModel(
     title: json['title'],
     body: json['body'],
     author: json['user']?['login'],
     createdAt: json['created_at'],
   );
 }
}