import 'package:flutter/material.dart';

import '../utils/firebaseUtils.dart';
import '../utils/userInfos.dart';
import '../widgets/addNewUserButton.dart';
import '../widgets/usersList.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  final searchBarController = TextEditingController();
  final addUserController = TextEditingController();
  //List<ChatUsers> filteredChatUsers = [];
  FirebaseUtils fbUtils = FirebaseUtils();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    searchBarController.addListener(showSearchedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    AddNewUserButton(
                      Icons.add,
                      "Add more",
                      addnewUserForm,
                      //color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
            //SearchBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: searchBarController,
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100))),
              ),
            ),

            showUsersList(),
          ],
        ),
      ),
    );
  }

  Widget showUsersList() {
    return FutureBuilder<List<UserInfos>>(
        future: fbUtils.retrieveUsersListFirebase(searchBarController),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {}
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading'));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return UsersList(
                userdata: snapshot.data![index],
              );
            },
          );
        });
  }


  void showSearchedItems() {
    setState(() {
      fbUtils.retrieveUsersListFirebase(searchBarController);
    });
  }

  void addnewUserForm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add User'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: addUserController,
                      decoration: const InputDecoration(
                        labelText: 'Name & Surname',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: const Text("Add User"),
                  onPressed: () {
                    Navigator.pop(context);
                    //_addUser();
                  })
            ],
          );
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    searchBarController.dispose();
    super.dispose();
  }
}
