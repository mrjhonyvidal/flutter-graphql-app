class PostosSaudeAtendimento {

  /// TODO Check real model schema from Google Maps Developer REST response
  PostosSaudeAtendimento({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory PostosSaudeAtendimento.fromJson(Map<String, dynamic> json) {
    return PostosSaudeAtendimento(
      latitude: json["data"]["latitude"],
      longitude: json["data"]["longitude"],
    );
  }
}