//
//  AppDelegate.swift
//  AstroJourney
//
//  Created by Vic on 20.03.2025.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    
    // Контроллер главного окна приложения
    private var mainWindowController: MainWindowController?
    
    // MARK: - NSApplicationDelegate
    
    // Вызывается при запуске приложения
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Настраиваем приложение как обычное настольное приложение
        NSApplication.shared.setActivationPolicy(.regular)
        
        // Создаем и показываем главное окно
        mainWindowController = MainWindowController()
        mainWindowController?.showWindow(nil)
        
        // Делаем наше приложение активным
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    // Вызывается перед завершением запуска приложения
    func applicationWillFinishLaunching(_ notification: Notification) {
        // Закрываем окно по умолчанию, чтобы не было двух окон
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
    }
    
    // Вызывается при завершении приложения
    func applicationWillTerminate(_ aNotification: Notification) {
        // Код для очистки при закрытии приложения
    }
    
    // Этот метод указывает, поддерживает ли приложение безопасное восстановление состояния
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    // Обработка повторного открытия приложения (например, клик по иконке в доке)
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            // Если нет видимых окон, показываем главное окно
            mainWindowController?.showWindow(self)
        }
        return true
    }
    
    // Обработка закрытия последнего окна
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true // Закрываем приложение при закрытии последнего окна
    }
}
