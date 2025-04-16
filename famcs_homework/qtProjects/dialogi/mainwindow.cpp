#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <functional>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // Dialogs
    searchDialog = new SearchDialog();
    sortDialog = new SortDialog();

    // Connect search dialog
    connect(searchDialog, &SearchDialog::SignalModel, this, &MainWindow::slotModel);
    connect(this, &MainWindow::SignalModel, searchDialog, &SearchDialog::slotModel);

    // Connect sort dialog
    connect(sortDialog, &SortDialog::SignalSortType, this, &MainWindow::slotSortType);
    connect(this, &MainWindow::SignalSort, sortDialog, &SortDialog::slotSort);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::PrintComputerItems() {
    ui->output->setText("");
    std::string result{};
    for(auto& item : computerItems) {
        result += item.to_string();
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::on_readFileButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    ReadFile(computerItems, file_name.toStdString());
    PrintComputerItems();
}


void MainWindow::on_saveFileButton_clicked()
{
    std::string result{};
    for(auto& item : computerItems) {
        result += item.to_string();
    }
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    std::ofstream fout(file_name.toStdString());
    fout << result;
}


void MainWindow::on_addItemButton_clicked()
{
    ComputerItem item(
                ui->editType->text().toStdString(),
                ui->editCompany->text().toStdString(),
                ui->editModel->text().toStdString(),
                ui->editParams->text().toStdString(),
                ui->editCost->text().toDouble(),
                ui->checkInStore->isChecked()
                );
    computerItems.push_back(item);
    PrintComputerItems();
}


void MainWindow::on_searchButton_clicked()
{
    searchDialog->show();
}

void MainWindow::slotModel(QString qstr) {
    std::string str = qstr.toStdString();
    std::sort(computerItems.begin(), computerItems.end(), [](const ComputerItem& a, const ComputerItem& b) {
        return a.Model() < b.Model();
    });
    auto items_begin = std::find_if(
                computerItems.begin(),
                computerItems.end(),
                [str](ComputerItem& a) {
                    return a.Model() == str;
                }
    );
    auto items_end = std::find_if(
                items_begin,
                computerItems.end(),
                [str](ComputerItem& a) {
                    return a.Model() != str;
                }
    );

    std::string result = "";
    for (auto i = items_begin; i != items_end; ++i) {
        result += (*i).to_string();
    }
    emit SignalModel((new QString)->fromStdString(result));
}

void MainWindow::slotSortType(QString qstr) {
    std::function<bool(ComputerItem&, ComputerItem&)> comp;
    if (qstr == "Type") {
        comp = [](ComputerItem& a, ComputerItem& b){
            return a.Type() < b.Type();
        };
    } else if (qstr == "Company") {
        comp = [](ComputerItem& a, ComputerItem& b){
            return a.Company() < b.Company();
        };
    } else if (qstr == "Cost"){
        comp = [](ComputerItem& a, ComputerItem& b){
            return a.Cost() < b.Cost();
        };
    }

    std::sort(computerItems.begin(), computerItems.end(), comp);
    std::string result = "";
    for (auto& item : computerItems) {
        result += item.to_string();
    }
    emit SignalSort((new QString)->fromStdString(result));
}


void MainWindow::on_sortButton_clicked()
{
    sortDialog->show();
}

