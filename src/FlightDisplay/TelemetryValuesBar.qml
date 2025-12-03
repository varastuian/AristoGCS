/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick
import QtQuick.Layouts

import QGroundControl


import QGroundControl.Controls


Item {
    id:             control
    implicitWidth:  mainLayout.width + (_toolsMargin * 2)
    implicitHeight: mainLayout.height + (_toolsMargin * 2)

    property real extraWidth: 0 ///< Extra width to add to the background rectangle
    property var    _activeVehicle:         QGroundControl.multiVehicleManager.activeVehicle

    property alias factValueGrid:           factValueGrid
    property alias settingsGroup:           factValueGrid.settingsGroup
    property alias specificVehicleForCard:  factValueGrid.specificVehicleForCard

    Rectangle {
        id:         backgroundRect
        width:      control.width + extraWidth
        height:     control.height
        gradient: Gradient {
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.6;                                   color: "#c8414a4c" }
            GradientStop { position: 1;                                     color: "transparent" }
        }

        radius:     ScreenTools.defaultFontPixelWidth / 2
        opacity:    0.75
    }

    ColumnLayout{

        id: mainLayout
        anchors.margins:    _toolsMargin
        anchors.bottom:     parent.bottom
        anchors.left:       parent.left

        RowLayout{
            id: altitudeSection
            Layout.leftMargin:    ScreenTools.defaultFontPixelWidth
            Layout.rightMargin:    ScreenTools.defaultFontPixelWidth


            QGCLabel{
                text: "Alt: "
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*3.5
                textColor: "white"
                textFont : "Siegra"

            }
            QGCLabel{
                text: _activeVehicle? valueAlt() :"-"
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*3.5
                textColor: "white"
                font.letterSpacing: 3
                textFont : "Siegra"

                function valueAlt(){
                    var ans = 0
                    if(_activeVehicle.altitudeRelative.value<1000){
                        ans = _activeVehicle.altitudeRelative.value.toFixed(1)
                    }
                    else{
                        ans = (_activeVehicle.altitudeRelative.value/1000).toFixed(1)
                    }
                    return ans
                }
            }
            QGCLabel{
                text: _activeVehicle? unitAlt():""
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*0.9
                textColor: "white"
                textFont : "Siegra"


                function unitAlt(){
                    var ans =""
                    if(_activeVehicle.altitudeRelative.value<1000){
                        ans = "m"
                    }
                    else{
                        ans = "km"
                    }
                    return ans
                }
            }

        }

        RowLayout{
            id: speedSection

            Layout.leftMargin:    ScreenTools.defaultFontPixelWidth
            Layout.rightMargin:    ScreenTools.defaultFontPixelWidth


            QGCLabel{
                text: "H.S: "
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*2.5
                textColor: "white"
                textFont : "Siegra"

            }
            QGCLabel{
                text: _activeVehicle?  _activeVehicle.airSpeed.value.toFixed(0) :"-"
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*2.5
                textColor: "white"
                font.letterSpacing: 3
                textFont : "Siegra"


            }
            QGCLabel{
                text: _activeVehicle? "km/h":""
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*0.9
                textColor: "white"
                textFont : "Siegra"

            }
        }

        RowLayout{
            id:distanceSection
            Layout.leftMargin:    ScreenTools.defaultFontPixelWidth
            Layout.rightMargin:    ScreenTools.defaultFontPixelWidth


            QGCLabel{
                text: "Dis: "
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*2.5
                textColor: "white"
                textFont : "Siegra"

            }
            QGCLabel{
                text: _activeVehicle? value() :"-"
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*2.5
                textColor: "white"
                font.letterSpacing: 3
                textFont : "Siegra"

                function value(){
                    var ans = 0
                    if(_activeVehicle.distanceToHome.value<1000){
                        ans = _activeVehicle.distanceToHome.value.toFixed(1)
                    }
                    else{
                        ans = (_activeVehicle.distanceToHome.value/1000).toFixed(1)
                    }
                    return ans
                }



            }
            QGCLabel{
                text: _activeVehicle? unitAlt():""
                anchors.margins: ScreenTools.defaultFontPixelWidth
                font.pointSize: ScreenTools.defaultFontPixelWidth*0.9
                textColor: "white"
                textFont : "Siegra"


                function unitAlt(){
                    var ans =""
                    if(_activeVehicle.distanceToHome.value<1000){
                        ans = "m"
                    }
                    else{
                        ans = "km"
                    }
                    return ans
                }


            }
        }
    }




    HorizontalFactValueGrid {
        id: factValueGrid
        visible:false
    }

}
