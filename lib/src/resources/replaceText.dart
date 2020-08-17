class ReplaceTxt {

  static String replacetext(txt) {
    List<String> removetxt = ["{{", "}}", "-*"];
  List<String> addtxt = ["## ", " ", "- #####"];
    Map<String, String> map = new Map.fromIterables(removetxt, addtxt);
    final result =
        map.entries.fold(txt, (prev, e) => prev.replaceAll(e.key, e.value));
    return result;
  }
}
