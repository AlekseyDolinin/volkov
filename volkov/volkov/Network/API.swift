import Foundation
import UIKit

public class API: NSObject {
    
    public static let shared = API()
        
    static var imageCash = NSCache<NSString, UIImage>()
    
    ///
    public func requestImage(link: String) async -> UIImage {
        // проверка есть ли закешированое изображение
        if let cashImage = API.imageCash.object(forKey: link as NSString) {
            return cashImage
        } else {
            guard let url = URL(string: link) else { return UIImage() }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                guard let image = UIImage(data: data) else { return UIImage() }
                API.imageCash.setObject(image, forKey: url.absoluteString as NSString)
                return image
            } catch {
                print("Ошибка: \(error)")
                return UIImage()
            }
        }
    }
    
    ///
    public func _request(_ link: String,
                         method: HTTPMethod = .get,
                         parameters: Any? = nil,
                         needCookie: Bool = true,
                         checkError: Bool = true) async -> JSON? {
        guard let url = URL(string: link) else {
            print("BAD LINK: \(link)")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            } catch let error {
                print("error_add_parameters: \(error.localizedDescription)")
                return nil
            }
        }
        do {
            let session = URLSession(configuration: URLSessionConfiguration.default,  delegate: self, delegateQueue: .current)
            let (data, response) = try await session.data(for: request)
            if let response_ = response as? HTTPURLResponse {
                if response_.statusCode != 200 {
                    print(response_.statusCode)
                    print(response)
                }
            }
            let json = JSON(data)
            return json
        } catch {
            print("Ошибка: \(error.localizedDescription).")
            return nil
        }
    }
    
    public enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
    
}

extension API: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: (any Error)?) {
        print(2)
    }
    
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print(4)
    }
}
