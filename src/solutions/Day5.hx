package solutions;

import AOC_Utils as Utils;

using StringTools;

class Day5 extends BaseSolution {

    var seatIds:Array<Int> = [];

    public function new() {
        super();

        for (line in this.RAW_INPUT.split("\n")) {
            var binStr = line.replace("B", "1").replace("F", "0").replace("R", "1").replace("L", "0");
            seatIds.push(Utils.binaryStrToInt(binStr));
        }

        //var line = "BFFFBBFRRR";
        //var binStr = line.replace("B", "1").replace("F", "0").replace("R", "1").replace("L", "0");
        //Sys.println(binStr);
        //Sys.println(Utils.binaryStrToInt(binStr));
    }

    override public function solvePartOne():String {
        var maxSeatId = -1;
        for (pass in seatIds) {
            if (pass > maxSeatId) maxSeatId = pass;
        }

        return Std.string(maxSeatId);
    }

    override public function solvePartTwo():String {
        return Std.string("");
   }
}