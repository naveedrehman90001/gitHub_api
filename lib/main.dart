import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis/postModelClass.dart';
import 'package:flutter_apis/userDetailPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Post> post;

  bool loader = false;
  String userName = "naveed";

  List gitrepo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Parsing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) {
                      userName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                !loader
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              loader = true;
                              post = fetchPost(userName).then((value) {
                                setState(() {
                                  loader = false;
                                  post = fetchPost(userName);
                                });
                              }).catchError((e) {
                                print(e);
                              });
                            });

                            gitrepo = await getRepo(userName);

                            for (int i = 0; i < gitrepo.length; i++) {
                              print(gitrepo[i]['name']);
                            }
                            print(gitrepo[0]['owner']['login']);
                          },
                          child: Text('Get Data'),
                        ),
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: 20),
                Divider(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      // color: Colors.teal,
                      child: FutureBuilder<Post>(
                        future: post,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                CircleAvatar(
                                  child:
                                      Image.network(snapshot.data.avatar_url),
                                  radius: 50,
                                  backgroundColor: Colors.grey.shade50,
//                                  child: Icon(Icons.person),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  snapshot.data.login,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 80,
                                  width: double.infinity,
                                  color: Colors.grey,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(
                                            snapshot.data.following.toString(),
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Text(
                                            "Following",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "|",
                                        style: TextStyle(fontSize: 50),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(
                                            snapshot.data.followers.toString(),
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Text(
                                            "Followers",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 1, left: 15),
                                      child: Text(
                                        "Repository",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return Center(
                            child: Text("No Data Found "),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Post> fetchPost(String name) async {
  final response = await http.get('https://api.github.com/users/$name');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List> getRepo(String repoUserName) async {
  String repoUrl = "https://api.github.com/users/$repoUserName/repos";

  http.Response response = await http.get(repoUrl);

  return jsonDecode(response.body);
}
