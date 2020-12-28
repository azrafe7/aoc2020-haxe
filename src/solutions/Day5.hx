package solutions;

import AOC_Utils as Utils;

using StringTools;

class Day5 implements BaseSolution {

    var seatIds:Array<Int> = [];

    public function new() {
        for (line in this.RAW_INPUT.split("\n")) {
            var binStr = line.replace("B", "1").replace("F", "0").replace("R", "1").replace("L", "0");
            seatIds.push(Utils.binaryStrToInt(binStr));
        }

        //var line = "BFFFBBFRRR";
        //var binStr = line.replace("B", "1").replace("F", "0").replace("R", "1").replace("L", "0");
        //Sys.println(binStr);
        //Sys.println(Utils.binaryStrToInt(binStr));
    }

    public function solvePartOne():String {
        var maxSeatId = -1;
        for (pass in seatIds) {
            if (pass > maxSeatId) maxSeatId = pass;
        }

        return Std.string(maxSeatId);
    }

    public function solvePartTwo():String {
        var sortedSeatIds = seatIds.copy();
        sortedSeatIds.sort((a, b) -> a - b);

        var mySeat = [];
        for (i in 1...sortedSeatIds.length) {
            var prevSeatId = sortedSeatIds[i-1];
            if (sortedSeatIds[i] - prevSeatId == 2) {
                mySeat.push(prevSeatId + 1);
            }
        }

        return Std.string(mySeat[0]);
   }
}