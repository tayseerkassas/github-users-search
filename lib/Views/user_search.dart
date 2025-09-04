import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';
import '../Repositorys/user_search_repository.dart';
import '../Repositorys/user_search_repository.dart';
import '../Models/user_details.dart';
import '../Controllers/user_search_controller.dart';


//
// class UserSearch extends StatefulWidget {
//   const UserSearch({super.key});
//   // late final UserSearchController controller;
//   @override
//   State<UserSearch> createState() => _UserSearchState();
// }
// class _UserSearchState extends State<UserSearch> {
//   late final UserSearchController controller;
//
//   @override
//
//   void initState() {
//     super.initState();
//
//     Get.lazyPut<UserSearchController>(
//           () => UserSearchController(UserSearchRepository(Dio())),
//       fenix: true,
//     );
//
//     controller = Get.find<UserSearchController>();
//   }
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         appBar: AppBar(
//         title: const Text(
//         'search',
//         style: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Color.fromRGBO(149, 217, 217, 1.0)),
//     ),
//
//         ),
//
//
// body: Padding(padding: EdgeInsets.all(9)
// ,
//
//   child: Column(
//     children: [
//
//       TextField(
//
//         onChanged: (value) {
//           controller.search(value);
//         }
//       ),
//
//     const SizedBox(height: 10),
//
// Expanded(child: Obx((){
//   final users = controller.users;
//   if (users.isEmpty) {
//     return const Center(child: Text("no results fuond"));
//   }
//   return ListView.builder(
//     itemCount: users.length,
//
//     itemBuilder: ( context, index) {
//
//       final user = users[index];
//       return ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(user.avatarUrl),
//         ),
//         title: Text(user.login),
//         subtitle: Text("${user.publicRepos} public repos"),
//         trailing: const Icon(Icons.arrow_forward),
//         onTap: () {
//           _showUserDetails(context, user);
//         },
//       );
//
//
//     },);
//
//
//
// })
//
//
//
// )  ],
//
//
//
//
//   ),
// ),
//
//     );
//   }
// }

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  late final UserSearchController controller;

  @override
  void initState() {
    super.initState();

    Get.lazyPut<UserSearchController>(
          () => UserSearchController(UserSearchRepository(Dio())),
      fenix: true,
    );

    controller = Get.find<UserSearchController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(

        children: [
          Container(
            margin: EdgeInsets.all(20),
            child:  TextField(
            onChanged: (value) {
              controller.debounceSearch(value);// ✅ الآن print سيظهر
            },
          ),),

          Expanded(
            child: Obx(() {

              final users = controller.users;
              if (controller.error.isNotEmpty) {
                return Center(child: Text(controller.error.value));
              }
              if (users.isEmpty) return const Center(child: Text("No results found"));


              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(user.login),
                    subtitle: Text("${user.publicRepos} public repos"),
    onTap: () {
           showUserDetails(context, user);
         },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}


void showUserDetails(BuildContext context, UserDetails user) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(user.login),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(height: 10),
          Text("Public Repos: ${user.publicRepos}"),
          const SizedBox(height: 5),

          Text("name : ${user.name}"),

          const SizedBox(height: 5),

          Text("email : ${user.email}"),

          const SizedBox(height: 5),
          Text("Last Updated: ${user.updatedAt.toLocal()}"),
          const SizedBox(height: 10),

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //
          //   },
          //   child: const Text("View on GitHub"),
          // ),
        ],
      ),
    ),
  );
}
