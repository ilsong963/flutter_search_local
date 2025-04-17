String removeTag(String str) {
  return str.replaceAll('<b>', '').replaceAll('</b>', '');
}
