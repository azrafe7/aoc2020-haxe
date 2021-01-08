package solutions;

import haxe.EnumTools;
using StringTools;

private enum abstract OpCmd(String) from String {
    var nop;
    var acc;
    var jmp;
}

@:structInit
private class OpCode {
    public var cmd:OpCmd;
    public var delta:Int;

    public function clone():OpCode {
        var cloned:OpCode = {cmd:this.cmd, delta:this.delta};
        return cloned;
    }

    public function toString() {
        return '{cmd:$cmd, delta:$delta}';
    }
}

private typedef Result = {
    var hasLoop:Bool;
    var accumulator:Int;
}

class Day8 implements BaseSolution {

    var opRegex = ~/(\w+) [+]?(-?\d+)/;

    var listing:Array<OpCode> = [];

    var TEST_INPUT_PART_1 = "nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6";

    public function new() {
        //this.RAW_INPUT = TEST_INPUT_PART_1;
        for (i => line in this.RAW_INPUT.split("\n")/*.slice(0,12)*/) {
            var hasMatched = opRegex.match(line);
            if (hasMatched) {
                var op = opRegex.matched(1);
                var num = Std.parseInt(opRegex.matched(2));
                var lineNum = StringTools.lpad(Std.string(i), "0", 3);
                //Sys.println('#$lineNum  $op($num)');
                var opCode:OpCode = {cmd:op, delta:num};
                listing.push(opCode);
            }
        }
    }

    function execute(listing:Array<OpCode>):Result {
        var result:Result = {hasLoop:false, accumulator:0,};

        var linesAlreadyRun = new Map();
        var lineNum = 0;
        while (lineNum < listing.length) {
            if (linesAlreadyRun.exists(lineNum)) {
                result.hasLoop = true;
                break;
            }
            var opCode = listing[lineNum];
            linesAlreadyRun[lineNum] = true;
            switch opCode.cmd {
                case acc:
                    result.accumulator += opCode.delta;
                    lineNum++;
                case nop:
                    lineNum++;
                case jmp:
                    lineNum += opCode.delta;
            }
        }

        return result;
    }

    public function solvePartOne():String {
        var result = execute(listing);

        return Std.string(result.accumulator);
    }

    public function solvePartTwo():String {
        var jmpOrNop = [];
        for (i => opCode in listing) if (opCode.cmd == jmp || opCode.cmd == nop) jmpOrNop.push(i);

        var i = 0;
        var result = null;
        var modifiedListing = listing.copy();
        do {
            result = execute(modifiedListing);
            if (result.hasLoop) {
                modifiedListing = listing.copy();
                var clonedOpCode = modifiedListing[jmpOrNop[i]].clone();
                modifiedListing[jmpOrNop[i]] = clonedOpCode;
                clonedOpCode.cmd = switch clonedOpCode.cmd {
                    case jmp: nop;
                    case nop: jmp;
                    case other: other;
                }
            }
            i++;
        } while (result.hasLoop && i < listing.length);

        //Sys.println('tries: $i  result: $result');
        return Std.string(result.accumulator);
    }
}