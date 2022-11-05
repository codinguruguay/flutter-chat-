import 'package:flutter/material.dart';
import 'package:flutter_chat/classes/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    User(online: true, name: 'Verónica', email: 'test1@test.com', uid: '1'),
    User(online: true, name: 'Papá', email: 'test2@test.com', uid: '2'),
    User(online: false, name: 'Bruno', email: 'test3@test.com', uid: '3'),
    User(online: false, name: 'Seba', email: 'test4@test.com', uid: '4')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text('Martín Verde', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        elevation: 1.0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.check_circle, color: Colors.green),
          )
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            )),
      ),
      body: Center(
          child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: const ClassicHeader(
                idleText: 'Desliza para cargar',
                releaseText: 'Suelta para cargar',
                refreshingText: 'Cargando usuarios...',
                completeText: 'Usuarios cargados!',
              ),
              onRefresh: _loadUsers,
              child: _userListView())),
    );
  }

  ListView _userListView() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _userListTile(users[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: users.length);
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade200,
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: user.online ? Colors.green.shade400 : Colors.red.shade400,
            borderRadius: BorderRadius.circular(100.0)),
      ),
    );
  }

  _loadUsers() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
