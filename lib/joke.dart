
class Joke {
  final String joke;

  Joke(this.joke);

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(json['joke'] as String);
  }
}
