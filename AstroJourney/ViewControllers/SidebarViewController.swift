//
//  SidebarViewController.swift
//  AstroJourney
//
//  Created by Vic on 21.03.2025.
//

import Cocoa

// MARK: - Протокол для передачи выбранного элемента в MainSplitViewController
protocol SidebarSelectionDelegate: AnyObject {
    func sidebarDidSelectItem(_ item: String)
}

class SidebarViewController: NSViewController {
    
    // MARK: - Properties
    
    // Таблица для отображения списка элементов
    private var tableView: NSTableView!
    
    // Контейнер для таблицы с возможностью прокрутки
    private var scrollView: NSScrollView!
    
    // Массив элементов для отображения в таблице
    private let items = ["Dashboard", "Calendar", "Settings"]
    
    // Делегат для передачи выбранного элемента
    weak var delegate: SidebarSelectionDelegate?
    
    // MARK: - Lifecycle
    
    // Создаем и настраиваем представление
    override func loadView() {
        self.view = NSView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
    }
    
    // MARK: - Setup
    
    // Настройка таблицы и скролл-вью
    private func setupTableView() {
        // Создаем скролл-вью
        scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем таблицу
        tableView = NSTableView()
        tableView.style = .sourceList // Стиль как в сайдбаре Finder
        tableView.selectionHighlightStyle = .sourceList
        tableView.backgroundColor = .clear
        tableView.headerView = nil // Убираем заголовок таблицы
        tableView.delegate = self
        tableView.dataSource = self
        
        // Добавляем колонку
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("MainColumn"))
        column.title = ""
        tableView.addTableColumn(column)
        
        // Настраиваем скролл-вью
        scrollView.documentView = tableView
        view.addSubview(scrollView)
        
        // Добавляем ограничения для правильного размещения
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Выбираем первую строку по умолчанию
        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
    }
}

// MARK: - NSTableViewDelegate & NSTableViewDataSource
extension SidebarViewController: NSTableViewDelegate, NSTableViewDataSource {
    // Возвращает количество строк в таблице
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
    
    // Создает и возвращает ячейку для отображения
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier = NSUserInterfaceItemIdentifier("Cell")
        var cell = tableView.makeView(withIdentifier: identifier, owner: nil) as? NSTableCellView
        
        // Если ячейка не существует, создаем новую
        if cell == nil {
            cell = NSTableCellView()
            let textField = NSTextField()
            textField.isBezeled = false
            textField.drawsBackground = false
            textField.isEditable = false
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell?.addSubview(textField)
            
            // Добавляем ограничения для текстового поля
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell!.leadingAnchor, constant: 4),
                textField.centerYAnchor.constraint(equalTo: cell!.centerYAnchor),
                textField.trailingAnchor.constraint(equalTo: cell!.trailingAnchor, constant: -4)
            ])
            
            cell?.textField = textField
            cell?.identifier = identifier
        }
        
        // Устанавливаем текст для ячейки
        cell?.textField?.stringValue = items[row]
        return cell
    }
    
    // Обрабатывает изменение выбора в таблице
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let tableView = notification.object as? NSTableView else { return }
        let selectedRow = tableView.selectedRow
        if selectedRow >= 0 {
            // Уведомляем делегата о выборе элемента
            delegate?.sidebarDidSelectItem(items[selectedRow])
        }
    }
}
