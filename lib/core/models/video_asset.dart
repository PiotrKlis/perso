class VideoAsset {
  VideoAsset({
    required this.plyabackId,
  });

  factory VideoAsset.fromJson(Map<String, dynamic> json) {
    return VideoAsset(
      plyabackId: json['plyabackId'][0]['id'] as String,
    );
  }

  final String plyabackId;
}
