import 'package:flutter/material.dart';

import 'package:graphql_first/screen/home_scree.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  final HttpLink httplink = HttpLink("https://demo.saleor.io/graphql/");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httplink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

  // Future<QueryResult<Object?>> queryResult = client.query(QueryOptions(document: gql(prod  cuctGraphql)),);
  var app = GraphQLProvider(
    client: client,
    child: MyApp(),
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graphql Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
