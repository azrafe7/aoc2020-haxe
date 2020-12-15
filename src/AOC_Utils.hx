package;

class AOC_Utils {
    inline public static function boolXor(a:Bool, b:Bool):Bool {
        return a && !b || (!a && b);
    }
}