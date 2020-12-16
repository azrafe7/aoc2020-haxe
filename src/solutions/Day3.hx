package solutions;

class Day3 extends BaseSolution {

    var mapTile:Array<Array<String>> = [];
    var mapTileRows:Int;
    var mapTileCols:Int;

    public function new() {
        super();

        for (line in this.RAW_INPUT.split("\n")) {
            this.mapTile.push(line.split(""));
        }

        this.mapTileRows = this.mapTile.length;
        this.mapTileCols = this.mapTile[0].length;
        //Sys.println('${this.mapTile[0]} (${this.mapTileRows}R x ${this.mapTileCols}C)');
    }

    override public function solvePartOne():String {
        var offsetX = 3;
        var offsetY = 1;
        var posX = 0;
        var posY = 0;
        var treeCount = 0;

        var overTheBottom = false;
        while (!overTheBottom) {
            posX += offsetX;
            posY += offsetY;
            overTheBottom = posY >= this.mapTileRows;
            if (!overTheBottom) {
                if (this.mapTile[posY][posX % this.mapTileCols] == "#") treeCount++;
            }
        }

        return Std.string(treeCount);
    }

    override public function solvePartTwo():String {
        return Std.string("");
   }
}