import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Travel App',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
        ),
        routes: {
          '/': (context) => MyHomePage(),
          '/destination': (context) => DestinationPage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
}

class MyHomePage extends StatelessWidget {
  final List<Destination> popularDestinations = [
    Destination(
      name: 'Paris',
      imageUrl:
          'https://images.pexels.com/photos/2344/cars-france-landmark-lights.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    Destination(
      name: 'Tokyo',
      imageUrl:
          'https://images.pexels.com/photos/1134166/pexels-photo-1134166.jpeg',
    ),
    Destination(
      name: 'Rome',
      imageUrl:
          'https://images.pexels.com/photos/753639/pexels-photo-753639.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ),
    // Add more destinations as needed
  ];
  

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Ideas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Travel App',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Popular Destinations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: popularDestinations.length,
                itemBuilder: (context, index) {
                  return DestinationTile(
                    destination: popularDestinations[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/destination',
                        arguments: popularDestinations[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Destination {
  final String name;
  final String imageUrl;

  Destination({
    required this.name,
    required this.imageUrl,
  });
}

class DestinationTile extends StatelessWidget {
  final Destination destination;
  final VoidCallback? onTap;

  const DestinationTile({
    required this.destination,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
              image: NetworkImage(destination.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(destination.name),
        onTap: onTap,
      ),
    );
  }
}

class DestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final destination = ModalRoute.of(context)!.settings.arguments as Destination;

    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(destination.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              destination.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle further action
              },
              child: Text('More Information'),
            ),
          ],
        ),
      ),
    );
  }
}       
