package views
{
    import models.*
    import flash.display.Shape;

    public class CommitActivityGraph extends Shape
    {
        public static const msecsInHour:Number = 1000 * 60 * 60;
        public static const msecsInDay:Number = msecsInHour * 24;
        public static const offset:Number = 7; //this is the offset over at github, in hours, from UTC.

        public static function countCommits(start:Date, end:Date, commitData:CommitListModel):Array
        {
            //time after epoch in milliseconds for start of day for start.
            var startPoint:Number = Date.UTC(start.fullYearUTC, start.monthUTC, start.dateUTC) + offset*msecsInHour;
            //time after epoch for end of day for for end
            var endPoint:Number = Date.UTC(end.fullYearUTC, end.monthUTC, end.dateUTC + 1) + offset*msecsInHour;
            //this is the number of days between start and end, inclusive both ends
            var deltaT:Number = Math.floor( (endPoint - startPoint)/ msecsInDay );
            //an array containing counters for commits on each day between start and end inclusive
            var counters:Array = new Array(deltaT);
            //initialize the array.
            for (var i:Number =0; i < counters.length; i++)
                counters[i] = 0;

            var commits:Number = commitData.length;
            var commitTime:Number;
            for (i = 0; i < commits; i++)
            {
                commitTime = commitData[i].committedDate.valueOf();
                if (commitTime > startPoint && commitTime < endPoint)
                {
                    //since the date is inside the range, find out what day it is on
                    //and increment the count there
                    counters[Math.floor((commitTime - startPoint) / msecsInDay)] += 1;
                }
            }

            return counters;
        }

        public static function countCommitsFromNow(numDays:Number, commitData:CommitListModel):Array
        {
            var now:Date = new Date();
            var start:Date = new Date(now.valueOf() - (numDays - 1)*msecsInDay);
            return countCommits(start, now, commitData);
        }

        public static function countFromRecentCommits(numDays:Number, commitData:CommitListModel):Array
        {
            var end:Date = commitData[0].committedDate;
            var start:Date = new Date(end.valueOf() - (numDays - 1)*msecsInDay);
            return countCommits(start, end, commitData);
        }

        public static function getHighest(searchIn:Array):Number
        {
            var highVal:Number = 0;
            for each (var val:Number in searchIn)
            {
                if (val > highVal)
                    highVal = val;
            }
            return highVal;
        }

        public var color:uint = 0x000000;
        public var maxWidth:Number = 250;
        public var maxHeight:Number = 20;
        public var spacing:Number = 2;
        public var daysBack:Number = 21;
        public var commitData:CommitListModel;


        public function redraw():void
        {
            graphics.clear();
            if (commitData == null)
                return ;
            //get counts
            var counts:Array = countCommitsFromNow(daysBack, commitData);
            trace(counts);
            //find highest count for conversion factor.
            var maxCount:Number = getHighest(counts);
            //generate conversion factor and other number
            var heightConv:Number = maxHeight / maxCount;
            var colWidth:Number = Math.floor((maxWidth + spacing) / daysBack - spacing);
            graphics.beginFill(color);

            var baseLine:Number = y + maxHeight;
            var curHeight:Number;

            //draw each rectangle
            for (var i:Number = 0; i < counts.length; i++)
            {
                if (counts[i] > 0)
                    curHeight = counts[i] * heightConv;
                else
                    curHeight = 1;
                graphics.drawRect(x + (colWidth + spacing)*i, baseLine - curHeight, colWidth, curHeight);

            }

            graphics.endFill();
        }


        
    }
}
