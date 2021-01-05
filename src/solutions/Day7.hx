package solutions;

import haxe.format.JsonPrinter;
import AOC_Utils as Utils;

private typedef BagColor = String;

private typedef CanContainEntry = {
    var bagColor:BagColor;
    var numOfBags:Int;
}

private typedef StringSet = Map<String, Bool>;

class Day7 implements BaseSolution {

    var containerBagRegex = ~/(\w+ \w+) bags contain /;
    var canContainRegex = ~/(\d+)\s*(\w+ \w+) bag[s]?/;

    var bagMap:Map<BagColor, Array<CanContainEntry>> = new Map();

    public function new() {
        /*this.RAW_INPUT = "light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.";*/
        for (line in this.RAW_INPUT.split("\n")/*.slice(0,12)*/) {
            var hasMatched = containerBagRegex.match(line);
            if (hasMatched) {
                var containerBag = containerBagRegex.matched(1);
                var canContain = [];
                while (canContainRegex.match(line)) {
                    var numOfBags = canContainRegex.matched(2) == "no other" ? 0 : Std.parseInt(canContainRegex.matched(1));
                    var bagColor = Std.string(canContainRegex.matched(2));

                    if (numOfBags > 0) {
                        var canContainEntry:CanContainEntry = {bagColor:bagColor, numOfBags:numOfBags};
                        canContain.push(canContainEntry);
                    }
                    line = canContainRegex.matchedRight();
                }
                bagMap[containerBag] = canContain;
            }
        }
        var prettyBagMap = JsonPrinter.print(bagMap, null, "  ");
        //Sys.println(prettyBagMap);
        Sys.println(Lambda.array(bagMap).length);
    }

    function _traverseBagMap(containerBag:BagColor, canContainBagColor:BagColor, ancestorBag, possibleTopContainers) {
        var entries:Array<CanContainEntry> = bagMap[containerBag];
        for (e in entries) {
            if (e.bagColor == canContainBagColor) {
                Sys.println('${containerBag} ($ancestorBag) can contain $canContainBagColor');
                possibleTopContainers.push(ancestorBag);
            } else _traverseBagMap(e.bagColor, canContainBagColor, ancestorBag, possibleTopContainers);
        }
        return possibleTopContainers;
    }

    public function solvePartOne():String {
        var targetBag = "shiny gold";

        var bagKeys = [for (k in bagMap.keys()) k];
        var possibleTopContainers = [];
        while (bagKeys.length > 0) {
            var bagKey = bagKeys.pop();
            _traverseBagMap(bagKey, targetBag, bagKey, possibleTopContainers);
        }

        var uniqueTopContainers = Utils.arrayUnique(possibleTopContainers);
        var canContainTargetBag = uniqueTopContainers.length;
        return Std.string(canContainTargetBag);
    }

    public function solvePartTwo():String {
        return Std.string("");
   }
}