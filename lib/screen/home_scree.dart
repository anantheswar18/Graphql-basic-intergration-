import 'package:flutter/material.dart';
import 'package:graphql_first/constants/const.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("GraphQl"),
      ),
      body: Query(
          options: QueryOptions(document: gql(productGraphql)),
          builder: ((result, {fetchMore, refetch}) {
            if (result.hasException) {
              print('error ${result.exception}');
            }
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final productList = result.data?['products']['edges'];
            print(productList);

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Products",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Expanded(
                    child: GridView.builder(
                  itemCount: productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    var product = productList[index]['node'];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          width: 100,
                          height: 100,
                          child: Image.network(product['thumbnail']['url']),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(product['name'],style:TextStyle(fontWeight: FontWeight.bold) ,),
                        ),
                      ],
                    );
                  },
                ))
              ],
            );
          })),
    );
  }
}
