# ABAP MVC Template / Шаблон MVC для ABAP

## English

### Overview
This project implements a Model-View-Controller (MVC) design pattern template for ABAP ALV (ABAP List Viewer) applications. The template provides a clean separation of concerns and makes ALV applications more maintainable and extensible.

### Features
- **Model-View-Controller Architecture**: Clean separation of data logic, presentation, and control flow
- **ALV Integration**: Full integration with SAP ALV Grid for data display
- **Event Handling**: Support for double-click, select/deselect operations
- **Dynamic Field Catalog**: Automatic field catalog generation with customization options
- **Checkbox Support**: Built-in checkbox functionality for row selection
- **Message Handling**: Integrated error and information message display
- **Stable Refresh**: ALV refresh without losing current scroll position

### Project Structure
```
z_alv_mvc_template.prog.abap          - Main program
z_alv_mvc_template_top.prog.abap      - Type definitions and class declarations
z_alv_mvc_template_f00.prog.abap      - Model implementation (lcl_mvc_model)
z_alv_mvc_template_f01.prog.abap      - View implementation (lcl_mvc_view)
z_alv_mvc_template_f02.prog.abap      - Controller implementation (lcl_mvc_controller)
z_alv_mvc_template_m00.prog.abap      - Module implementations
z_alv_mvc_template_s00.prog.abap      - Screen definitions
```

### Architecture Components

#### Model (`lcl_mvc_model`)
Handles data management and business logic:
- **Data Storage**: Manages internal table `gt_alv` with TVARVC data
- **Data Access**: Provides methods to retrieve specific rows by index
- **Data Initialization**: Loads data from database tables

#### View (`lcl_mvc_view`)
Manages user interface and presentation:
- **ALV Display**: Creates and configures ALV Grid control
- **Field Catalog**: Automatically generates and customizes field definitions
- **Layout Management**: Handles ALV layout settings (zebra pattern, etc.)
- **Event Registration**: Sets up event handlers for user interactions
- **Message Display**: Shows error and information messages to users

#### Controller (`lcl_mvc_controller`)
Coordinates between Model and View:
- **Application Flow**: Manages the overall application lifecycle
- **Event Handling**: Processes user events (double-click, select/deselect)
- **Business Logic**: Implements application-specific logic and workflows

### Usage

1. **Copy the template files** to your SAP system
2. **Modify the model** to work with your specific data source:
   ```abap
   " Replace TVARVC with your table
   SELECT * FROM your_table INTO TABLE gt_alv.
   ```
3. **Customize the view** for your requirements:
   - Update field catalog customizations in `update_fcat()`
   - Modify layout settings in `init_layout()`
4. **Implement your business logic** in the controller:
   - Add custom event handlers
   - Implement specific business workflows

### Key Methods Documentation

#### Model Methods
- `constructor()`: Initializes model and loads data
- `get_row_by_index()`: Retrieves table row by index
- `init_data()`: Loads data from database

#### View Methods
- `constructor()`: Creates ALV container and grid
- `display()`: Shows ALV with data
- `refresh()`: Updates ALV display
- `init_fcat()`: Generates field catalog
- `update_fcat()`: Customizes field properties
- `init_layout()`: Sets layout properties
- `attach_handlers()`: Registers event handlers

#### Controller Methods
- `run()`: Starts the application
- `handle_double_click()`: Processes double-click events
- `handle_select()`: Selects all rows
- `handle_deselect()`: Deselects all rows

### Customization Examples

```abap
" Add custom field in update_fcat()
WHEN 'YOUR_FIELD'.
  <ls_fcat>-edit = abap_true.
  <ls_fcat>-hotspot = abap_true.
  <ls_fcat>-outputlen = 20.

" Add custom double-click handling
WHEN 'YOUR_FIELD'.
  " Your custom logic here
  go_view->info_message( 'Custom action executed' ).
```

### Requirements
- SAP NetWeaver 7.0 or higher
- ABAP Objects support
- ALV Grid functionality

---

## Русский

### Обзор
Данный проект реализует шаблон архитектурного паттерна "Модель-Представление-Контроллер" (MVC) для ABAP ALV (ABAP List Viewer) приложений. Шаблон обеспечивает четкое разделение ответственности и делает ALV приложения более поддерживаемыми и расширяемыми.

### Возможности
- **Архитектура Модель-Представление-Контроллер**: Четкое разделение логики данных, представления и потока управления
- **Интеграция с ALV**: Полная интеграция с SAP ALV Grid для отображения данных
- **Обработка событий**: Поддержка двойного клика, операций выбора/отмены выбора
- **Динамический каталог полей**: Автоматическая генерация каталога полей с возможностями настройки
- **Поддержка чекбоксов**: Встроенная функциональность чекбоксов для выбора строк
- **Обработка сообщений**: Интегрированное отображение сообщений об ошибках и информационных сообщений
- **Стабильное обновление**: Обновление ALV без потери текущей позиции прокрутки

### Структура проекта
```
z_alv_mvc_template.prog.abap          - Главная программа
z_alv_mvc_template_top.prog.abap      - Определения типов и объявления классов
z_alv_mvc_template_f00.prog.abap      - Реализация модели (lcl_mvc_model)
z_alv_mvc_template_f01.prog.abap      - Реализация представления (lcl_mvc_view)
z_alv_mvc_template_f02.prog.abap      - Реализация контроллера (lcl_mvc_controller)
z_alv_mvc_template_m00.prog.abap      - Реализации модулей
z_alv_mvc_template_s00.prog.abap      - Определения экранов
```

### Компоненты архитектуры

#### Модель (`lcl_mvc_model`)
Управляет данными и бизнес-логикой:
- **Хранение данных**: Управляет внутренней таблицей `gt_alv` с данными TVARVC
- **Доступ к данным**: Предоставляет методы для получения конкретных строк по индексу
- **Инициализация данных**: Загружает данные из таблиц базы данных

#### Представление (`lcl_mvc_view`)
Управляет пользовательским интерфейсом и представлением:
- **Отображение ALV**: Создает и настраивает элемент управления ALV Grid
- **Каталог полей**: Автоматически генерирует и настраивает определения полей
- **Управление макетом**: Обрабатывает настройки макета ALV (зебра-паттерн и т.д.)
- **Регистрация событий**: Настраивает обработчики событий для взаимодействия с пользователем
- **Отображение сообщений**: Показывает пользователям сообщения об ошибках и информационные сообщения

#### Контроллер (`lcl_mvc_controller`)
Координирует взаимодействие между Моделью и Представлением:
- **Поток приложения**: Управляет общим жизненным циклом приложения
- **Обработка событий**: Обрабатывает пользовательские события (двойной клик, выбор/отмена выбора)
- **Бизнес-логика**: Реализует специфическую для приложения логику и рабочие процессы

### Использование

1. **Скопируйте файлы шаблона** в вашу SAP систему
2. **Модифицируйте модель** для работы с вашим конкретным источником данных:
   ```abap
   " Замените TVARVC на вашу таблицу
   SELECT * FROM your_table INTO TABLE gt_alv.
   ```
3. **Настройте представление** под ваши требования:
   - Обновите настройки каталога полей в `update_fcat()`
   - Измените настройки макета в `init_layout()`
4. **Реализуйте вашу бизнес-логику** в контроллере:
   - Добавьте пользовательские обработчики событий
   - Реализуйте специфические бизнес-процессы

### Документация ключевых методов

#### Методы модели
- `constructor()`: Инициализирует модель и загружает данные
- `get_row_by_index()`: Получает строку таблицы по индексу
- `init_data()`: Загружает данные из базы данных

#### Методы представления
- `constructor()`: Создает ALV контейнер и сетку
- `display()`: Отображает ALV с данными
- `refresh()`: Обновляет отображение ALV
- `init_fcat()`: Генерирует каталог полей
- `update_fcat()`: Настраивает свойства полей
- `init_layout()`: Устанавливает свойства макета
- `attach_handlers()`: Регистрирует обработчики событий

#### Методы контроллера
- `run()`: Запускает приложение
- `handle_double_click()`: Обрабатывает события двойного клика
- `handle_select()`: Выбирает все строки
- `handle_deselect()`: Отменяет выбор всех строк

### Примеры настройки

```abap
" Добавить пользовательское поле в update_fcat()
WHEN 'YOUR_FIELD'.
  <ls_fcat>-edit = abap_true.
  <ls_fcat>-hotspot = abap_true.
  <ls_fcat>-outputlen = 20.

" Добавить пользовательскую обработку двойного клика
WHEN 'YOUR_FIELD'.
  " Ваша пользовательская логика здесь
  go_view->info_message( 'Выполнено пользовательское действие' ).
```

### Требования
- SAP NetWeaver 7.0 или выше
- Поддержка ABAP Objects
- Функциональность ALV Grid

---

## License / Лицензия

This project is provided as a template for educational and development purposes.
Данный проект предоставляется как шаблон для образовательных и разработческих целей.
