/*
 Copyright (C) 2015 Dica-Developer.
 Contact: team@dica-developer.org
 All rights reserved.

 This file is part of sailfish-.

 sailfish-browser-search-engine-manager is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 sailfish-browser-search-engine-manager is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with sailfish-.  If not, see <http://www.gnu.org/licenses/>.
*/

function inDict(url) {
    var _url = url;
    var _query = '';

    function forWord(query) {
        _query = query;
        return this;
    }

    function search(oneItemHandler, errorHandler) {
        var request = new XMLHttpRequest();
        request.open("GET", _url + '?Form=dict1&Query=' + encodeURIComponent(_query) + '&Strategy=*&Database=*', true);
        request.onreadystatechange = function () {
            if (XMLHttpRequest.DONE === request.readyState) {
                if (200 === request.status) {
                    var content = request.responseText;
                    content = content.substring(content.indexOf('<pre>'), content.lastIndexOf('</pre>') + 6);
                    content = content.substring(content.indexOf('</pre>') + 6);
                    content = content.substring(content.indexOf('</pre>') + 6);
                    content = content.replace(/<b>From /gi, '{');
                    content = content.replace(/<\/pre>/gi, '}');
                    content = content.replace(/<\/a>:\n<\/b><pre>/gi, '","content":"');
                    content = content.replace(/}{<a href=/gi, '"},{"url":');
                    content = content.replace(/">/gi, '","description":"');
                    content = content.replace('<a href=', '"url":');
                    content = content.replace(/\n/gi, '#');
                    content = '{"result":[' + content + ']}';
                    content = content.replace('}]', '"}]');
                    content = JSON.parse(content);
                    if (content.result.length > 0) {
                        console.log(content.result.length);
                        for (var i=0; i < content.result.length; i++) {
                            oneItemHandler(content.result[i]);
                        }
                    } else {
                        errorHandler(qsTr('No definitions found for') + ' ' + _query);
                    }
                } else {
                    console.error('Error on requesting dict data on ' + _url + ' for "' + _query + '"');
                    errorHandler(1);
                }
            }
        }
        request.send();
    }

    return {
        forWord: forWord,
        search: search
    }
}


