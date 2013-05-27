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

  var DEBUGGING = true;

  var started = Date.now();
  console.log("\n" + started + ' >> Work started...');

  var callbacks = {
    done: function(response) {

      if (!('data' in response) || !('meta' in response)) {
        console.error("Unexpected response. Should be {meta:{},data{}}");
        return;
      }

      if (DEBUGGING) { response.data = response.data.slice(0, 10); }
      
      var records = [];
      var fields = response.meta.view.columns.map(function(col) { return col.name; });

      $(response.data).each(function(row) {
        console.error($(row));

        var complaint = {};

        $(row).each(function(i, value) { 
          //if (DEBUGGING) { console.log($(value), $(fields[i])); }
          //complaint[fields[i]] = value; 
          console.error("adding A", fields[i], "to B", value);
        });

        records.push(complaint);

        console.log('.. parsing complaint.. ', $(complaint));
      });

      console.log("\n>> {0} Finished ({1}) complaints in {2} ms\n\n".format(Date.now(), records.length, Date.now() - started));
    },

    fail: Function("console.error('FAILED URL: {0}');".format(options.url))
  };

  var Scraper = {
    run: function(source, refresh, callbacks) {
      var url = source + (refresh ? '&force_reload=' + Date.now().toString() : '');

      $.getJSON(url).done(callbacks.done).fail(callbacks.fail);
    }
  };

  console.log(Date.now().toString() + '>> Grabbing latest: ' + options.url);

  Scraper.run(options.url, options.refresh, callbacks);

}(jQuery));
