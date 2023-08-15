abstract class Serializable {
  Map<String, dynamic> toMap();

  Serializable fromMap(Map<String, dynamic> map);
}
