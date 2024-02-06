import 'package:flutter/material.dart';
import 'add_form.dart';
import 'contact_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactService contactService = ContactService();

  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    List getData = await contactService.getData();
    setState(() {
      data = getData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Apps'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, item) {
                return Column(
                  key: Key('item_$item'), // Key for efficient updates
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          // Add the URL for the image here
                          'https://example.com/image.jpg',
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        '${data[item]['name']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'phone : ${data[item]['phone']} \n'
                        'facebook : ${data[item]['facebook']} \n'
                        'instagram : ${data[item]['instagram']} \n',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddForm(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
