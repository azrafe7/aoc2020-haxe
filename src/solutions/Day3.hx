package solutions;

class Day3 extends BaseSolution {

    var mapTile:Array<Array<String>> = [];
    var mapTileRows:Int;
    var mapTileCols:Int;

    var SLOPES_X = [1, 3, 5, 7, 1];
    var SLOPES_Y = [1, 1, 1, 1, 2];

    public function new() {
        super();

        for (line in this.RAW_INPUT.split("\n")) {
            this.mapTile.push(line.split(""));
        }

        this.mapTileRows = this.mapTile.length;
        this.mapTileCols = this.mapTile[0].length;
        //Sys.println('${this.mapTile[0]} (${this.mapTileRows}R x ${this.mapTileCols}C)');
    }

    function countTrees(slopeX:Int, slopeY:Int):Int {
        var posX = 0;
        var posY = 0;
        var treeCount = 0;

        var overTheBottom = false;
        while (!overTheBottom) {
            posX += slopeX;
            posY += slopeY;
            overTheBottom = posY >= this.mapTileRows;
            if (!overTheBottom) {
                if (this.mapTile[posY][posX % this.mapTileCols] == "#") treeCount++;
            }
        }

        return treeCount;
    }

    override public function solvePartOne():String {
        var treeCount = this.countTrees(3, 1);

        return Std.string(treeCount);
    }

    override public function solvePartTwo():String {
        var treeCount = 0;
        var product:Float = 1.0;

        for (i in 0...this.SLOPES_X.length) {
            treeCount = this.countTrees(SLOPES_X[i], SLOPES_Y[i]);
            product *= treeCount;
        }

        return Std.string(product);
   }
}