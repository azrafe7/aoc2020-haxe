package solutions;

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
        this.joltageRatings = [for (i => int in this.RAW_INPUT.trim().split("\n").map(Std.parseInt)) int];
        //Sys.println(joltageRatings);

        sortedJoltageRatings = joltageRatings.copy();
        sortedJoltageRatings.sort(Reflect.compare);
        maxRating = sortedJoltageRatings[sortedJoltageRatings.length - 1] + 3;
        //Sys.println(sortedJoltageRatings);
        //Sys.println(maxRating);
    }

    public function solvePartOne():String {
        var startRating = 0;

        for (i in 0...sortedJoltageRatings.length) {
            var currRating = sortedJoltageRatings[i];
            var delta = currRating - startRating;
            if (!freqs.exists(delta)) freqs[delta] = 0;
            freqs[delta] += 1;
            startRating = currRating;
        }
        freqs[3] += 1;

        Sys.println(Std.string(freqs));
        return Std.string(freqs[1] * freqs[3]);
    }

    public function solvePartTwo():String {
        return Std.string("");
    }
}