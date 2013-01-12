$(document).ready(function () {
  $('#campaign_show_tab').tab('show');
  $('#campaign_show_tab a[href="#summary"]').tab('show');


  if ($('#sentiment_by_day_chart').length > 0) {
    var sentiment_by_day_data = $('#sentiment_by_day_chart').data('sentiment_by_day');
    new Highcharts.Chart({
      colors:['#4572A7'],
      chart:{
        renderTo:$('#sentiment_by_day_chart')[0],
        type:'areaspline',
        height:400,
        width:890,
        marginTop:20
      },
      title:{
        text:null
      },
      xAxis:{
        labels:{
          formatter:function () {
            var dataPoint = sentiment_by_day_data[this.value];
            return dataPoint && dataPoint[0];
          },
          style:{
            color:'#aaaaaa',
            fontSize:'12px'
          },
          x:0,
          y:20
        },
        tickWidth:0,
        tickPixelInterval:120,
        gridLineWidth:0,
        allowDecimals:false,
        title:{
          text:null
        }
      },
      yAxis:{
        gridLineWidth:0.5,
        gridLineColor:'#dfdfdf',
        title:{
          text:null
        },
        labels:{
          style:{
            color:'#aaaaaa',
            fontSize:'12px'
          }
        },
        min:0
      },
      legend:{
        enabled:true,
        borderWidth:0,
        align:"left",
        floating:true,
        x:0,
        y:30,
        itemStyle:{
          cursor:'default',
          color:'#dfdfdf',
          fontFamily:'"museo-slab-1","museo-slab-2", sans-serif',
          fontSize:'14px'
        }
      },
      tooltip:{
        formatter:function () {
          return "Brand sentiment for " + sentiment_by_day_data[this.points[0].x][0] + ": " + this.points[0].y;
        },
        shared:true,
        backgroundColor:'rgba(, 0, 0, .90)',
        borderWidth:10,
        borderColor:'#000',
        shadow:false,
        style:{
          color:'white'
        }
      },
      credits:{
        enabled:false
      },
      plotOptions:{
        column:{
          pointPadding:0.02,
          borderWidth:0,
          shadow:false
        }
      },
      series:[
        {
          data:sentiment_by_day_data,
          name:"Sentiment over time"
        }
      ]
    })
  }

  if ($('#brand_sentiment_by_day_chart').length > 0) {
    var brand_sentiment_by_day_data = $('#brand_sentiment_by_day_chart').data('brand_sentiment_by_day');
    new Highcharts.Chart({
      colors:['#4572A7'],
      chart:{
        renderTo:$('#brand_sentiment_by_day_chart')[0],
        type:'areaspline',
        height:400,
        width:890,
        marginTop:20
      },
      title:{
        text:null
      },
      xAxis:{
        labels:{
          formatter:function () {
            var dataPoint = brand_sentiment_by_day_data[this.value];
            return dataPoint && dataPoint[0];
          },
          style:{
            color:'#aaaaaa',
            fontSize:'12px'
          },
          x:0,
          y:20
        },
        tickWidth:0,
        tickPixelInterval:120,
        gridLineWidth:0,
        allowDecimals:false,
        title:{
          text:null
        }
      },
      yAxis:{
        gridLineWidth:0.5,
        gridLineColor:'#dfdfdf',
        title:{
          text:null
        },
        labels:{
          style:{
            color:'#aaaaaa',
            fontSize:'12px'
          }
        },
        min:0
      },
      legend:{
        enabled:true,
        borderWidth:0,
        align:"left",
        floating:true,
        x:0,
        y:30,
        itemStyle:{
          cursor:'default',
          color:'#dfdfdf',
          fontFamily:'"museo-slab-1","museo-slab-2", sans-serif',
          fontSize:'14px'
        }
      },
      tooltip:{
        formatter:function () {
          return "Brand sentiment for " + brand_sentiment_by_day_data[this.points[0].x][0] + ": " + this.points[0].y;
        },
        shared:true,
        backgroundColor:'rgba(, 0, 0, .90)',
        borderWidth:10,
        borderColor:'#000',
        shadow:false,
        style:{
          color:'white'
        }
      },
      credits:{
        enabled:false
      },
      plotOptions:{
        column:{
          pointPadding:0.02,
          borderWidth:0,
          shadow:false
        }
      },
      series:[
        {
          data:brand_sentiment_by_day_data,
          name:"Sentiment over time"
        }
      ]
    })
  }

  if ($('#live_campaign_tweet_volume_chart').length > 0) {    
    new Highcharts.Chart({
      colors:['#4572A7'],
      chart:{
        renderTo:$('#live_campaign_tweet_volume_chart')[0],
        type:'areaspline',
        events:{
          load:function () {
            // set up the updating of the chart each second
            var series = this.series[0];
            setInterval(function () {
              var campaign_id = $('#live_campaign_tweet_volume_chart').data('campaign_id');
              $.get('/tweets/count/?type=campaign&id=' + campaign_id, function (response) {
                var x = (new Date()).getTime(); // current time
                var y = parseInt(response);
                var point = [x, y];

                series.addPoint(point, true, true);
              });
            }, 3000);
          }
        },
        height:400,
        width:890,
        marginTop:20
      },
      title:{
        text:null
      },
      xAxis:{
        type: 'datetime',
        tickPixelInterval: 150
      },
      yAxis:{
        gridLineWidth:0.5,
        gridLineColor:'#dfdfdf',
        title:{
          text:null
        },
        labels:{
          style:{
            color:'#aaaaaa',
            fontSize:'12px'
          }
        },
        min:0
      },
      legend:{
        enabled:true,
        borderWidth:0,
        align:"left",
        floating:true,
        x:0,
        y:30,
        itemStyle:{
          cursor:'default',
          color:'#dfdfdf',
          fontFamily:'"museo-slab-1","museo-slab-2", sans-serif',
          fontSize:'14px'
        }
      },
      tooltip:{
        formatter:function () {
          return "Brand sentiment for " + sentiment_by_day_data[this.points[0].x][0] + ": " + this.points[0].y;
        },
        shared:true,
        backgroundColor:'rgba(, 0, 0, .90)',
        borderWidth:10,
        borderColor:'#000',
        shadow:false,
        style:{
          color:'white'
        }
      },
      credits:{
        enabled:false
      },
      plotOptions:{
        column:{
          pointPadding:0.02,
          borderWidth:0,
          shadow:false
        }
      },
      series:[
        {
           data: (function() {
                // generate an array of random data
                var data = [],
                    time = (new Date()).getTime(),
                    i;

                for (i = -20; i <= 0; i++) {
                    data.push({
                        x: time + i * 3000,
                        y: 0
                    });
                }
                return data;
            })(),


              name:""
        }
      ]
    })
  }


  /////////////////// This is the stuff for realtime tweets /////////////////////

  setInterval(function() {  
    var campaign_id = $('#live_campaign_tweet_volume_chart').data('campaign_id');
    
    var url = "/tweets?campaign_id=" + campaign_id;
    $.get(url, function(response) {  
      console.log(response);
       $("#recent_tweets table tbody").prepend(response);
       var elements = $("#recent_tweets table tbody tr");
       elements.slice(10, elements.length).remove()

    })
  }, 3000);
});
