package solutions;

class Day1 implements BaseSolution {

    public function solvePartOne():String {
        var ints = this.RAW_INPUT.split("\n").map(Std.parseInt);

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

        return Std.string(mulsIfSumTo2020);
    }

    public function solvePartTwo():String {
        var ints = this.RAW_INPUT.split("\n").map(Std.parseInt);

        var nInts = ints.length;
        var mulsIfSumTo2020 = [];
        for (i in 0...nInts - 2) {
            var iEntry = ints[i];
            for (j in i...nInts - 1) {
                var jEntry = ints[j];
                for (k in i...nInts) {
                    var kEntry = ints[k];
                    var sum = iEntry + jEntry + kEntry;
                    if (sum == 2020) {
                        mulsIfSumTo2020.push(iEntry * jEntry * kEntry);
                    }
                }
            }
        }

        return Std.string(mulsIfSumTo2020);
    }
}