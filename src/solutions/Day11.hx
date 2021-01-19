package solutions;

using StringTools;
using Lambda;

private enum abstract Seat(String) from String to String {
    var FLOOR = ".";
    var EMPTY = "L";
    var OCCUPIED = "#";
}

class Day11 implements BaseSolution {

    var TEST_INPUT_PART_ONE = "L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL";

    var seats:Array<Array<Seat>> = [];
    var numRows:Int;
    var numCols:Int;

    public function new() {
        //this.RAW_INPUT = TEST_INPUT_PART_ONE;
        for (line in this.RAW_INPUT.trim().split("\n").map(StringTools.trim)) {
            var seatRow:Array<Seat> = [for (tile in line.split("")) (tile:Seat)];
            //Sys.println(seatRow);
            seats.push(seatRow);
        }

        this.numRows = seats.length;
        this.numCols = seats[0].length;
        addFloorBorders(seats);
        printSeats();
    }

    inline function printSeats() {
        //Sys.println('-- SEATS [${numRows}R x ${numCols}C]');
        //for (row in seats) Sys.println(Std.string(row).split(",").join(""));
    }

    function addFloorBorders(seats:Array<Array<Seat>>):Void {
        var floorLine = [for (i in 0...seats[0].length) Seat.FLOOR];
        seats.unshift(floorLine);
        for (row in seats) {
            row.unshift(Seat.FLOOR);
            row.push(Seat.FLOOR);
        }
        seats.push(floorLine);
    }

    function countOccupiedNeighbours(seats:Array<Array<Seat>>, row:Int, col:Int):Int {
        var occupied = 0;
        for (rowDelta in -1...2) {
            for (colDelta in -1...2) {
                if (rowDelta == 0 && colDelta == 0) continue;
                else if (seats[row + rowDelta][col + colDelta] == Seat.OCCUPIED) occupied++;
            }
        }

        return occupied;
    }

    function updateSeats(seats:Array<Array<Seat>>, ?step:Int):Bool {
        //if (step != null) Sys.println('\n-- Step $step');

        // clone seats
        var seatsClone = [for (row in seats) [for (seat in row) seat]];

        var hasChanges = false;
        for (r in 1...numRows + 1) {
            for (c in 1...numCols + 1) {
                var seat = seatsClone[r][c];
                var occupiedNeighbours = countOccupiedNeighbours(seatsClone, r, c);
                if (seat == Seat.EMPTY && occupiedNeighbours == 0) {
                    seats[r][c] = Seat.OCCUPIED;
                    hasChanges = true;
                } else if (seat == Seat.OCCUPIED && occupiedNeighbours >= 4) {
                    seats[r][c] = Seat.EMPTY;
                    hasChanges = true;
                }
            }
        }

        printSeats();

        return hasChanges;
    }

    public function solvePartOne():String {
        // replace EMPTY with OCCUPIED
        for (r => row in seats) {
            seats[r] = row.map(ch -> if (ch == Seat.EMPTY) Seat.OCCUPIED else ch);
        }

        printSeats();
        var i = 0;
        var hasChanges = true;
        while (hasChanges) {
            hasChanges = updateSeats(seats, i);
            i++;
        }

        var numOccupied = Lambda.flatten(seats).filter(it -> it == Seat.OCCUPIED).length;
        return Std.string(numOccupied);
    }

    public function solvePartTwo():String {
        return Std.string("");
    }
}