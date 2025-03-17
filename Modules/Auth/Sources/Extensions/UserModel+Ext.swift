//
// UserModel+Ext.swift
// Auth
//
// Created by Dmitriy Mk on 17.03.25.
//

import Foundation

extension UserModel {
    func asDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dict
        } catch {
            print("Ошибка конвертации UserModel в словарь: \(error)")
            return nil
        }
    }
}
