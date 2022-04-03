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
import "Main/Popups"

ApplicationWindow {
    id: window
    visible: true
    title: "PipeWorks"
    flags: Qt.FramelessWindowHint | Qt.Window

    property int w: 800
    property int h: 600

    width : w
    height : h
//    x: Screen.width / 2 - width / 2
//    y: Screen.height / 2 - height / 2

    Login {
        id: lWindow
    }

    onClosing: {
        if(scheduler.isPdbLoaded() && scheduler.callIsDirty()){
            close.accepted = false;
            exitDialog.open();
        }

    }

    InfoDialog {
        id: exitDialog

        parent: Overlay.overlay
        x: (parent.width - exitDialog.width)/2
        y: (parent.height - exitDialog.height)/2

        title: "您确定要退出吗"
        text.text: "一个数据库已经打开并且有未提交的修改，退出将会丢弃这些修改。您确定要退出吗？"
        text.color: "#202020"
        text.wrapMode: Text.Wrap
        imageSource: "images/caution.png"

        cancelBtn.onClicked: exitDialog.close()

        confirmBtn.onClicked: {
            Qt.quit();
        }
        confirmBtn.text: "退出"
    }
}

