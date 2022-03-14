/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Quick Studio Components.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.13
import QtQuick.Dialogs 1.3

import "Login"
import "Main"

Window {
    id: window
    visible: true
    title: "QML"
    flags: Qt.FramelessWindowHint | Qt.Window

    property int w: 800
    property int h: 600

    width : w
    height : h
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    MouseArea {
        property real deltaX: 0
        property real deltaY: 0
        property real preX: 0
        property real preY: 0

        anchors.fill: parent

        onPressed: {
            preX = mouseX
            preY = mouseY

        }
        onPositionChanged: {
            deltaX = mouseX - preX
            deltaY = mouseY - preY
            window.x += deltaX
            window.y += deltaY
        }
    }

    Login {
        id: lWindow
    }
}

