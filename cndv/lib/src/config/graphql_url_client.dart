import 'package:cndv/src/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLCNDVClient {
  // TODO take URL from parameter local or qa
  ///static final HttpLink httpLink = HttpLink('http://localhost:4000/graphql');
  static final HttpLink httpLink = HttpLink('${Environment.apiGrapqlQA}');
  static String _token;

  static ValueNotifier<GraphQLClient> inititializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(

          /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
          cache: GraphQLCache(),
          link: httpLink as Link),
    );
    return client;
  }

  static ValueNotifier<GraphQLClient> inititializeTokenAuthenticatedClient(
      String token) {
    final AuthLink authLink = AuthLink(
      getToken: () async => _token,
    );

    final Link link = authLink.concat(httpLink);
    _token = token;

    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(

            /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
            cache: GraphQLCache(),
            link: link));
    return client;
  }
}
