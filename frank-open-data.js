// TODO move benchmark runner out here
// TODO remove all console calls. 
// TODO split into models
// TODO pull out algorithms

(function($) {
  'use strict';
 
  var options = {
    url: 'https://nycopendata.socrata.com/api/views/5m6a-enkt/rows.json?accessType=DOWNLOAD',
    refresh: true
  };

  var DEBUGGING = false;

  var started = Date.now();
  console.log("\n>> " + started + ' Work started...');

  var callbacks = {
    done: function(response) {

      if (!('data' in response) || !('meta' in response)) {
        console.error("Unexpected response. Should be {meta:{},data{}}");
        return;
      }

      if (DEBUGGING) { response.data = response.data.slice(0, 20); }
      
      var records = [];
      var complaint = '<empty complaint>';

      $(response.data).each(function(field, value) {

        complaint = "FIELD = " + field + " VALUE = " + value;
        records.push(complaint);

        console.notice('parsing complaint: ' + $(complaint).toJson());
      });

      console.log(records.length);
      console.log($(records[0]));
      console.log(records[0]);

      var total = records.length;
      console.log("\n>> {0} Finished ({1}) complaints in {2} ms\n\n".format(Date.now(), total, Date.now() - started));
    },

    fail: Function("console.error('FAILED URL: {0}');".format(options.url))
  };

  var Scraper = {
    run: function(source, refresh, callbacks) {
      var url = source + (refresh ? '&force_reload=' + Date.now().toString() : '');

      $.getJSON(url).done(callbacks.done).fail(callbacks.fail);
    }
  };

  console.log('>> Grabbing latest: ' + options.url);
  Scraper.run(options.url, options.refresh, callbacks);

}(jQuery));
