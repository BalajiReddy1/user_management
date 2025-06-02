import 'package:flutter/material.dart';
import 'package:user_management/models/post.dart';
import 'package:user_management/models/todo.dart';
import 'package:user_management/screens/create_post_screen.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final UserRepository _repository = UserRepository();
  late Future<List<Post>> _postsFuture;
  late Future<List<Todo>> _todosFuture;
  List<Todo> _todos = [];
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    // Fetch posts for the user
    _postsFuture = _repository.fetchPostsForUser(widget.user.id);
    _postsFuture.then((fetchedPosts) {
      setState(() {
        _posts = fetchedPosts;
      });
    });

    // Fetch todos for the user
    _todosFuture = _repository.fetchTodosForUser(widget.user.id);
    _todosFuture.then((fetchedTodos) {
      setState(() {
        _todos = fetchedTodos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('${widget.user.firstName} ${widget.user.lastName}')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.image),
              ),
            ),
            TabBar(
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.article,
                    color: Colors.blueAccent,
                  ),
                  text: "Posts",
                ),
                Tab(
                    icon: Icon(
                      Icons.check_box,
                      color: Colors.blueAccent,
                    ),
                    text: "Todos"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPostsView(),
                  _buildTodosView(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final newPost = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePostScreen()),
            );
            if (newPost != null) {
              setState(() {
                _posts.insert(0, newPost);
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildPostsView() {
    if (_posts.isEmpty) {
      return FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Error loading posts",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text("No posts available",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
          }
          // If data exists, assign it to _posts and build the list.
          _posts = snapshot.data!;
          return _buildPostsListView();
        },
      );
    } else {
      return _buildPostsListView();
    }
  }

  Widget _buildPostsListView() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          elevation: 1,
          margin: EdgeInsets.all(8),
          child: ListTile(
            title:
                Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(post.body),
          ),
        );
      },
    );
  }

  Widget _buildTodosView() {
    if (_todos.isEmpty) {
      return FutureBuilder<List<Todo>>(
        future: _todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading todos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No todos available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          _todos = snapshot.data!;
          return _buildTodosListView();
        },
      );
    } else {
      return _buildTodosListView();
    }
  }

  Widget _buildTodosListView() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return CheckboxListTile(
          title: Text(todo.todo),
          value: todo.completed,
          activeColor: Colors.blueAccent,
          onChanged: (bool? value) {
            setState(() {
              _todos[index] = todo.copyWith(completed: value);
            });
          },
        );
      },
    );
  }
}
