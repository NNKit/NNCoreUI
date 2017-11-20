//
//  NNCoreUI.h
//  NNCoreUI
//
//  Created by XMFraker on 2017/11/20.
//

#ifndef NNCoreUI_h
#define NNCoreUI_h

#if __has_include(<NNetwork/NNetwork.h>)
    #import <NNetwork/NNURLRequest.h>
    #import <NNetwork/NNURLRequestAgent.h>
    #import <NNetwork/NNReachablility.h>
#else
    #import "NNURLRequest.h"
    #import "NNURLRequestAgent.h"
    #import "NNReachablility.h"
#endif

/// ========================================
/// @name   三方库
/// ========================================

#import <NNCore/NNCore.h>

#endif /* NNCoreUI_h */
