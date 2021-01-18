package solutions;

import haxe.Int64;

using StringTools;

class Day10 implements BaseSolution {

    var TEST_INPUT_PART_ONE = "16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4";

    var TEST_INPUT_PART_ONE_LARGER = "28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3";

    var joltageRatings:Array<Int> = [];
    var sortedJoltageRatings:Array<Int> = [];
    var maxRating:Int = -1;
    var freqs:Map<Int, Int> = new Map();

    public function new() {
        //this.RAW_INPUT = TEST_INPUT_PART_ONE;
        //this.RAW_INPUT = TEST_INPUT_PART_ONE_LARGER;
        //this.RAW_INPUT = "1\n3\n4\n5\n7";
        this.joltageRatings = [for (i => int in this.RAW_INPUT.trim().split("\n").map(Std.parseInt)) int];
        //Sys.println(joltageRatings);

        sortedJoltageRatings = joltageRatings.copy();
        sortedJoltageRatings.sort(Reflect.compare);
        maxRating = sortedJoltageRatings[sortedJoltageRatings.length - 1] + 3;
        Sys.println(sortedJoltageRatings);
        //Sys.println(maxRating);
    }

    public function solvePartOne():String {
        var startRating = 0;

        for (_ => currRating in sortedJoltageRatings) {
            var delta = currRating - startRating;
            if (!freqs.exists(delta)) freqs[delta] = 0;
            freqs[delta] += 1;
            startRating = currRating;
        }
        if (!freqs.exists(3)) freqs[3] = 0;
        freqs[3] += 1;

        //Sys.println(Std.string(freqs));
        return Std.string(freqs[1] * freqs[3]);
    }

    public function solvePartTwo():String {
        var startRating = maxRating;
        var numArrangements:Int = 1; // a chain using all the adapters is guaranteed

        var ratingsSet:Map<Int, Bool> = [for (i => rating in sortedJoltageRatings) rating => true];

        sortedJoltageRatings.unshift(0);
        var diffs = [for (i in 0...sortedJoltageRatings.length - 1) sortedJoltageRatings[i+1] - sortedJoltageRatings[i]];
        //Sys.println(diffs);
        var i = sortedJoltageRatings.length - 1;
        while (i >= 0) {
            var possibleNextAdapters = 0;
            var adapters = [];
            for (delta in [-1,-2,-3]) {
                var nextRating = startRating + delta;
                if (ratingsSet.exists(startRating + delta)) {
                    possibleNextAdapters++;
                    adapters.push(startRating + delta);
                }
            }
            if (possibleNextAdapters > 1) {
                //Sys.println(adapters);
                numArrangements += numArrangements * (possibleNextAdapters - 1);
            }
            startRating = sortedJoltageRatings[i];
            i--;
        }

        return Std.string("pending");
    }
}