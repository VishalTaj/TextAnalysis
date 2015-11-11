<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Mr X</title>
    <style>
    body{
      background:steelblue;
    }
    path {
      stroke: #ffffff;
      stroke-width: 3px;
    }
    div {
      float: left;
      margin-right: 50px;
    }
    #chart .c3-line-data2 {
  stroke-width: 5px;
}
h2{
  text-transform: uppercase;
  font-size: 16px;
}
    </style>
    <link href="c3.min.css" rel="stylesheet" type="text/css">

          <script src="d3.min.js"></script>
      <script src="c3.min.js"></script>
  </head>
  <body>
    <div id="before-chart">
      <h2>Polling History</h2>
    </div>
    <div id="after-chart">
      <h2>Expected Polling</h2>
    </div>
    <script>
      var data = [

        {'name':'Not Supporting','value':{{negative}}},
        {'name':'Supporting','value':{{positive}}},
        {'name':'Partial Supporting', 'value':{{partial}}},
        {'name':'No comments', 'value':{{nocomments}}}
      ]
      var margin = {top: 20, right: 20, bottom: 20, left: 20};
  	width = 400 - margin.left - margin.right;
  	height = width - margin.top - margin.bottom;
    var r = height/2;
  var chart = d3.select("#before-chart")
  				.append('svg')
  			    .attr("width", width + margin.left + margin.right)
  			    .attr("height", height + margin.top + margin.bottom)
            .style("border","1px solid rgba(255,255,255,0.2)")
  			   .append("g")
      			.attr("transform", "translate(" + ((width/2)+margin.left) + "," + ((height/2)+margin.top) + ")");


  var radius = Math.min(width, height) / 2;

  var color = d3.scale.ordinal()
  	.range(["#3399FF", "#5DAEF8", "#86C3FA", "#ADD6FB", "#D6EBFD"]);

  var arc = d3.svg.arc()
      .outerRadius(radius)
      .innerRadius(radius - 20);

  var pie = d3.layout.pie()
      .sort(null)
      .startAngle(1.1*Math.PI)
      .endAngle(3.1*Math.PI)
      .value(function(d) { return d.value; });


  var g = chart.selectAll(".arc")
    .data(pie(data))
  .enter().append("g")
    .attr("class", "arc")
    .on('mouseover', function(){
      d3.select(this)
        .select("text")
        .style("opacity",1)
    })
    .on('mouseout', function(){
      d3.select(this)
        .select("text")
          .style("opacity",0)
    });


  g.append("path")
    .style("fill", function(d) { return color(d.data.name); })
    .transition().delay(function(d, i) { return i * 500; }).duration(500)
    .attrTween('d', function(d) {
         var i = d3.interpolate(d.startAngle+0.1, d.endAngle);
         return function(t) {
             d.endAngle = i(t);
           return arc(d);
         }
    });


    g.append("text")
      .style("fill","#FFF")
      .style("opacity",0)
      .style("font-size","14px")
      .style("text-transform",'uppercase')
      .attr("transform", "translate(0,0)")
      .attr("text-anchor", "middle")
      .text(function(d){ return d.data.value+" people \n"+d.data.name+" Mr. X"; });


    </script>
  </body>


</html>
