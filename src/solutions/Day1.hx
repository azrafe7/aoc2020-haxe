package solutions;

import sys.io.File;

class Day1 extends BaseSolution {

    public function new() {
        super();
        trace(Sys.getCwd());
        this.RAW_INPUT = File.getContent("challenges/inputs/Day1.txt");
        trace(this.RAW_INPUT);

        solve();
    }

    public function solve() {
        trace("solve()");
        var ints = this.RAW_INPUT.split("\n").map(Std.parseInt);
        trace(ints);
        var nInts = ints.length;
        var mulsIfSumTo2020 = [];
        for (i in 0...nInts - 1) {
            var iEntry = ints[i];
            for (j in i...nInts) {
                var jEntry = ints[j];
                var sum = iEntry + jEntry;
                if (sum == 2020) {
                    mulsIfSumTo2020.push(iEntry * jEntry);
                }
            }
        }
        trace(mulsIfSumTo2020);
    }
}