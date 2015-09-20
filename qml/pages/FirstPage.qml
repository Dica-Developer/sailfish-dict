/*
 Copyright (C) 2015 Dica-Developer.
 Contact: team@dica-developer.org
 All rights reserved.

 This file is part of sailfish-browser-search-engine-manager.

 sailfish-browser-search-engine-manager is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 sailfish-browser-search-engine-manager is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with sailfish-browser-search-engine-manager.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/searchDictionary.js" as SearchDictionary

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column

            width: page.width

            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Search a dictionary")
            }

            TextField {
                width: parent.width
                text: Clipboard.hasText ? Clipboard.text : ''
                id: queryTextField
                errorHighlight: null === text || 0 === text.trim().length || 40 < text.trim().length
                label: qsTr("Search for");
                placeholderText: qsTr("Search for a word")
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.onClicked: {
                    if (errorHighlight) {
                        queryTextField.focus = true;
                    } else {
                        var queryTextValue = queryTextField.text.trim();
                        var result = SearchDictionary.inDict('http://dict.uni-leipzig.de/dictd').forWord(queryTextValue).search(function (result) {
                            dictionaryResultModel.append(result);
                        });
                        pageStack.push(Qt.resolvedUrl("SecondPage.qml"));
                    }
                }
            }
        }
    }
}


