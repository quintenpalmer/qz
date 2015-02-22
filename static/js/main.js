$(document).ready(function() {
    getTileInfo();
    getMap();
});

versionOneRestPrefix = '/rest/1.0/'

function getTileInfo() {
    $.get(
        versionOneRestPrefix + 'tileInfo',
        {},
        function(data) { storeTileInfo(data) },
        'json');
}

function getMap() {
    $.get(
        versionOneRestPrefix + 'map',
        { 'name': 'testMap' },
        function(data) { buildMap(data) },
        'json');
}

function storeTileInfo(data) {
    window.tileInfo = data.data;
}

function buildMap(data) {
    console.log(data.data);
    var container = $('#map');

    container.empty();
    var table = $('<div/>');
    for(var list_ in data.data) {
        var list = data.data[list_];
        var tr = $('<div/>', { 'class': 'short' });
        for(var num_ in list) {
            var num = list[num_];
            var td = $('<div/>', { 'class': 'cell nowrap' });
            var a = $('<img/>', {
                //$('#name').val(data.name);
                'src': '/static/images/' + window.tileInfo[num] + ".png"
            });
            td.append(a);
            tr.append(td)
        }
        table.append(tr);
    }
    container.append(table);
}
