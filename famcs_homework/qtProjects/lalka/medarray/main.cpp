#include <QApplication>
#include <QMainWindow>
#include <QTableWidget>
#include <QTableWidgetItem>
#include <QFileDialog>
#include <QMessageBox>
#include <fstream>
#include "medarray.h"
#include "ui_mainwindow.h" // Подключаем заголовочный файл сгенерированный из вашего .ui файла

void LoadMedsFromFile(MedArray& medArray, QTableWidget* tableWidget) {
    QString fileName = QFileDialog::getOpenFileName(nullptr, "Open Medications File", "", "Text Files (*.txt);;All Files (*)");
    if (fileName.isEmpty())
        return;

    std::ifstream file(fileName.toStdString());
    if (!file.is_open()) {
        QMessageBox::warning(nullptr, "Error", "Failed to open file.");
        return;
    }

    medArray.GetMeds().clear(); // Очищаем текущие данные в medArray перед загрузкой новых
    medArray.ReadMeds(file);

    tableWidget->setRowCount(static_cast<int>(medArray.GetMeds().size()));
    int row = 0;
    for (const auto& med : medArray.GetMeds()) {
        tableWidget->setItem(row, 0, new QTableWidgetItem(med.name));
        tableWidget->setItem(row, 1, new QTableWidgetItem(med.expiryDate));
        tableWidget->setItem(row, 2, new QTableWidgetItem(med.section));
        tableWidget->setItem(row, 3, new QTableWidgetItem(QString::number(med.price)));
        row++;
    }

}


void LoadPricesFromFile(MedArray& priceArray, QTableWidget* tableWidget) {
    QString fileName = QFileDialog::getOpenFileName(nullptr, "Open Prices File", "", "Text Files (*.txt);;All Files (*)");
    if (fileName.isEmpty())
        return;

    std::ifstream file(fileName.toStdString());
    if (!file.is_open()) {
        QMessageBox::warning(nullptr, "Error", "Failed to open file.");
        return;
    }

    priceArray.GetMeds().clear(); // Очищаем текущие данные в priceArray перед загрузкой новых
    MedItem item;
    while (file >> item.name >> item.expiryDate >> item.price) {
        item.section[0] = '\0'; // Устанавливаем пустую строку для section
        item.amount = 0; // Устанавливаем amount в 0
        priceArray.GetMeds().push_back(item);
    }

    file.close(); // Закрываем файл после чтения

    tableWidget->setRowCount(static_cast<int>(priceArray.GetMeds().size()));
    int row = 0;
    for (const auto& price : priceArray.GetMeds()) {
        tableWidget->setItem(row, 0, new QTableWidgetItem(price.name));
        tableWidget->setItem(row, 1, new QTableWidgetItem(price.expiryDate));
        tableWidget->setItem(row, 2, new QTableWidgetItem(QString::number(price.price)));
        row++;
    }
}

void CombineAndSave(MedArray& medArray, MedArray& priceArray, QTableWidget* tableWidget) {
    std::vector<MedItem> combined;

    // Пройти по всем медпрепаратам
    for (const auto& med : medArray.GetMeds()) {
        bool found = false;
        // Пройти по всем ценам
        for (const auto& price : priceArray.GetMeds()) {
            // Если найдено совпадение по имени и дате истечения срока годности
            if (std::strcmp(med.name, price.name) == 0 && std::strcmp(med.expiryDate, price.expiryDate) == 0) {
                MedItem combinedItem = med;
                combinedItem.price = price.price; // Установить цену
                combined.push_back(combinedItem);
                found = true;
                break;
            }
        }
        if (!found) {
            combined.push_back(med); // Если не найдено, добавить медпрепарат как есть
        }
    }

    // Добавить элементы, которые есть в priceArray, но отсутствуют в medArray
    for (const auto& price : priceArray.GetMeds()) {
        auto it = std::find_if(combined.begin(), combined.end(), [&price](const MedItem& item) {
            return std::strcmp(item.name, price.name) == 0 && std::strcmp(item.expiryDate, price.expiryDate) == 0;
        });
        if (it == combined.end()) {
            MedItem combinedItem = price;
            std::strcpy(combinedItem.section, "Unknown"); // Установить секцию как "Unknown"
            combinedItem.amount = 0; // Установить количество в 0
            combined.push_back(combinedItem);
        }
    }

    std::sort(combined.begin(), combined.end());
    tableWidget->setRowCount(static_cast<int>(combined.size()));
    int row = 0;
    for (const auto& item : combined) {
        tableWidget->setItem(row, 0, new QTableWidgetItem(item.name));
        tableWidget->setItem(row, 1, new QTableWidgetItem(item.expiryDate));
        tableWidget->setItem(row, 2, new QTableWidgetItem(item.section));
        tableWidget->setItem(row, 3, new QTableWidgetItem(QString::number(item.price)));
        tableWidget->setItem(row, 4, new QTableWidgetItem(QString::number(item.amount)));
        row++;
    }

    QString fileName = QFileDialog::getSaveFileName(nullptr, "Save Combined Results", "result.txt", "Text Files (*.txt);;All Files (*)");
    if (fileName.isEmpty())
        return;

    std::ofstream file(fileName.toStdString());
    if (!file.is_open()) {
        QMessageBox::warning(nullptr, "Error", "Failed to save file.");
        return;
    }

    for (const auto& item : combined) {
        file << item.name << " " << item.expiryDate << " " << item.section << " " << item.price << " " << item.amount << std::endl;
    }
}



void SearchByExpiryDate(const MedArray& medArray, const QString& targetDateString) {
    std::vector<MedItem> results;
    medArray.FindMedsByDate(targetDateString.toUtf8().constData(), results, true); // Find expired meds

    if (!results.empty()) {
        QString message = "Medications with expiry date before " + targetDateString + ":\n";
        for (const auto& item : results) {
            message += QString("%1, %2, %3, %4, %5\n").arg(item.name).arg(item.expiryDate).arg(item.section).arg(item.price).arg(item.amount);
        }
        QMessageBox::information(nullptr, "Search Results", message);
    } else {
        QMessageBox::information(nullptr, "Search Results", "No medications found with expiry date before specified date.");
    }
}




int main(int argc, char *argv[]) {
    QApplication a(argc, argv);

    QMainWindow mainWindow; // Объявляем объект mainWindow
    Ui::MainWindow ui; // Создаем экземпляр класса Ui::MainWindow
    ui.setupUi(&mainWindow); // Настраиваем интерфейс для mainWindow

    MedArray medArray;
    MedArray priceArray;

    QObject::connect(ui.pushButton, &QPushButton::clicked, [&]() {
        LoadMedsFromFile(medArray, ui.tableWidget);
    });

    QObject::connect(ui.pushButton_2, &QPushButton::clicked, [&]() {
        LoadPricesFromFile(priceArray, ui.tableWidget_2);
    });

    QObject::connect(ui.pushButton_3, &QPushButton::clicked, [&]() {
        CombineAndSave(medArray, priceArray, ui.tableWidget_3);
    });

    QObject::connect(ui.pushButton_4, &QPushButton::clicked, [&]() {
        QString targetDate = ui.lineEdit->text();
        SearchByExpiryDate(medArray, targetDate);
    });
    mainWindow.show(); // Отображаем окно
    return a.exec();
}
