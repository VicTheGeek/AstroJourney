//
//  MainWindowController.swift
//  AstroJourney
//
//  Created by Vic on 21.03.2025.
//

import Cocoa

final class MainWindowController: NSWindowController {
    
    // MARK: - Properties
    
    // Контроллер разделенного интерфейса, который управляет сайдбаром и основным контентом
    private var splitViewController: NSSplitViewController!
    
    // MARK: - Initialization
    
    override init(window: NSWindow?) {
        // Создаем главное окно приложения
        let customWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1280, height: 800),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        // Настраиваем параметры окна
        customWindow.title = "Astro Journey" // Заголовок окна
        customWindow.center() // Центрируем окно на экране
        customWindow.isReleasedWhenClosed = false // Не освобождаем окно при закрытии
        customWindow.minSize = NSSize(width: 960, height: 760) // Минимальный размер окна
        customWindow.setFrameAutosaveName("MainWindow") // Имя для сохранения размеров окна
        
        // Вызываем инициализатор родительского класса
        super.init(window: customWindow)
        
        // Создаем разделенный интерфейс с сайдбаром и основным контентом
        let splitViewController = NSSplitViewController()
        
        // Создаем контроллеры для сайдбара и контента
        let sidebarViewController = SidebarViewController()
        let contentViewController = ContentViewController()
        
        // Создаем элементы разделенного интерфейса
        let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
        let contentItem = NSSplitViewItem(viewController: contentViewController)
        
        // Добавляем элементы в split view
        splitViewController.addSplitViewItem(sidebarItem)
        splitViewController.addSplitViewItem(contentItem)
        
        // Настраиваем делегат для обработки выбора в сайдбаре
        sidebarViewController.delegate = contentViewController as? SidebarSelectionDelegate
        
        self.splitViewController = splitViewController
        
        // Устанавливаем разделенный интерфейс как корневой контроллер окна
        self.window?.contentViewController = splitViewController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - NSWindowController
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Устанавливаем себя делегатом окна для обработки событий окна
        window?.delegate = self
    }
}

// MARK: - NSWindowDelegate
extension MainWindowController: NSWindowDelegate {
    // Обрабатывает закрытие окна
    func windowWillClose(_ notification: Notification) {
        // Завершаем приложение при закрытии окна
        NSApplication.shared.terminate(self)
    }
}
