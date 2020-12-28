package;

import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;
import sys.io.File;

using haxe.macro.Tools;
using StringTools;

class Macros {
    public static var INPUTS_DIR = "challenges/inputs";
    public static var CHALLENGE_BASE_URL = "https://adventofcode.com/2020/day/";

    /**
     * Adds `RAW_INPUT` and `CHALLENGE_URL` fields (as public vars) at compile-time.
     *   `RAW_INPUT` will contain the input text of the challenge
     *   `CHALLENGE_URL` will contain the url pointing to the related online challenge
     *
     * Used for subclassesof `BaseSolution`.
     *
     * (adapted from https://code.haxe.org/category/macros/include-file-next-to-module-file.html)
     */
    public static function addChallengeRawInputAndUrl():Array<Field> {
        var fields:Array<Field> = Context.getBuildFields();

        var posInfos = Context.getPosInfos(Context.currentPos());
        var directory = Sys.getCwd(); // root dir (the one with the .hxml)

        var ref:ClassType = Context.getLocalClass().get();
        // path to the file containing the input ("DayX.txt")
        var inputFile = ref.name + ".txt";
        var filePath:String = Path.join([directory, INPUTS_DIR, inputFile]);

        // detect if template file exists
        if (FileSystem.exists(filePath)) {
            var fileContent:String = File.getContent(filePath);
            // replace "\r\n" with "\n"
            fileContent = fileContent.replace("\r\n", "\n");
            Sys.println('Adding "${inputFile}" contents');

            // add a field called "RAW_INPUT" to the current fields of the class
            fields.push({
                name:  "RAW_INPUT",
                access:  [Access.APublic],
                kind: FieldType.FVar(macro:String, macro $v{fileContent}),
                pos: Context.currentPos(),
                doc: "auto-generated from " + filePath,
            });
        } else {
            //Sys.println('Skipping "${inputFile}" (not found)');
        }

        // add a field called "CHALLENGE_URL" to the current fields of the class
        var extractDayNum = ~/[^\d]+(\d)+/;
        if (extractDayNum.match(ref.name)) {
            var dayNum = extractDayNum.matched(1);
            fields.push({
                name:  "CHALLENGE_URL",
                access:  [Access.APublic],
                kind: FieldType.FVar(macro:String, macro $v{CHALLENGE_BASE_URL + dayNum}),
                pos: Context.currentPos(),
                doc: "auto-generated from " + filePath,
            });
        }

        return fields;
    }
}