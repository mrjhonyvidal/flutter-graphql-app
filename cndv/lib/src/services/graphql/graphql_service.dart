import 'package:cndv/src/config/environment.dart';
import 'package:graphql/client.dart';

class GraphQLService{

  GraphQLClient _client;

  GraphQLService(){
    HttpLink link = HttpLink('${Environment.apiGrapqlQA}');
    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future<QueryResult> performQuery(String query,
    {Map<String, dynamic> variables}) async {
      QueryOptions options = QueryOptions(document: gql(query), variables: variables);

      final result = await _client.query(options);
      return result;
  }

  Future<QueryResult> performMutation(String query,
    {Map<String, dynamic> variables}) async {
     MutationOptions options = MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);
    print(result);
    return result;
  }
}
