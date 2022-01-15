import Foundation

extension URLRequest{
    var customHeaders: Any{
        if let httpHeaders = allHTTPHeaderFields {
            if let json = try? JSONSerialization.data(withJSONObject: httpHeaders, options: []){
                if let decoded = try? JSONSerialization.jsonObject(with: json, options: []){
                    return decoded
                }
            }
        }
        
        return "{ \n}"
    }
    
    var customBody: Any{
        if let httpBody = httpBody {
            if let json = try? JSONSerialization.jsonObject(with: httpBody, options: []){
                return json
            }
        }
        
        return "{ \n}"
    }
}


extension URLRequest{
    var authorizationHeader: String{
        get{
            if let value = value(forHTTPHeaderField: "Authorization") {
                return value;
            }
            else{
                return "";
            }
        }
        set{
            addValue("Bearer \(newValue)", forHTTPHeaderField: "Authorization")
        }
    }
}
