import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/screens/profile/profile_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool _isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(labelText: 'Search for a user'),
            onFieldSubmitted: (String _) {
              setState(() {
                _isShowUsers = true;
              });
            },
          )),
      body: _isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                  uid: snapshot.data!.docs[index]['uid'])));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['photoUrl']),
                          ),
                          title: Text(snapshot.data!.docs[index]['username']),
                        ),
                      );
                    });

                // return Container(
                //     child: Center(
                //   child: Text('Hello'),
                // ));
              })
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.custom(
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 6,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      pattern: const [
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(4, 2),
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(2, 2),
                      ],
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => Image.network(
                              snapshot.data!.docs[index]['postUrl'],
                              fit: BoxFit.cover,
                            ),
                        childCount: snapshot.data!.docs.length));
              }),
    );
  }
}
