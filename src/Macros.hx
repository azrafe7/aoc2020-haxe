package;

import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;
import sys.io.File;

using haxe.macro.Tools;

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

    // https://code.haxe.org/category/macros/enum-abstract-values.html
    public static macro function getEnumValues(typePath:Expr):Expr {
        // Get the type from a given expression converted to string.
        // This will work for identifiers and field access which is what we need,
        // it will also consider local imports. If expression is not a valid type path or type is not found,
        // compiler will give a error here.
        var type = Context.getType(typePath.toString());

        // Switch on the type and check if it's an abstract with @:enum metadata
        switch (type.follow()) {
            case TAbstract(_.get() => ab, _) if (ab.meta.has(":enum")):
                // @:enum abstract values are actually static fields of the abstract implementation class,
                // marked with @:enum and @:impl metadata. We generate an array of expressions that access those fields.
                // Note that this is a bit of implementation detail, so it can change in future Haxe versions, but it's been
                // stable so far.
                var valueExprs = [];
                for (field in ab.impl.get().statics.get()) {
                    if (field.meta.has(":enum") && field.meta.has(":impl")) {
                        var fieldName = field.name;
                        valueExprs.push(macro $typePath.$fieldName);
                    }
                }
                // Return collected expressions as an array declaration.
                return macro $a{valueExprs};
            default:
                // The given type is not an abstract, or doesn't have @:enum metadata, show a nice error message.
                throw new Error(type.toString() + " should be @:enum abstract", typePath.pos);
            }
      }
}