package;

class AOC_Utils {
    inline public static function boolXor(a:Bool, b:Bool):Bool {
        return a && !b || (!a && b);
    }

    inline public static function boolToInt(b:Bool):Int {
        return b ? 1 : 0;
    }

    // https://code.haxe.org/category/beginner/regular-expressions.html
    public static function getMatches(ereg:EReg, input:String, index:Int = 0):Array<String> {
        var matches = [];
        while (ereg.match(input)) {
            matches.push(ereg.matched(index));
            input = ereg.matchedRight();
        }

        return matches;
    }
}