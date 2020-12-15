import solutions.*;

class Main {

    static var dayClasses:Array<Class<Dynamic>> = [
        Day1,
        Day2
    ];

    static public function main() {
        for (dayClass in dayClasses) {
            Sys.println("");
            Sys.println(Type.getClassName(dayClass).split(".").pop());
            var day = Type.createInstance(dayClass, []);
            
            var partOne = day.solvePartOne();
            Sys.println('  Part One: ${partOne}');
            var partTwo = day.solvePartTwo();
            Sys.println('  Part Two: ${partTwo}');
        }
    }
}
