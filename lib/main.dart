
import 'joke.dart';
import 'dart:convert';
import 'api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Joke> _futureJoke;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _futureJoke = ApiService.fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Joke App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? CircularProgressIndicator()
                  : FutureBuilder<Joke>(
                      future: _futureJoke,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            margin: EdgeInsets.all(12),
                            padding: EdgeInsets.all(12),
                            //color: Colors.lightBlue,
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(8),color: Colors.purple),
                            child: Text(
                              snapshot.data!.joke,
                              style: TextStyle(fontSize: 18, color:Colors.white ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // Display loading indicator while fetching
                        return CircularProgressIndicator();
                      },
                    ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _futureJoke = ApiService.fetchJoke().whenComplete(() {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  });
                },
                child: Text('Get New Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
