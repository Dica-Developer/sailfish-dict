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


Page {
    id: page

    SilicaListView {
        id: dictionaryResultList
        anchors.fill: parent
        model: dictionaryResultModel

        header: PageHeader {
            title: qsTr("Translations")
        }

        VerticalScrollDecorator {}

        Component.onCompleted: {
        }

        delegate: Item {
            id: dictionaryResultListItem
            x: Theme.horizontalPageMargin
            width: parent.width - 2*Theme.horizontalPageMargin
            height: childrenRect.height

            TextArea {
                id: nameText
                x: Theme.horizontalPageMargin
                text: content
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                width: parent.width
                height: implicitHeight
                labelVisible: false
                anchors {
                    left: parent.left
                    rightMargin: Theme.paddingSmall
                }
                readOnly: true
                focusOnClick: true
                EnterKey.onClicked: parent.focus = true
            }
            Label {
                id: descriptionLabel
                x: Theme.horizontalPageMargin
                anchors {
                    top: nameText.bottom
                    rightMargin: Theme.paddingSmall
                }
                fontSizeMode: Text.Fit
                truncationMode: TruncationMode.Fade
                width: parent.width
                maximumLineCount: 1
                text: description
                font.italic: true
                color: Theme.secondaryColor
            }
        }
    }
}





