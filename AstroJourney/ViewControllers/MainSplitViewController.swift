//
//  MainSplitViewController.swift
//  AstroJourney
//
//  Created by Vic on 21.03.2025.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {
    
    // MARK: - Properties
    
    // Элементы разделенного интерфейса
    private let sidebarItem: NSSplitViewItem
    private let mainContentItem: NSSplitViewItem
    
    // Контроллеры представлений
    private let sidebarViewController: SidebarViewController
    private let mainContentViewController: ContentViewController
    
    // MARK: - Initialization
    
    init() {
        // Создаем контроллеры представлений
        sidebarViewController = SidebarViewController()
        mainContentViewController = ContentViewController()
        
        // Создаем элементы разделенного интерфейса
        sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarViewController)
        mainContentItem = NSSplitViewItem(viewController: mainContentViewController)
        
        // Вызываем инициализатор родительского класса
        super.init(nibName: nil, bundle: nil)
        
        // Настраиваем делегат для обработки выбора в сайдбаре
        sidebarViewController.delegate = self
        
        // Добавляем элементы в split view
        addSplitViewItem(sidebarItem)
        addSplitViewItem(mainContentItem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настраиваем внешний вид split view
        view.wantsLayer = true
        splitView.dividerStyle = .thin
        
        // Устанавливаем минимальные размеры для сайдбара и основного контента
        if let sidebarView = sidebarViewController.view {
            sidebarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        }
        
        if let contentView = mainContentViewController.view {
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true
        }
        
        // Вызываем обновление контента для первого элемента
        if let firstItem = sidebarViewController.value(forKey: "items") as? [String], !firstItem.isEmpty {
            mainContentViewController.updateContent(for: firstItem[0])
        }
    }
}

// MARK: - SidebarSelectionDelegate
extension MainSplitViewController: SidebarSelectionDelegate {
    // Обрабатывает выбор элемента в сайдбаре
    func sidebarDidSelectItem(_ item: String) {
        // Обновляем содержимое основной области
        mainContentViewController.updateContent(for: item)
    }
}
