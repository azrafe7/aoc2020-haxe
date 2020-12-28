package;

@:autoBuild(Macros.addChallengeRawInputAndUrl())
interface BaseSolution {
    var CHALLENGE_URL:String;
    var RAW_INPUT:String;

    function solvePartOne():String;
    function solvePartTwo():String;
}