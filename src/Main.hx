import solutions.*;

class Main {

    static var dayClasses:Array<Class<Dynamic>> = [
        //Day1,
        //Day2,
        //Day3,
        //Day4,
        //Day5,
        Day6,
    ];

    static public function main() {
        for (dayClass in dayClasses) {
            Sys.println("");
            Sys.println(Type.getClassName(dayClass).split(".").pop());
            var day = Type.createInstance(dayClass, []);

            Sys.println('  CHALLENGE_URL: ${day.CHALLENGE_URL}');
            var rawInputFirstLine = day.RAW_INPUT.substring(0, day.RAW_INPUT.indexOf("\n") - 1);
            Sys.println('  RAW_INPUT SAMPLE: "${rawInputFirstLine}"');
            Sys.println('  RAW_INPUT LENGTH: ${day.RAW_INPUT.length}');

            var partOne = day.solvePartOne();
            Sys.println('  Part One: ${partOne}');
            var partTwo = day.solvePartTwo();
            Sys.println('  Part Two: ${partTwo}');
        }
    }
}
