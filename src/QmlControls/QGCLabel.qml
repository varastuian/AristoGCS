import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls


Text {
    property color textColor
    property string textFont

    font.pointSize: ScreenTools.defaultFontPointSize
    font.family:    textFont =="" ?ScreenTools.normalFontFamily:textFont
    // font.family:    "Siegra"

    // color:          qgcPal.text
    color:          textColor == "" ? qgcPal.text : textColor

    antialiasing:   true

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
    // Component.onCompleted: {
    //     console.log("sag font:",ScreenTools.normalFontFamily)
    // }
}
