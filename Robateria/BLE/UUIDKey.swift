//
//  UUIDKey.swift
//  Robateria
//
//  Created by Korbinian Baumer on 14.01.18.
//  Copyright © 2018 Korbinian Baumer. All rights reserved.
//

import CoreBluetooth

//Uart Service uuid

let kBLEService0_UUID = "Device Information"
let kBLEService1_UUID = "F0001110-0451-4000-B000-000000000000"
let kBLEService2_UUID = "F0001120-0451-4000-B000-000000000000"
let kBLEService3_UUID = "F0001130-0451-4000-B000-000000000000"

let Service0UUID = CBUUID(string: kBLEService1_UUID)
let Service1UUID = CBUUID(string: kBLEService1_UUID)
let Service2UUID = CBUUID(string: kBLEService2_UUID)
let Service3UUID = CBUUID(string: kBLEService3_UUID)

let MaxCharacters = 60


