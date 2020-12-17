package solutions;

import haxe.ds.ReadOnlyArray;
import AOC_Utils as Utils;

using StringTools;

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

private class StrictRules {

    inline public static function isStringOfLength(str:String, len:Int):Bool {
        return str.length == len;
    }

    inline public static function isStringIntBetween(intStr, min:Int, maxInclusive:Int):Bool {
        var num:Int = Std.parseInt(intStr);
        return num >= min && num <= maxInclusive;
    }

    public static function isFieldValid(passport:Passport, field:PassportField):Bool {
        var value = passport[field];
        return switch (field) {
            case PassportField.byr:
                isStringOfLength(value, 4) && isStringIntBetween(value, 1920, 2002);
            case PassportField.iyr:
                isStringOfLength(value, 4) && isStringIntBetween(value, 2010, 2020);
            case PassportField.eyr:
                isStringOfLength(value, 4) && isStringIntBetween(value, 2020, 2030);
            case PassportField.hgt:
                (value.endsWith('cm') && isStringIntBetween(value, 150, 193))
                || (value.endsWith('in') && isStringIntBetween(value, 59, 76));
            case PassportField.hcl:
                isStringOfLength(value, 7) && value.startsWith("#") && ~/[0-9a-f]/.match(value);
            case PassportField.ecl:
                ~/amb|blu|brn|gry|grn|hzl|oth/.match(value);
            case PassportField.pid:
                isStringOfLength(value, 9) && ~/\d{9}/.match(value);
            default: false;
        }
    }
}

class Day4 extends BaseSolution {

    var passports:Array<Passport> = [];

    var neededFields:Array<PassportField> = null; // initialized in constructor

    public function new() {
        super();

        this.neededFields = PassportField.ALL_VALUES.copy();
        this.neededFields.remove(PassportField.cid);

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

        for (passport in passports) {
            validPassports += Utils.boolToInt(this.isValidPassport(passport, this.neededFields));
        }

        return Std.string(validPassports);
    }

    function isStrictlyValidPassport(passport:Passport):Bool {
        if (!this.isValidPassport(passport, neededFields)) return false;

        for (passportField in neededFields) {
            if (!StrictRules.isFieldValid(passport, passportField)) return false;
        }

        return true;
    }

    override public function solvePartTwo():String {
        var strictlyValidPassports = 0;

        for (passport in passports) {
            strictlyValidPassports += Utils.boolToInt(this.isStrictlyValidPassport(passport));
        }

        return Std.string(strictlyValidPassports);
    }
}