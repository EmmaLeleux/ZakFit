//
//  ImageEnum.swift
//  ZakFit
//
//  Created by Emma on 01/12/2025.
//

enum ImageEnum: String, CaseIterable{
    case tigre
    case ours
    case lion
    case chat
    case gazelle

    
    var lien:String{
        switch self {
        case .tigre:
            return "https://i.ibb.co/gFFwxRWY/cute-funny-tiger-vector-white-background-1026278-8313.jpg"
        case .ours:
            return "https://i.ibb.co/PGqRNjhz/67edb0658338bc82e4c055274cbac361.jpg"
        case .lion:
            return "https://i.ibb.co/x0nqL1G/lion-natural-with-a-kawaii-face-cute-cartoon-ai-generate-png.png"
        case .chat:
            return "https://i.ibb.co/zWhNftCH/cute-kawaii-cat-clipart-white-background-804788-5612.jpg"
        case .gazelle:
            return "https://i.ibb.co/XZd9hCWs/pngtree-running-cute-deer-png-image-14562995.png"
           
        }
    }
}
