package solutions;

import haxe.ds.ReadOnlyArray;
import AOC_Utils as Utils;

private enum abstract PassportField(String) to String {
    var byr; // (Birth Year) implicit value: "byr"
    var iyr; // (Issue Year)
    var eyr; // (Expiration Year)
    var hgt; // (Height)
    var hcl; // (Hair Color)
    var ecl; // (Eye Color)
    var pid; // (Passport ID)
    var cid; // (Country ID)

    public static final ALL_VALUES:ReadOnlyArray<PassportField> = Macros.getEnumValues(PassportField);

    public static function fromString(str:String):PassportField {
        if (PassportField.ALL_VALUES.indexOf(cast str) < 0)
            throw 'Error: Invalid enum value ("$str")';

        return cast str;
    }
}

private typedef Passport = Map<PassportField, String>;

class Day4 extends BaseSolution {

    var passports:Array<Passport> = [];

    public function new() {
        super();

        var oneLinePassportStr = "";
        var splitSpaceRegex = ~/\s+/g;
        for (line in this.RAW_INPUT.split("\n")) {
            if (line != "") {
                oneLinePassportStr += line + " ";
            } else {
                oneLinePassportStr = StringTools.trim(oneLinePassportStr);
                if (oneLinePassportStr != "") {
                    var passport = new Passport();
                    var pairs = splitSpaceRegex.split(oneLinePassportStr).map(s -> s.split(":"));
                    pairs.map(p -> passport[PassportField.fromString(p[0])] = p[1]);
                    passports.push(passport);
                }
                oneLinePassportStr = "";
            }
        }
    }

    function isValidPassport(passport:Passport, neededFields:Array<PassportField>):Bool {
        for (passportField in neededFields) {
            if (!passport.exists(passportField)) return false;
        }

        return true;
    }

    override public function solvePartOne():String {
        var validPassports = 0;

        var neededFields:Array<PassportField> = PassportField.ALL_VALUES.copy();
        neededFields.remove(PassportField.cid);

        for (passport in passports) {
            validPassports += Utils.boolToInt(this.isValidPassport(passport, neededFields));
        }

        return Std.string(validPassports);
    }

    override public function solvePartTwo():String {
        return Std.string("");
   }
}