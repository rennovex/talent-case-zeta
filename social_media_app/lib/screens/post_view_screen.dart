import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/post_item.dart';

class PostViewScreen extends StatelessWidget {
  // static const routeName = '/post-view';

  // const PostViewScreen({ Key? key }) : super(key: key);

  final Post post;
  PostViewScreen(this.post);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ChangeNotifierProvider.value(
                      value: post,
                      child: PostItem(),
                    ),
                    Text('Comments'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: post.commentCount,
                      itemBuilder: (ctx, ind) =>
                          CommentItem(Comment.fromJson(post.comments[ind])),
                    ),
                  ],
                ),
              ),
            ),
            NewComment(post.id),
          ],
        ),
      ),
    );
  }
}

class NewComment extends StatefulWidget {
  final String postId;

  NewComment(this.postId);
  @override
  _NewCommentState createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  TextEditingController textEditingController;
  var enteredText = '';
  FocusNode focusNode;

  void postComment() {
    print(textEditingController.value.text);
    Api.postcomment(
        id: widget.postId, comment: textEditingController.value.text.trim());
    textEditingController.clear();
    focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(56, 56, 56, 1)),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        minLines: 1,
        maxLines: 10,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Add a comment ...',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: textEditingController,
              builder: (_, value, child) => IconButton(
                icon: Icon(
                  Icons.send,
                  color:
                      value.text.trim().isEmpty ? Colors.white30 : Colors.white,
                ),
                onPressed:
                    value.text.trim().isEmpty ? null : () => postComment(),
              ),
            )),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: EdgeInsets.all(8),
      elevation: 3,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(comment.user.image),
          radius: 22,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.user.userName),
            // Text('7 min ago'),
          ],
        ),
        subtitle: Text('${comment.text}'),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
