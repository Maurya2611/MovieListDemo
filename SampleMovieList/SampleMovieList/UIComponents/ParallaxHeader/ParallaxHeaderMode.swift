//
//  ParallaxHeaderMode.swift
//  SampleMovieList
//  Created by Chandresh on 8/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation

public enum ParallaxHeaderMode: Int {
    /**
     The option to scale the content to fill the size of the header.
     Some portion of the content may be clipped to fill the header’s bounds.
     */
    case fill = 0
    /**
     The option to center the content aligned at the top in the header's bounds.
     */
    case top
    /**
     The option to scale the content to fill the size of the header and aligned at the top in the header's bounds.
     */
    case topFill
    /**
     The option to center the content in the header’s bounds, keeping the proportions the same.
     */
    case center
    /**
     The option to scale the content to fill the size of the header and center the content in the header’s bounds.
     */
    case centerFill
    /**
     The option to center the content aligned at the bottom in the header’s bounds.
     */
    case bottom
    /**
     The option to scale the content to fill the size of the header and aligned at the bottom in the header's bounds.
     */
    case bottomFill
}
