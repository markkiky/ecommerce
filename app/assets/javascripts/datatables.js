//= require datatables/jquery.dataTables

// optional change '//' --> '//=' to enable

// require datatables/extensions/AutoFill/dataTables.autoFill
// require datatables/extensions/Buttons/dataTables.buttons
// require datatables/extensions/Buttons/buttons.html5
// require datatables/extensions/Buttons/buttons.print
// require datatables/extensions/Buttons/buttons.colVis
// require datatables/extensions/Buttons/buttons.flash
// require datatables/extensions/ColReorder/dataTables.colReorder
// require datatables/extensions/FixedColumns/dataTables.fixedColumns
// require datatables/extensions/FixedHeader/dataTables.fixedHeader
// require datatables/extensions/KeyTable/dataTables.keyTable
// require datatables/extensions/Responsive/dataTables.responsive
// require datatables/extensions/RowGroup/dataTables.rowGroup
// require datatables/extensions/RowReorder/dataTables.rowReorder
// require datatables/extensions/Scroller/dataTables.scroller
// require datatables/extensions/Select/dataTables.select

//Global setting and initializer

$.extend( $.fn.dataTable.defaults, {
  responsive: true,
  pagingType: 'full',
  //dom:
  //  "<'row'<'col-sm-4 text-left'f><'right-action col-sm-8 text-right'<'buttons'B> <'select-info'> >>" +
  //  "<'row'<'dttb col-12 px-0'tr>>" +
  //  "<'row'<'col-sm-12 table-footer'lip>>"
});


$(document).on('preInit.dt', function(e, settings) {
  var api, table_id, url;
  api = new $.fn.dataTable.Api(settings);
  table_id = "#" + api.table().node().id;
  url = $(table_id).data('source');
  if (url) {
    return api.ajax.url(url);
  }
});


// init on turbolinks load
$(document).on('turbolinks:load', function() {
  // debugger
  // check if there is datatable present in the DOM
  if ($.fn.dataTable !== undefined){
    // check for our default datatable
    if ($.fn.DataTable.isDataTable("#basic-1")) {
      $("#basic-1").DataTable();
    }
  }
 
});

// turbolinks cache fix
$(document).on('turbolinks:before-cache', function() {
  // debugger
  // check if there is datatable in Dom to destroy before caching
  if ($.fn.dataTable !== undefined){
    var dataTable = $($.fn.dataTable.tables(true)).DataTable();
    if (dataTable !== null) {
      dataTable.clear();
      dataTable.destroy();
      return dataTable = null;
    }
  }
});
