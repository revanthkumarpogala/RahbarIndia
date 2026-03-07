//
//  ApiManager.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import Foundation
import UIKit

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    // MARK: - Common Header Setup
    private func configureHeaders(
        for request: inout URLRequest,
        additionalHeaders: [String: String]? = nil,
        requiresAuth: Bool = true
    ) {
        // Attach Bearer Token Automatically
        if requiresAuth,
           let token = UserSessionManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Attach extra headers if provided
        additionalHeaders?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
    // MARK: - DELETE Request

    func deleteRequest(
        urlString: String,
        headers: [String: String]? = nil,
        requiresAuth: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400)))
            return
        }
        
        if showLoader {
            DispatchQueue.main.async {
                LoaderView.shared.show()
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        configureHeaders(for: &request,
                         additionalHeaders: headers,
                         requiresAuth: requiresAuth)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(
                data: data,
                response: response,
                error: error,
                showLoader: showLoader,
                completion: completion
            )
        }.resume()
    }
    
    // MARK: - Handle Common Response
    private func handleResponse(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        showLoader: Bool,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        DispatchQueue.main.async {
            if showLoader {
                LoaderView.shared.hide()
            }
        }
        
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            
            // Auto logout if token expired
            if httpResponse.statusCode == 401 {
                DispatchQueue.main.async {
                    UserSessionManager.shared.clearSession()
                }
            }
        }
        
        guard let data = data else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "NoData", code: 500)))
            }
            return
        }
        
        DispatchQueue.main.async {
            completion(.success(data))
        }
    }
    
    // MARK: - Multipart POST Request
    func postMultipartRequest(
        urlString: String,
        parameters: [[String: Any]],
        headers: [String: String]? = nil,
        requiresAuth: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400)))
            return
        }
        
        if showLoader {
            DispatchQueue.main.async {
                LoaderView.shared.show()
            }
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        for param in parameters {
            
            if param["disabled"] != nil { continue }
            
            guard let paramName = param["key"] as? String,
                  let paramType = param["type"] as? String else { continue }
            
            body.append(Data("--\(boundary)\r\n".utf8))
            
            if paramType == "text" {
                
                let paramValue = param["value"] as? String ?? ""
                body.append(Data("Content-Disposition: form-data; name=\"\(paramName)\"\r\n\r\n".utf8))
                body.append(Data("\(paramValue)\r\n".utf8))
                
            } else if paramType == "file" {
                
                guard let filePath = param["src"] as? String else { continue }
                
                let fileURL = URL(fileURLWithPath: filePath)
                
                if let fileData = try? Data(contentsOf: fileURL) {
                    
                    let filename = fileURL.lastPathComponent
                    let mimeType = param["contentType"] as? String ?? "application/octet-stream"
                    
                    body.append(Data("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(filename)\"\r\n".utf8))
                    body.append(Data("Content-Type: \(mimeType)\r\n\r\n".utf8))
                    body.append(fileData)
                    body.append(Data("\r\n".utf8))
                }
            }
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        configureHeaders(for: &request,
                         additionalHeaders: headers,
                         requiresAuth: requiresAuth)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(
                data: data,
                response: response,
                error: error,
                showLoader: showLoader,
                completion: completion
            )
        }.resume()
    }
    
    // MARK: - JSON POST Request
    func postJSONRequest(
        urlString: String,
        body: [String: Any],
        headers: [String: String]? = nil,
        requiresAuth: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400)))
            return
        }
        
        if showLoader {
            DispatchQueue.main.async {
                LoaderView.shared.show()
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        configureHeaders(for: &request,
                         additionalHeaders: headers,
                         requiresAuth: requiresAuth)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            DispatchQueue.main.async {
                if showLoader {
                    LoaderView.shared.hide()
                }
                completion(.failure(error))
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(
                data: data,
                response: response,
                error: error,
                showLoader: showLoader,
                completion: completion
            )
        }.resume()
    }
}
