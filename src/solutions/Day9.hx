package solutions;

using StringTools;

class Day9 implements BaseSolution {

    var numbers = [];

    var TEST_PART_ONE = "35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    ";

    public function new() {
        //this.RAW_INPUT = TEST_PART_ONE;
        this.numbers = this.RAW_INPUT.trim().split("\n").map(Std.parseFloat);
        //Sys.println(numbers);
    }

    function somePairSumsTo(numbers:Array<Float>, startIdx:Int, preambleLength:Int, sumTo:Float):Bool {
        for (i in startIdx...startIdx + preambleLength - 1) {
            for (j in i + 1...i + preambleLength) {
                if (numbers[i] + numbers[j] == sumTo) return true;
            }
        }
        return false;
    }

    function checkEncoding(numbers:Array<Float>, preambleLength:Int):{isValid:Bool, firstNonValid:Float} {
        var res = {isValid:true, firstNonValid:Math.NaN};

        for (i in preambleLength...numbers.length) {
            var sumTo = numbers[i];
            if (!somePairSumsTo(numbers, i - preambleLength, preambleLength, sumTo)) {
                res.isValid = false;
                res.firstNonValid = numbers[i];
                break;
            }
        }

        return res;
    }

    public function solvePartOne():String {
        var res = checkEncoding(numbers, 25);

    #if (!java)
        return Std.string(res.firstNonValid);
    #else
        return Std.string(java.NativeString.format("%.0f", res.firstNonValid));
    #end
    }

    public function solvePartTwo():String {
        return Std.string("");
    }
}