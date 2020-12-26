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

    public static function intToBinaryStr(i:Int):String {
        var res = "";
        if (i == 0) return "0";

        while (i > 0) {
            res = (if (i & 1 == 1) "1" else "0") + res;
            i = i >> 1;
    	}

        return res;
     }

     public static function binaryStrToInt(str:String):Int {
        var res:Int = 0;
        var bitSetMask:Int = 0;
        var len = str.length;
        var reversedChars = [for (i in 0...len) str.charAt(len - i - 1)];
        var i = 0;
        for (ch in reversedChars) {
            bitSetMask = (if (ch == "1") 1 else 0) << i;
            res |= bitSetMask;
        	i++;
    	}
        return res;
    }
}