package solutions;

import AOC_Utils as Utils;

typedef PasswordInfo = {
    min:Int,
    max:Int,
    char:String,
    password:String
}

class Day2 extends BaseSolution {

    var passwordData:Array<PasswordInfo> = [];

    public function new() {
        super();

        var lines = this.RAW_INPUT.split("\n");

        var extractRegex = ~/(\d+)-(\d+) (\w): (\w+)/;
        for (line in lines) {
            extractRegex.match(line);
            var pwdInfo = {
                min:Std.parseInt(extractRegex.matched(1)),
                max:Std.parseInt(extractRegex.matched(2)),
                char:extractRegex.matched(3),
                password:extractRegex.matched(4)
            };

            //trace(pwdInfo);

            this.passwordData.push(pwdInfo);
        }
    }

    public function countOccurrencesOf(char:String, targetString:String) {
        var count = 0;
        var chars = targetString.split("");
        for (c in chars) {
            if (c == char) count++;
        }

        return count;
    }

    override public function solvePartOne():String {
        var validPasswords = 0;
        for (pwdInfo in this.passwordData) {
            var occurrences = this.countOccurrencesOf(pwdInfo.char, pwdInfo.password);
            if (occurrences >= pwdInfo.min && occurrences <= pwdInfo.max) validPasswords++;
        }

        return Std.string(validPasswords);
    }

    override public function solvePartTwo():String {
        var validPasswords = 0;
        for (pwdInfo in this.passwordData) {
            var len = pwdInfo.password.length;
            var pwd = pwdInfo.password;
            var minMatches = pwd.charAt(pwdInfo.min - 1) == pwdInfo.char;
            var maxMatches = pwd.charAt(pwdInfo.max - 1) == pwdInfo.char;
            if (Utils.boolXor(minMatches, maxMatches)) validPasswords++;
        }

        return Std.string(validPasswords);
   }
}