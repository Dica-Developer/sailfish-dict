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

CoverBackground {

    Label {
        id: resultLabel
        anchors.top: parent.top
        width: parent.width
        text: dictionaryResultModel.count > 0 ? dictionaryResultModel.get(0).content : ''
        visible: dictionaryResultModel.count > 0
        fontSizeMode: Text.Fit
    }

    Label {
        id: noClipboardLabel
        anchors.centerIn: parent
        width: parent.width
        text: qsTr('Translate')
        visible: !Clipboard.hasText
        fontSizeMode: Text.Fit
    }

    Label {
        id: clipboardLabel
        width: parent.width
        anchors.centerIn: parent
        text: qsTr('Translate clipboard')
        visible: Clipboard.hasText
        fontSizeMode: Text.Fit
    }

    CoverActionList {
        id: coverAction
        enabled: Clipboard.hasText

        CoverAction {
            iconSource: 'image://theme/icon-cover-search'
            onTriggered: {
                dictionaryResultModel.clear();
                var result = SearchDictionary.inDict('http://www.dict.org/bin/Dict').inDatabase('trans').forWord(Clipboard.text).search(function (result) {
                    dictionaryResultModel.append(result);
                }, null, function(finishedWithoutError) {
                    if (finishedWithoutError) {
                        if (1 === pageStack.depth) {
                            pageStack.push(Qt.resolvedUrl("../pages/SecondPage.qml"));
                        }
                        if (!window.applicationActive) {
                            window.activate();
                        }
                    }
                });
            }
        }
    }
}


