package solutions;

private typedef StringSet = Map<String, Bool>;

class Day6 extends BaseSolution {

    var groups:Array<Array<String>> = [];

    public function new() {
        super();

        var group = [];
        for (line in this.RAW_INPUT.split("\n")) {
            if (line != "") {
                group.push(line);
            } else {
                groups.push(group);
                group = [];
            }
        }

        //Sys.println(groups);
    }

    override public function solvePartOne():String {
        var sum = 0;

        for (group in groups) {
            var yesAnswers = new StringSet();
            for (answers in group) {
                for (answer in answers.split("")) {
                    yesAnswers[answer] = true;
                }
            }
            sum += [for (k in yesAnswers.keys()) k].length;
        }

        return Std.string(sum);
    }

    override public function solvePartTwo():String {
        var sum = 0;

        for (group in groups) {
            var yesAnswers = new Map<String, Int>();
            for (answers in group) {
                for (answer in answers.split("")) {
                    if (!yesAnswers.exists(answer)) yesAnswers[answer] = 0;
                    yesAnswers[answer] += 1;
                }
            }
            var yesCounts = [for (k => v in yesAnswers.keyValueIterator()) v];
            sum += Lambda.filter(yesCounts, (count) -> count == group.length).length;
        }

        return Std.string(sum);
   }
}