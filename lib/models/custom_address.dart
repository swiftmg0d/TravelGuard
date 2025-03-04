class CustomAddress {
  final String address;
  final String image;
  final String type;

  CustomAddress(
      {required this.address, required this.image, required this.type});

  toJson() {
    return {
      'address': address,
      'image': image,
    };
  }
}
