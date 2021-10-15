String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 4) {
    return 'Good Night 🌃';
  }
  if (hour < 12) {
    return 'Good Morning 🌅';
  }
  if (hour < 17) {
    return 'Good Afternoon ☀️';
  }
  return 'Good Evening 🌇';
}