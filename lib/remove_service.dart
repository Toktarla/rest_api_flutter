import 'package:restapi/post.dart';
import 'package:http/http.dart' as http;

class RemoteService{
      static Future<List<Post>?> getPosts() async {
             var httpRequest = http.Client();
             var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
            var response = await httpRequest.get(uri);
            if(response.statusCode==200)
            {

                  String jsonString = response.body;
                  print(jsonString);

                  return postFromJson(jsonString);
            }
            return null;
            

}
}