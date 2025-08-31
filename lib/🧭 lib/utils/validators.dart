class Validators {
static bool isEmail(String s) => RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]
+").hasMatch(s);
}
