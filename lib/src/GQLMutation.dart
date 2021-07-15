part of simple_gql;

/// GQL Mutation using the Dart Http package
/// [url] is your gql endpoint.
///
/// [query] is your String query.
///
/// [variables] is the map of variables if your query need variables.
///
/// [headers] if you want to tweaks the request's headers.
///
/// Example
/// ```dart
/// import 'package:simple_gql/simple_gql.dart' as gql;
///
/// final response = await gql.mutation(
///   url: 'https://your_gql_endpoint',
///   mutation: r'''
///     mutation CreateMessage($input: String) {
///       createMessage(input: $input) {
///         id
///       }
///     }
///   ''',
///   variables: { 'input': 'message' }
/// );
/// ```
@deprecated
Future<GQLMsg> mutation(
    {@required String url,
    @required String mutation,
    Map<String, dynamic> variables,
    Map<String, String> headers}) async {
  return await post(Uri.parse(url),
          headers: (headers ?? {})
            ..putIfAbsent('content-type', () => 'application/json')
            ..putIfAbsent('accept', () => 'application/json'),
          body: jsonEncode({'query': mutation, 'variables': variables}))
      .then((res) {
    final body = jsonDecode(res.body);
    return GQLMsg(body);
  });
}
