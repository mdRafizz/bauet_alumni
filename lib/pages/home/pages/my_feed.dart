import 'package:alumni2/common/reusable_text.dart';
import 'package:alumni2/controller/share_post_controller.dart';
import 'package:alumni2/controller/user_controller.dart';
import 'package:alumni2/data/model/post_comment_model.dart';
import 'package:alumni2/data/model/post_feed_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uuid/uuid.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  final _sharePostTextController =
      Get.put<SharePostController>(SharePostController());

  final _currentUser = Get.put<UserController>(UserController());

  final _commentText = TextEditingController();

  bool _isStatusUploading = false;

  // final List<String> names = [
  //   'Muhammad Nurullah',
  //   'Nazranur Rahman',
  //   'Ashik Khan',
  //   'Faisal Ahmed',
  //   'Tushar Ahmed',
  //   'Ali Haidar',
  //   'MD Rafizul Hasan',
  //   'Ohiduzaman Pranto',
  //   'Tanvir Islam',
  //   'Faisal Ahmed',
  //   'Nazranur Rahman',
  //   'Sakil Ahmed,',
  //   'Mahfuj',
  //   'Md Mizan',
  // ];

  // List<String> imgAssets = [
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/20889.jpg',
  //   'assets/images/bauet_view.jpeg',
  //   'assets/images/me.jpg',
  //   'assets/images/bauet_view.jpg',
  //   'assets/images/career.jpg',
  //   'assets/images/cover.jpg',
  //   'assets/images/event_img.jpg',
  //   'assets/images/bauet_view.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Gap(30),
            _sharePostSection(),
            const Gap(30),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var posts = snapshot.data!.docs;

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];

                    return _singlePostSection(PostFeedModel.fromDocument(post));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// *********** Share Post Section ***************
  Padding _singlePostSection(PostFeedModel post) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    height: 35,
                    width: 35,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: CupertinoActivityIndicator(),
                        ),
                        Image.network(
                          post.imgUrl.toString(),
                          fit: BoxFit.cover,
                          height: 35,
                          width: 35,
                        )
                      ],
                    ),
                  ),
                ),
                title: ReusableText(
                  post.userName,
                  fontSize: 13,
                ),
                subtitle: ReusableText(
                  post.timestamp.toDate().toIso8601String(),
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ReusableText(
                  post.content,
                  fontSize: 15,
                ),
              ),
              const Gap(20),
              const Divider(
                height: .2,
              ),
              LayoutBuilder(builder: (_, __) {
                if (MediaQuery.of(context).size.width >= 600) {
                  return Column(
                    children: [
                      const Gap(20),
                      Row(
                        children: [
                          const Gap(10),
                          LikeButton(
                            size: 23,
                            onTap: (isLiked) async {
                              await likePost(post.id);
                              return !isLiked;
                            },
                            likeCount: post.likes,
                            likeBuilder: (_) {
                              return Icon(
                                IcoFontIcons.like,
                                size: 20,
                                color: _ ? Colors.blue : Colors.grey,
                              );
                            },
                          ),
                          const Gap(30),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.comment_rounded,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              const Gap(1),
                              ReusableText(
                                '10',
                                fontSize: 14,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          const Gap(30),

                          ///******** Comments section ************
                          Expanded(
                            child: TextField(
                              maxLines: 40,
                              minLines: 1,
                              // controller:
                              // _sharePostTextController.textEditingController.value,
                              // onChanged: (value) {
                              //   _sharePostTextController.showSendIcon(value);
                              // },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                hintText: 'Write a comment',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.transparent),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      width: 0, color: Colors.transparent),
                                ),
                                fillColor: Colors.blue.shade50,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      postComment(
                                        post.id,
                                        '${_currentUser.user.value!.firstName} ${_currentUser.user.value!.lastName}',
                                        _commentText.text,
                                        '${_currentUser.user.value!.profilePictureUrl}',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.send_rounded,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 25,
                                  top: 20,
                                  bottom: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Gap(10),
                          Expanded(
                            child: LikeButton(
                              size: 23,
                              likeCount: 20,
                              onTap: (isLiked) async {
                                await likePost(post.id);
                                return !isLiked;
                              },
                              likeBuilder: (_) {
                                return Icon(
                                  IcoFontIcons.like,
                                  size: 20,
                                  color: _ ? Colors.blue : Colors.grey,
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            width: .5,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.comment_rounded,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                // const Gap(1),
                                const ReusableText(
                                  '10',
                                  fontSize: 14,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          const Gap(10),
                        ],
                      ),

                      const Divider(
                        height: .2,
                      ),

                      const Gap(20),

                      ///******** Comments section ************
                      TextField(
                        maxLines: 10,
                        minLines: 1,
                        // controller:
                        // _sharePostTextController.textEditingController.value,
                        // onChanged: (value) {
                        //   _sharePostTextController.showSendIcon(value);
                        // },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          hintText: 'Write a comment',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                          ),
                          fillColor: Colors.blue.shade50,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: () {
                                postComment(
                                  post.id,
                                  '${_currentUser.user.value!.firstName} ${_currentUser.user.value!.lastName}',
                                  _commentText.text,
                                  '${_currentUser.user.value!.profilePictureUrl}',
                                );
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 25,
                            top: 20,
                            bottom: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> likePost(String postId) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(postId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot postSnapshot = await transaction.get(postRef);

      if (!postSnapshot.exists) {
        throw Exception("Post does not exist!");
      }

      PostFeedModel post = PostFeedModel.fromDocument(postSnapshot);
      int newLikes = post.likes + 1;
      transaction.update(postRef, {'likes': newLikes});
    });
  }

  Future<void> postComment(
      String postId, String userName, String content, String imgUrl) async {
    final CollectionReference comments = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments');

    PostCommentModel comment = PostCommentModel(
      id: '',
      userName: userName,
      imgUrl: imgUrl,
      content: content,
      timestamp: Timestamp.now(),
    );

    await comments.add(comment.toMap());
  }

  /// *********** Share Post Section ***************
  Material _sharePostSection() {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Obx(() {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 40,
                  minLines: 1,
                  controller:
                      _sharePostTextController.textEditingController.value,
                  onChanged: (value) {
                    _sharePostTextController.showSendIcon(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Share a link',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                    ),
                    fillColor: Colors.blue.shade50,
                  ),
                ),
              ),
              if (_sharePostTextController.isThereText.value)
                Row(
                  children: [
                    const Gap(10),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          _isStatusUploading = true;
                        });

                        String postId = const Uuid().v4();

                        await FirebaseFirestore.instance
                            .collection('posts')
                            .doc(postId)
                            .set({
                          'id': postId,
                          'imgUrl':
                              '${_currentUser.user.value!.profilePictureUrl}',
                          'userName':
                              '${_currentUser.user.value!.firstName} ${_currentUser.user.value!.lastName}',
                          'content': _sharePostTextController
                              .textEditingController.value.text,
                          'timestamp': Timestamp.now(),
                          'likes': 0,
                        }).then((_) {
                          _sharePostTextController.textEditingController.value
                              .clear();
                          setState(() {
                            _isStatusUploading = false;
                          });
                        });
                      },
                      icon: _isStatusUploading
                          ? LoadingAnimationWidget.halfTriangleDot(
                              color: CupertinoColors.activeBlue.withOpacity(.9),
                              size: 18,
                            )
                          : Icon(
                              Icons.send_rounded,
                              color: CupertinoColors.activeBlue.withOpacity(.9),
                            ),
                    )
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
