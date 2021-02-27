import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphQLUrlClient{

  unauthenticatedUrlClient() async{
    final HttpLink httpLink = HttpLink('http://localhost:4000/');
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink as Link,
            cache: null)
    );
    return client;
  }

  authenticatedTokenUrlClient() async{
    final HttpLink httpLink = HttpLink('http://localhost:4000/');

    final AuthLink authLink = AuthLink(
      getToken: () async => 'mysupertokenhere',
    );

    final Link link = authLink.concat(httpLink);

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: link, cache: null)
    );
    return client;
  }
}