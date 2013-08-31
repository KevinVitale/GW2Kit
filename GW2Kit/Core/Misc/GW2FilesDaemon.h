//
//  GW2FilesDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 8/31/13.
//
//

#import <GW2Kit/GW2Kit.h>

/**
 This resource returns commonly requested in-game assets that may be used to enhance API-derived applications. The returned information can be used with the render service to retrieve assets.
 
 Wiki Documentation: 
 http://wiki.guildwars2.com/wiki/API:1/files
 
 Example:
 https://api.guildwars2.com/v1/files.json

 {
     "map_complete":            { "file_id": 528724, "signature": "5A4E663071250EC72668C09E3C082E595A380BF7" },
     "map_dungeon":             { "file_id": 102478, "signature": "943538394A94A491C8632FBEF6203C2013443555" },
     "map_heart_empty":         { "file_id": 102440, "signature": "09ACBA53B7412CC3C76E7FEF39929843C20CB0E4" },
     "map_heart_full":          { "file_id": 102439, "signature": "B3DEEC72BBEF0C6FC6FEF835A0E275FCB1151BB7" },
     "map_node_harvesting":     { "file_id": 157332, "signature": "995534EBE5D26804AE605E205E50539821C0CBCB" },
     "map_node_logging":        { "file_id": 157333, "signature": "FC01BB452D5327A0E5B2E4A3F5EFDF03F8264A7B" },
     "map_node_mining":         { "file_id": 157334, "signature": "A89EB66C39C7C006A4A6CBEDA28061F16847E9BC" },
     "map_poi":                 { "file_id":  97461, "signature": "25B230711176AB5728E86F5FC5F0BFAE48B32F6E" },
     "map_special_event":       { "file_id": 502087, "signature": "1273C427032320DDDB63062C140E72DCB0D9B411" },
     "map_story":               { "file_id": 102369, "signature": "540BA9BB6662A5154BD13306A1AEAD6219F95361" },
     "map_waypoint":            { "file_id": 157353, "signature": "32633AF8ADEA696A1EF56D3AE32D617B10D3AC57" },
     "map_waypoint_contested":  { "file_id": 102349, "signature": "5EF051273B40CFAC4AEA6C1F1D0DA612C1B0776C" },
     "map_waypoint_hover":      { "file_id": 157354, "signature": "95CE3F6B0502232AD90034E4B7CE6E5B0FD3CC5F" }
 }
 
 */
@interface GW2FilesDaemon : GW2DefaultDaemon

@end
