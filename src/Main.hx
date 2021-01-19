import solutions.*;

using StringTools;

class Main {

    static var dayClasses:Array<Class<BaseSolution>> = [
        /*Day1,
        Day2,
        Day3,
        Day4,
        Day5,
        Day6,
        Day7,
        Day8,
        Day9,
        Day10,*/
        Day11,
    ];

    static var expectedSolutions:Map<Int, Array<String>> = [
        //0 => ['something', 'something'],
        1 => ['567171', '212428694'],
        2 => ['483', '482'],
        3 => ['265', '3154761400'],
        4 => ['245', '133'],
        5 => ['965', '524'],
        6 => ['6310', '3193'],
        7 => ['126', '220149'],
        8 => ['1331', '1121'],
        9 => ['36845998', '4830226'],
        10 => ['2210', 'something'],
        11 => ['2152', 'something'],
    ];

    static var actualSolutions:Map<Int, Array<String>> = new Map();

    static public function main() {
        for (dayClass in dayClasses) {
            Sys.println("");
            var className = Type.getClassName(dayClass).split(".").pop();
            Sys.println(className);
            var day = Type.createInstance(dayClass, []);

            Sys.println('  CHALLENGE_URL: ${day.CHALLENGE_URL}');
            var rawInputFirstLine = day.RAW_INPUT.substring(0, day.RAW_INPUT.indexOf("\n")).rtrim();
            Sys.println('  RAW_INPUT SAMPLE: "${rawInputFirstLine}"');
            Sys.println('  RAW_INPUT LENGTH: ${day.RAW_INPUT.length}');

            var partOne = day.solvePartOne();
            Sys.println('  Part One: ${partOne}');
            var partTwo = day.solvePartTwo();
            Sys.println('  Part Two: ${partTwo}');

            var dayRegex = ~/(\d+)/;
            dayRegex.match(className);
            var dayNum = Std.parseInt(dayRegex.matched(1));
            actualSolutions[dayNum] = [partOne, partTwo];
        }
        testAll();
    }

    inline static function assertTrue(cond:Bool, ?msg:String) {
        if (!cond) {
            if (msg == null) msg = "Assertion failed!";
            throw new haxe.Exception(msg);
        }
    }

    static function testAll() {
        var allGood = true;
        var failedTest = "";
        Sys.println("");
        Sys.print("Day   ");
        var orderedKeys = [for (k => _ in Main.actualSolutions) k];
        orderedKeys.sort(Reflect.compare);
        for (k in orderedKeys) Sys.print('${StringTools.lpad(Std.string(k), "0", 2)} ');
        Sys.println("");
        Sys.print("Parts ");
        for (k in orderedKeys) {
            var actual = actualSolutions[k];
            var expected = expectedSolutions[k];
            for (i => part in actual) {
                var pending = part == "pending";
                var ok = part == expected[i];
                if (allGood && !ok && !pending) {
                    allGood = false;
                    failedTest = 'Day$k: expected ${expected[i]}, was ${actual[i]}';
                }
                var resStr = if (pending) "P" else if (ok) "." else "F";
                Sys.print('$resStr');
            }
            Sys.print(' ');
        }

        Sys.println("\n");
        assertTrue(allGood, 'Some tests have Failed ($failedTest)');
    }
}
