//
//  CommunicationViewController.swift
//  Robateria
//
//  Created by Korbinian Baumer on 14.01.18.
//  Copyright © 2018 Korbinian Baumer. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class CommunicationViewController: UIViewController,  CBPeripheralDelegate,  UICollectionViewDataSource {

    //Books
    let book1 = Books("Harry Potter-22f",-2,2,false)
    let book2 = Books("Harry Potter-12f",-1,2,false)
    let book3 = Books("Harry Potter12f",1,2,false)
    let book4 = Books("Harry Potter22f",2,2,false)

    let book5 = Books("Harry Potter-21t",-2,1,true)
    let book6 = Books("Harry Potter-11t",-1,1,true)
    let book7 = Books("Harry Potter11t",1,1,true)
    let book8 = Books("Harry Potter21t",2,1,true)

    let book9 = Books("Harry Potter-21f",-2,1,false)
    let book10 = Books("Harry Potter-11f",-1,1,false)
    let book11 = Books("Harry Potter11f",1,1,false)
    let book12 = Books("Harry Potter21f",2,1,false)

    let book13 = Books("Harry Potter-20t",-2,0,true)
    let book14 = Books("Harry Potter-10t",-1,0,true)
    let book15 = Books("Harry Potter10t",1,0,true)
    let book16 = Books("Harry Potter20t",2,0,true)

    var bookArray: [Books] = []


    @IBOutlet weak var ledSwitch: UISwitch?
    @IBOutlet weak var redButton: UIButton?
    @IBOutlet weak var greenButton: UIButton?
    @IBOutlet weak var blueButton: UIButton?

   // @IBOutlet weak var coordinatesLabel: UILabel?
   // @IBOutlet weak var booksCollection: UICollectionView?


    @IBAction func book1(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book1.x),")
        coordinates.append("\(book1.y),")
        coordinates.append("\(book1.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data Sting")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates
    }
    @IBAction func book2(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book2.x),")
        coordinates.append("\(book2.y),")
        coordinates.append("\(book2.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data Sting")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates
    }
    @IBAction func book3(_ sender: Any) {
        var coordinates = ""
        coordinates.append("\(book3.x),")
        coordinates.append("\(book3.y),")
        coordinates.append("\(book3.z)")
        let dataArr: [UInt8] = Array(coordinates.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data Sting")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                            type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coordinates)")
        currentCoords = coordinates
    }
    @IBAction func book4(_ sender: Any) {
    }
    @IBAction func book5(_ sender: Any) {
    }
    @IBAction func book6(_ sender: Any) {
    }
    @IBAction func book7(_ sender: Any) {
    }
    @IBAction func book8(_ sender: Any) {
    }
    @IBAction func book9(_ sender: Any) {
    }
    @IBAction func book10(_ sender: Any) {
    }
    @IBAction func book11(_ sender: Any) {
    }
    @IBAction func book12(_ sender: Any) {
    }
    @IBAction func book13(_ sender: Any) {
    }
    @IBAction func book14(_ sender: Any) {
    }
    @IBAction func book15(_ sender: Any) {
    }
    @IBAction func book16(_ sender: Any) {
    }

    // Device UUIDs
    let TI_PZ_LED_SERVICE_UUID = CBUUID(string: "F0001110-0451-4000-B000-000000000000")
    let TI_PZ_LED_CHAR_0_UUID = CBUUID(string: "F0001111-0451-4000-B000-000000000000")
    let TI_PZ_DATA_SERVICE_UUID = CBUUID(string: "F0001130-0451-4000-B000-000000000000")
    let TI_PZ_DATA_CHAR_0_UUID = CBUUID(string: "F0001131-0451-4000-B000-000000000000")
    let TI_PZ_DATA_CHAR_1_UUID = CBUUID(string: "F0001132-0451-4000-B000-000000000000")


    // Coordinates
    let coord1 = "1,1,true"
    let coord2 = "2,-1,false"
    var currentCoords = ""

    // Bluetooth Characteristics
    var ledCharLED0: CBCharacteristic?
    var dataCharString: CBCharacteristic?
    var dataCharData: CBCharacteristic?

    var peripheralManager: CBPeripheralManager?

    // Variables
    var btDevice: CBPeripheral?
    var bleDeviceVC: BLEDevicesViewController?

    var debounceTimer =  Timer()
    var writingValue = false
    var hasLoaded = false

    // for Data
    let hexSet = NSCharacterSet(charactersIn: "0123456789ABCDEFabcdef").inverted


    override func viewDidLoad() {
        super.viewDidLoad()

        bookArray = [book1, book2, book3, book4, book5, book6, book7, book8, book9, book10, book11, book12, book13, book14, book15, book16]


    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell

        let book = bookArray[indexPath.row]

        cell.displayContent(title: book.title)
        return cell
    }

    @IBAction func sendCoords1(_ sender: Any) {

        let dataArr: [UInt8] = Array(coord1.utf8)
        let writeArray = Data(dataArr)

        guard let dataCharString1 = dataCharString else {
            print("No Data Sting")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                                                 type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coord1)")
        currentCoords = coord1

    }

    @IBAction func sendCoords2(_ sender: Any) {

        let dataArr: [UInt8] = Array(coord2.utf8)
        let writeArray = Data(dataArr)
        guard let dataCharString1 = dataCharString else {
            print("No Data Sting")
            return
        }
        btDevice?.writeValue(writeArray, for: dataCharString1,
                                                 type: CBCharacteristicWriteType.withResponse)
        print("Coordinates set to: \(coord2)")
        currentCoords = coord2
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){

    }

    @IBAction func getCoordinatesButton(_ sender: Any) {
       // coordinatesLabel?.text = currentCoords
    }


    var rInt = UInt8(1*255), gInt = UInt8(0*255), bInt = UInt8(0*255)

    @IBAction func ledSwitch(_ sender: Any) {
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        if (ledSwitch?.isOn)! {
            let writeArray: [UInt8] = [rInt,gInt,bInt]

            btDevice?.writeValue(Data(writeArray),
                                for: ledCharLED,
                                type: CBCharacteristicWriteType.withResponse)
        }else {
            let writeArray: [UInt8] = [rInt*0,gInt*0,bInt*0]
            btDevice?.writeValue(Data(writeArray),
                                for: ledCharLED,
                                type: CBCharacteristicWriteType.withResponse)
        }
    }

    @IBAction func redButton(_ sender: Any) {
        rInt = UInt8(1*255)
        gInt = UInt8(0*255)
        bInt = UInt8(0*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)
    }

    @IBAction func greenButton(_ sender: Any) {
        rInt = UInt8(0*255)
        gInt = UInt8(1*255)
        bInt = UInt8(0*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)

    }

    @IBAction func blueButton(_ sender: Any) {
        rInt = UInt8(0*255)
        gInt = UInt8(0*255)
        bInt = UInt8(1*255)
        let writeArray: [UInt8] = [rInt,gInt,bInt]
        guard let ledCharLED = ledCharLED0 else {
            print("No Char LED")
            return
        }
        btDevice?.writeValue(Data(writeArray),
                            for: ledCharLED,
                            type: CBCharacteristicWriteType.withResponse)
        ledSwitch?.setOn(true, animated: true)
    }

    // MARK: CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?)
    {
        for service in peripheral.services!
        {
            let thisService = service as CBService
            peripheral.discoverCharacteristics(nil, for: thisService)
        }
    }


    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?)
    {
        if service.uuid == TI_PZ_LED_SERVICE_UUID
        {
            for characteristic in service.characteristics!
            {
                if characteristic.uuid == TI_PZ_LED_CHAR_0_UUID
                {
                    ledCharLED0 = characteristic

                    print("********************")
                    print(ledCharLED0 as Any)
                }
                else
                {
                    print("ProjectZero: Unknown characteristic UUID: \(characteristic.uuid.uuidString)")
                    continue
                }

                btDevice?.readValue(for: characteristic)
            }
        }
        else if service.uuid == TI_PZ_DATA_SERVICE_UUID
        {
            for characteristic in service.characteristics!
            {
                if characteristic.uuid == TI_PZ_DATA_CHAR_0_UUID
                {
                    dataCharString = characteristic
                }
                else if characteristic.uuid == TI_PZ_DATA_CHAR_1_UUID
                {
                    dataCharData = characteristic
                    btDevice?.setNotifyValue(true, for: characteristic)

                }
                else
                {
                    print("ProjectZero: Unknown characteristic UUID: \(characteristic.uuid.uuidString)")
                    continue
                }
            }
        }
        else
        {
            print("ProjectZero: Unknown Service UUID \(service.uuid.uuidString)")
        }
    }


}
