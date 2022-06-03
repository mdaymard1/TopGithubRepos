//
//  Initializer.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import UIKit
import SDWebImage

class Initializer {

    static let shared = Initializer()

    /// Total memory capacity of the image cache set to 50 MB
    let imageCacheMemoryCapacity = UInt(50 * 1024 * 1024 * 4)

    /// Total on-disk memory capacity of the urlCache set to 40 MB
    let imageCacheDiskCapacity = UInt(40 * 1024 * 1024)

    /// Cache age set to 1 day
    let imageCacheAge: Double = 24 * 60 * 60

    /// Initializes the app
    ///
    /// - Parameters:
    ///   - application: The UIApplication instance
    ///   - launchOptions: Launch options passed by app delegate
    ///   - appDelegate: The app delegate instance
    func initialize(application: UIApplication,
                    with launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                    appDelegate: AppDelegate) {
    }

    private func setupImageCache() {
        SDImageCacheConfig.default.maxMemoryCost = imageCacheMemoryCapacity
        SDImageCacheConfig.default.maxDiskSize = imageCacheDiskCapacity
        SDImageCacheConfig.default.maxDiskAge = imageCacheAge
    }}
