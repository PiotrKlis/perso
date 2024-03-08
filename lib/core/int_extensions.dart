extension IntExtension on int {
 int secondsToMinutesSeconds() {
   final minutes = this ~/ 60;
   final seconds = this % 60;
   return minutes * 100 + seconds;
 }
}