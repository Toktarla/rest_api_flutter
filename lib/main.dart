import 'package:flutter/material.dart';
import 'package:restapi/post.dart';
import 'package:restapi/remove_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // We Create List of Posts
  List<Post>? posts;
  // We create isLoad Bool Variable to know that data is Loaded , if not , then => Circular appears
  var isLoad = false;

  @override
  void initState() {
    // Get Data From Server and invoke it in initState
    getData();

    super.initState();
  }

   getData() async {
    posts = await RemoteService.getPosts();
    if (posts != null) {
      setState(() {
        isLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Visibility(
        visible: isLoad,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.purpleAccent[30],


                minLeadingWidth: 50,
                minVerticalPadding: 8,
                visualDensity: VisualDensity.adaptivePlatformDensity,




                textColor: Colors.deepPurpleAccent,
                leading:CircleAvatar(
                  backgroundColor: Colors.purple,

                  child: Text(posts![index].id.toString(),style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),


                ),

                subtitle: Text(posts![index].body.toString()),
                title: Text(
                  posts![index].title.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
      ),
    );
  }
}
