//
//  ContentViewController.swift
//  AstroJourney
//
//  Created by Vic on 21.03.2025.
//

import Cocoa

class ContentViewController: NSViewController {
    
    // MARK: - Properties
    
    // Заголовок для отображения текущего раздела
    private let titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // Контейнер для содержимого раздела
    private let contentContainer: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsLayer = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    // Создаем пустое представление
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    // Настройка пользовательского интерфейса
    private func setupUI() {
        // Настраиваем основное представление
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        // Добавляем заголовок и контейнер
        view.addSubview(titleLabel)
        view.addSubview(contentContainer)
        
        // Настраиваем ограничения для правильного размещения
        NSLayoutConstraint.activate([
            // Ограничения для заголовка
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Ограничения для контейнера содержимого
            contentContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    // Обновляет содержимое в зависимости от выбранного элемента
    func updateContent(for item: String) {
        // Обновляем заголовок
        titleLabel.stringValue = item
        
        // Очищаем предыдущее содержимое
        for subview in contentContainer.subviews {
            subview.removeFromSuperview()
        }
        
        // Настраиваем вид в зависимости от выбранного элемента
        switch item {
        case "Dashboard":
            // Настраиваем вид для Dashboard
            setupDashboardView()
            view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        case "Calendar":
            // Настраиваем вид для Calendar
            setupCalendarView()
            view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        case "Settings":
            // Настраиваем вид для Settings
            setupSettingsView()
            view.layer?.backgroundColor = NSColor.controlColor.cgColor
        default:
            break
        }
    }
    
    // MARK: - Private Setup Methods
    
    // Настройка представления для Dashboard
    private func setupDashboardView() {
        let infoLabel = NSTextField(labelWithString: "Это панель управления")
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 16)
        
        contentContainer.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
        ])
    }
    
    // Настройка представления для Calendar
    private func setupCalendarView() {
        let infoLabel = NSTextField(labelWithString: "Здесь будет календарь")
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 16)
        
        contentContainer.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
        ])
    }
    
    // Настройка представления для Settings
    private func setupSettingsView() {
        let infoLabel = NSTextField(labelWithString: "Здесь будут настройки")
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 16)
        
        contentContainer.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
        ])
    }
}
