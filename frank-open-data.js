// TODO move benchmark runner out here
(function($) {
  'use strict';

  var started = Date.now();

  scrape('https://nycopendata.socrata.com/api/views/5m6a-enkt/rows.json?accessType=DOWNLOAD');

  function scrape(source, refresh=true) {
    var url = source + (refresh ? '&reload=' + Date.now().toString() : '');

  console.log('Grabbing latest: ' + url);
 
  var callbacks = {
    done: function(data) { parse(data); },
    fail: Function("console.error('FAILED URL: {0}');".format(url))
  }
                                          
  $.getJSON(url).done(callbacks.done).fail(callbacks.fail)

}(jQuery));

 
  function parse(response) {
    if (!('data' in response) || !('meta' in response)) {
      console.error("Unexpected response. It should be { meta:{}, data{} }");
      return;
    }

    var records = [];
    
    $(response.data).each(function(field, value) {
      complaint = "FIELD = " + field + " VALUE = " + value;
      console.log(complaint);
      records.push(complaint);
    });

    console.log("\nFinished!\n\nStats:")

    var total = records.length.toString();
    var result = "Parsed {0} records in {1}ms".format(total, Date.now()-started);
  }
 
