import 'package:flutter/material.dart';

class UserDtailPage extends StatefulWidget {
  String name;
  String ownerRepoName;
  String ownerRepoImage;
  var watchersCount;
  var size;
  String language;

  UserDtailPage({
    this.name,
    this.ownerRepoName,
    this.ownerRepoImage,
    this.watchersCount,
    this.size,
    this.language,
  });

  @override
  _UserDtailPageState createState() => _UserDtailPageState();
}

class _UserDtailPageState extends State<UserDtailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                child: Image.network(widget.ownerRepoImage),
                radius: 55,
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                widget.ownerRepoName,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                widget.watchersCount.toString(),
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.size.toString(),
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.language,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
